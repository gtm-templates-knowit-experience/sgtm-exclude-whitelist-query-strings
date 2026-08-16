___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Exclude or Whitelist Query String Parameters",
  "description": "Exclude or Whitelist Query String Parameters from page_location or any Variable with a valid URL-parameter. Parameters can be Removed or Redacted. Output can be with or without URL/Path.",
  "categories": [
    "UTILITY",
    "TAG_MANAGEMENT",
    "ANALYTICS"
  ],
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "urlInput",
    "displayName": "Select URL Source",
    "macrosInSelect": true,
    "selectItems": [
      {
        "value": "urlInputDefault",
        "displayValue": "page_location"
      },
      {
        "value": "page_referrer",
        "displayValue": "page_referrer"
      },
      {
        "value": "link_url",
        "displayValue": "link_url"
      }
    ],
    "simpleValueType": true,
    "defaultValue": "urlInputDefault",
    "help": "Enter a URL variable. \u003cstrong\u003epage_location\u003c/strong\u003e is predefined, but you can choose any variable with a valid URL.",
    "alwaysInSummary": true
  },
  {
    "type": "GROUP",
    "name": "outputGroup",
    "displayName": "Output Result",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "SELECT",
        "name": "outputResult",
        "displayName": "Parameter Output Result",
        "selectItems": [
          {
            "value": "url",
            "displayValue": "URL Source with Parameters"
          },
          {
            "value": "path",
            "displayValue": "Source Path with Parameters"
          },
          {
            "value": "paramq",
            "displayValue": "Parameters with Question Mark"
          },
          {
            "value": "param",
            "displayValue": "Parameters without Question Mark"
          },
          {
            "value": "urlwoq",
            "displayValue": "URL Source without Parameters"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "url",
        "help": "Output Result can be:\u003cbr/\u003e\n \u003cb\u003eURL Source with Parameters:\u003c/b\u003e https://domain.com/path?query\u003dsomething\n\u003cbr /\u003e \u003cb\u003eSource Path with Query:\u003c/b\u003e /path?query\u003dsomething\n \u003cbr /\u003e\u003cb\u003eParameters with Question Mark:\u003c/b\u003e ?query\u003dsomething\n\u003cbr /\u003e\u003cb\u003eParameters without Question Mark:\u003c/b\u003e query\u003dsomething\n\u003cbr /\u003e \u003cb\u003eURL Source without Parameters:\u003c/b\u003e https://domain.com/path",
        "alwaysInSummary": true
      },
      {
        "type": "CHECKBOX",
        "name": "redactEmail",
        "checkboxText": "Redact Email Adresses",
        "simpleValueType": true,
        "enablingConditions": [
          {
            "paramName": "outputResult",
            "paramValue": "urlwoq",
            "type": "NOT_EQUALS"
          }
        ],
        "help": "Redacts possible email adresses independent of the Parameter matching if found in a parameter. \u003cbr/\u003e\u003cbr/\u003e Also \u003cstrong\u003eWhitelisted parameteres\u003c/strong\u003e will be checked.\u003cbr/\u003e\u003cbr/\u003e If an email is found, the email adress will be replaced with \u003cstrong\u003e[EMAIL REDACTED]\u003c/strong\u003e."
      },
      {
        "type": "CHECKBOX",
        "name": "paramLowerCase",
        "checkboxText": "Force lowercase on parameters",
        "simpleValueType": true,
        "help": "Converts parameter keys and values to lowercase to ensure data consistency. Case-sensitive parameters can be added to an exclusion list below.",
        "alwaysInSummary": true,
        "enablingConditions": [
          {
            "paramName": "outputResult",
            "paramValue": "urlwoq",
            "type": "NOT_EQUALS"
          }
        ]
      },
      {
        "type": "RADIO",
        "name": "lowercaseIncludeChoice",
        "displayName": "Lowercase Setting",
        "radioItems": [
          {
            "value": "includeSpecific",
            "displayValue": "Lowercase specific parameters"
          },
          {
            "value": "includeAll",
            "displayValue": "Lowercase all parameters"
          }
        ],
        "simpleValueType": true,
        "enablingConditions": [
          {
            "paramName": "paramLowerCase",
            "paramValue": true,
            "type": "EQUALS"
          }
        ],
        "help": "Choose if ALL parameters should be lowercased, or only selected."
      },
      {
        "type": "RADIO",
        "name": "lowercaseScope",
        "displayName": "Lowercase Scope",
        "radioItems": [
          {
            "value": "valuesOnly",
            "displayValue": "Lowercase parameter values"
          },
          {
            "value": "valuesAndNames",
            "displayValue": "Lowercase parameter values and names"
          }
        ],
        "simpleValueType": true,
        "enablingConditions": [
          {
            "paramName": "paramLowerCase",
            "paramValue": true,
            "type": "EQUALS"
          }
        ],
        "help": "\u003cb\u003eLowercase parameter values:\u003c/b\u003e This will lowercase only the parameter value (e.g. \u003ci\u003eUTM_source\u003dFACEBOOK\u003c/i\u003e -\u003e \u003ci\u003eUTM_source\u003dfacebook\u003c/i\u003e\n\u003cbr/\u003e\u003cbr/\u003e\n\u003cb\u003eLowercase parameter values and names:\u003c/b\u003e This will lowercase bot parameter name and parameter value (e.g. \u003ci\u003eUTM_source\u003dFACEBOOK\u003c/i\u003e -\u003e \u003ci\u003eutm_source\u003dfacebook\u003c/i\u003e"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "groupChoice",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "RADIO",
        "name": "paramInputChoice",
        "displayName": "Whitelist or Exclude Query Parameters",
        "radioItems": [
          {
            "value": "paramWhitelist",
            "displayValue": "Keep only specified parameters (Whitelist)"
          },
          {
            "value": "paramExclude",
            "displayValue": "Remove specified parameters (Exclude)"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "paramWhitelist",
        "help": "Choose if the Parameters you add should be \u003cb\u003eWhitelisted\u003c/b\u003e (keep) or \u003cb\u003eExcluded\u003c/b\u003e (removed)."
      },
      {
        "type": "SELECT",
        "name": "removeRedactChoice",
        "displayName": "Remove or Redact Parameter Value",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "paramRemove",
            "displayValue": "Remove"
          },
          {
            "value": "paramRedact",
            "displayValue": "Redact"
          }
        ],
        "simpleValueType": true,
        "subParams": [
          {
            "type": "TEXT",
            "name": "paramRedactText",
            "displayName": "Redact Replacement Text",
            "simpleValueType": true,
            "enablingConditions": [
              {
                "paramName": "removeRedactChoice",
                "paramValue": "paramRedact",
                "type": "EQUALS"
              }
            ],
            "defaultValue": "[REDACTED]",
            "help": "Select which text to use to \u003cstrong\u003ereplace\u003c/strong\u003e the redacted parameter \u003cstrong\u003evalue\u003c/strong\u003e. As standard \u003cstrong\u003e[REDACTED]\u003c/strong\u003e is used."
          }
        ],
        "help": "Choose if Parameters should be \u003cb\u003eRemoved\u003c/b\u003e, or if the Parameter value should be \u003cb\u003eRedacted\u003c/b\u003e."
      },
      {
        "type": "LABEL",
        "name": "excludeInfo",
        "displayName": "Add \u003cb\u003eQuery Parameters\u003c/b\u003e for \u003cb\u003eExclusion\u003c/b\u003e",
        "enablingConditions": [
          {
            "paramName": "paramInputChoice",
            "paramValue": "paramExclude",
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "LABEL",
        "name": "whitelistInfo",
        "displayName": "Add \u003cb\u003eQuery Parameters\u003c/b\u003e for \u003cb\u003eWhitelisting\u003c/b\u003e",
        "enablingConditions": [
          {
            "paramName": "paramInputChoice",
            "paramValue": "paramWhitelist",
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "SELECT",
        "name": "inputMethod",
        "displayName": "Select Add Parameter Input",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "table",
            "displayValue": "Add Parameters to Table"
          },
          {
            "value": "textfield",
            "displayValue": "Add Parameters to Text Field"
          }
        ],
        "simpleValueType": true
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "queryParamTable",
        "displayName": "Parameter Table",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Query Parameter",
            "name": "queryParam",
            "type": "TEXT",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ],
            "isUnique": true
          },
          {
            "defaultValue": "",
            "displayName": "Description",
            "name": "description",
            "type": "TEXT"
          }
        ],
        "newRowButtonText": "Add Parameter",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "enablingConditions": [
          {
            "paramName": "inputMethod",
            "paramValue": "textfield",
            "type": "NOT_EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "queryParamText",
        "displayName": "Parameter Text Field",
        "simpleValueType": true,
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "textAsList": true,
        "help": "Add \u003cstrong\u003eone\u003c/strong\u003e parameter per line",
        "enablingConditions": [
          {
            "paramName": "inputMethod",
            "paramValue": "textfield",
            "type": "EQUALS"
          }
        ],
        "alwaysInSummary": true,
        "lineCount": 10
      },
      {
        "type": "GROUP",
        "name": "includeFromLowercasingGroup",
        "groupStyle": "NO_ZIPPY",
        "subParams": [
          {
            "type": "LABEL",
            "name": "includeFromLowercasingLabel",
            "displayName": "Add \u003cb\u003eQuery Parameters\u003c/b\u003e for \u003cb\u003eLowercasing\u003c/b\u003e"
          },
          {
            "type": "SELECT",
            "name": "includeFromLowercasingInputMethod",
            "macrosInSelect": false,
            "selectItems": [
              {
                "value": "includeTable",
                "displayValue": "Add Parameters to Table"
              },
              {
                "value": "includeTextfield",
                "displayValue": "Add Parameters to Text Field"
              }
            ],
            "simpleValueType": true
          },
          {
            "type": "SIMPLE_TABLE",
            "name": "lowercaseIncludeTable",
            "displayName": "Parameter Table",
            "simpleTableColumns": [
              {
                "defaultValue": "",
                "displayName": "Query Parameter",
                "name": "queryParam",
                "type": "TEXT",
                "isUnique": true,
                "valueValidators": []
              },
              {
                "defaultValue": "",
                "displayName": "Description",
                "name": "description",
                "type": "TEXT"
              }
            ],
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ],
            "newRowButtonText": "Add Parameter",
            "enablingConditions": [
              {
                "paramName": "includeFromLowercasingInputMethod",
                "paramValue": "includeTable",
                "type": "EQUALS"
              }
            ]
          },
          {
            "type": "TEXT",
            "name": "lowercaseIncludeText",
            "displayName": "Parameter Text Field",
            "simpleValueType": true,
            "textAsList": true,
            "enablingConditions": [
              {
                "paramName": "includeFromLowercasingInputMethod",
                "paramValue": "includeTextfield",
                "type": "EQUALS"
              }
            ],
            "lineCount": 10,
            "help": "Add \u003cstrong\u003eone\u003c/strong\u003e parameter per line"
          }
        ],
        "enablingConditions": [
          {
            "paramName": "lowercaseIncludeChoice",
            "paramValue": "includeSpecific",
            "type": "EQUALS"
          }
        ]
      }
    ],
    "enablingConditions": [
      {
        "paramName": "outputResult",
        "paramValue": "urlwoq",
        "type": "NOT_EQUALS"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_SERVER___

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


___SERVER_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_event_data",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "page_location"
              },
              {
                "type": 1,
                "string": "page_referrer"
              },
              {
                "type": 1,
                "string": "link_url"
              }
            ]
          }
        },
        {
          "key": "eventDataAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 8/14/2021, 6:18:55 PM


