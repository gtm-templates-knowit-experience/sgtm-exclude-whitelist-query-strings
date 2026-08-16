const getEventData = require('getEventData');
const parseUrl = require('parseUrl');
const decodeUriComponent = require('decodeUriComponent');
const encodeUriComponent = require('encodeUriComponent');
const createRegex = require('createRegex'); 
const makeString = require('makeString'); 

// 1. URL Source Selection
let urlString;
if (data.urlInput === 'urlInputDefault' || data.urlInput === 'page_location') {
  urlString = getEventData('page_location');
} else if (data.urlInput === 'page_referrer') {
  urlString = getEventData('page_referrer');
} else if (data.urlInput === 'link_url') {
  urlString = getEventData('link_url');
} else {
  urlString = data.urlInput; // Custom Variable Input
}

if (!urlString) {
  return undefined;
}

let urlInputParsed = parseUrl(urlString);

if (urlInputParsed) {
  let originalHref = urlInputParsed.href;
  
  // 2. Extract Hash Fragment
  let hashIndex = originalHref.indexOf('#');
  let urlWithoutHash = originalHref;
  let hashString = "";
  
  if (hashIndex > -1) {
    urlWithoutHash = originalHref.substring(0, hashIndex);
    hashString = originalHref.substring(hashIndex); 
  }
  
  // Compile Regex using sGTM API
  const emailRegex = createRegex('[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}', 'gi');

  if (data.outputResult === 'urlwoq') {
    return urlWithoutHash.split("?")[0] + hashString;
  } else {
    let urlSplit = urlWithoutHash.split("?");
    let queryStringNew = [];
    
    if (urlSplit.length > 1 && urlSplit[1] !== "") {
      let queryURL = urlSplit.slice(1).join("?").split("&");
      const redactText = data.paramRedactText || '';
      
      // Whitelist/Exclude Config Setup (Preserves exact case for strict matching)
      let paramQuery = [];
      if (data.queryParamText && data.queryParamText.length > 0) {
        paramQuery = data.queryParamText.slice();
      } else if (data.queryParamTable && data.queryParamTable.length > 0) {
        paramQuery = data.queryParamTable.map(x => x.queryParam);
      }
      
      paramQuery = paramQuery
        .filter(item => item !== undefined)
        .map(item => makeString(item).trim())
        .filter(item => item !== '');

      // Single Lowercase Allowlist Setup
      let lowercaseIncludeList = [];
      let lowercaseAll = data.lowercaseIncludeChoice === 'includeAll';

      if (data.paramLowerCase && !lowercaseAll) {
        if (data.lowercaseIncludeText && data.lowercaseIncludeText.length > 0) {
          lowercaseIncludeList = data.lowercaseIncludeText.slice();
        } else if (data.lowercaseIncludeTable && data.lowercaseIncludeTable.length > 0) {
          lowercaseIncludeList = data.lowercaseIncludeTable.map(x => x.queryParam);
        }
        
        // Lowercased in the background for safe matching
        lowercaseIncludeList = lowercaseIncludeList
          .filter(item => item !== undefined)
          .map(item => makeString(item).trim().toLowerCase()) 
          .filter(item => item !== '');
      }

      for (let query of queryURL) {
        if (!query) continue; 

        let parts = query.split("=");
        let rawKey = parts[0];
        let hasValue = parts.length > 1;
        let rawValue = hasValue ? parts.slice(1).join("=") : undefined; 
        
        let decodedKey = rawKey === '' ? '' : decodeUriComponent(rawKey);
        let decodedValue = hasValue ? decodeUriComponent(rawValue) : undefined;
        
        // Fail closed on malformed parameters
        if (decodedKey === undefined || (hasValue && decodedValue === undefined)) {
          continue; 
        }

        const lowerDecodedKey = decodedKey.toLowerCase();

        // 1. Core URL Filtering logic (Strict exact match to the whitelist, e.g., "ScCid")
        const isListed = paramQuery.indexOf(decodedKey) > -1;
        
        // 2. Determine if this parameter should be lowercased
        let applyLowercase = false;
        if (data.paramLowerCase) {
          if (lowercaseAll || lowercaseIncludeList.indexOf(lowerDecodedKey) > -1) {
            applyLowercase = true;
          }
        }

        let outputKey = decodedKey;
        let outputValue = decodedValue;
        
        // 3. Apply the chosen Lowercase Scope
        if (applyLowercase) {
          // If the user chose to lowercase BOTH values and names
          if (data.lowercaseScope === 'valuesAndNames') {
            outputKey = outputKey.toLowerCase();
          }
          // Values are always lowercased if the parameter is targeted
          if (outputValue !== undefined) {
            outputValue = outputValue.toLowerCase();
          }
        }

        // Apply Email Redaction
        if (data.redactEmail && outputValue !== undefined && emailRegex !== null) {
          outputValue = outputValue.replace(emailRegex, '[EMAIL REDACTED]');
        }

        // Whitelist / Exclude Action Logic
        let keepParam = true;
        let redactParam = false;

        if (data.paramInputChoice === "paramWhitelist") {
          if (!isListed) {
            if (data.removeRedactChoice === "paramRedact") redactParam = true;
            else keepParam = false;
          }
        } else if (data.paramInputChoice === "paramExclude") {
          if (isListed) {
            if (data.removeRedactChoice === "paramRedact") redactParam = true;
            else keepParam = false;
          }
        }

        if (!keepParam) {
          continue;
        }

        if (redactParam) {
          queryStringNew.push(encodeUriComponent(outputKey) + "=" + encodeUriComponent(redactText));
          continue;
        }

        // Optimization: Preserve the raw parameter if no transformations occurred
        const isChanged = (outputKey !== decodedKey) || (outputValue !== decodedValue);

        if (!isChanged) {
          queryStringNew.push(query); 
        } else {
          let encodedKey = encodeUriComponent(outputKey);
          let encodedValue = outputValue !== undefined ? encodeUriComponent(outputValue) : undefined;
          queryStringNew.push(hasValue ? encodedKey + "=" + encodedValue : encodedKey);
        }
      }
    }
    
    const questionMark = queryStringNew.length > 0 ? '?' : '';
    
    // 3. Re-append the parts
    switch (data.outputResult) {
      case 'url':
        return urlSplit[0] + questionMark + queryStringNew.join('&') + hashString;
      case 'path':
        return urlInputParsed.pathname + questionMark + queryStringNew.join('&') + hashString;
      case 'paramq':
        return questionMark + queryStringNew.join('&'); 
      case 'param':
        return queryStringNew.join('&'); 
    }
  }
}
