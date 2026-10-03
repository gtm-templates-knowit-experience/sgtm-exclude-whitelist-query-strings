const getEventData = require('getEventData');
const parseUrl = require('parseUrl');
const decodeUriComponent = require('decodeUriComponent');
const encodeUriComponent = require('encodeUriComponent');
const createRegex = require('createRegex');
const makeString = require('makeString');

// Helper 1: Read either list field and normalize entries
function readList(text, table, lowercase) {
  const items = text && text.length ? text : (table || []).map(row => row.queryParam);
  return items
    .filter(item => item !== undefined && item !== null)
    .map(item => {
      const value = makeString(item).trim();
      return lowercase ? value.toLowerCase() : value;
    })
    .filter(item => item !== '');
}

// Helper 2: Handle standard + to space decoding
function decodeForm(value) {
  return decodeUriComponent(value.split('+').join(' '));
}

let urlString = data.urlInput;
if (urlString === 'urlInputDefault') urlString = 'page_location';
if (['page_location', 'page_referrer', 'link_url'].indexOf(urlString) !== -1) {
  urlString = getEventData(urlString);
}
if (!urlString) return undefined;

const url = parseUrl(urlString);
if (!url) return undefined;
const base = url.href.split('#')[0].split('?')[0];
const hash = url.hash || '';
if (data.outputResult === 'urlwoq') return base + hash;

const emailRegex = data.redactEmail ? createRegex('[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}') : null;
if (data.redactEmail && emailRegex === null) return undefined;

const filterList = readList(data.queryParamText, data.queryParamTable, false);
const lowercaseAll = data.lowercaseIncludeChoice === 'includeAll';
const lowercaseList = data.paramLowerCase && !lowercaseAll ? readList(data.lowercaseIncludeText, data.lowercaseIncludeTable, true) : [];

// Pre-normalize and lowercase the backup parameters once during setup
const restoreTable = data.restoreClickIds && data.clickIdRestoreTable ? data.clickIdRestoreTable.map(row => ({
  backupParam: row.backupParam ? makeString(row.backupParam).trim().toLowerCase() : '',
  originalParam: row.originalParam ? makeString(row.originalParam).trim() : ''
})) : [];

// Safely handle numeric 0, false, or null as redaction text
const redactText = data.paramRedactText !== undefined && data.paramRedactText !== null ? makeString(data.paramRedactText) : '';

// Decode everything before processing, so later originals retain priority.
const search = url.search || '';
const entries = (search.indexOf('?') === 0 ? search.substring(1) : search).split('&');
const params = [];
for (let i = 0; i < entries.length; i++) {
  const entry = entries[i];
  if (!entry) continue;
  const at = entry.indexOf('=');
  const key = at === 0 ? '' : decodeForm(at < 0 ? entry : entry.substring(0, at));
  const value = at < 0 ? undefined : decodeForm(entry.substring(at + 1));
  if (key === undefined || (at >= 0 && value === undefined)) return undefined;
  params.push({ key: key, value: value });
}

const existingKeys = params.map(param => param.key);
const existingKeysLower = params.map(param => param.key.toLowerCase());
const restoredTargets = [];
const output = [];

for (let i = 0; i < params.length; i++) {
  let key = params[i].key;
  let value = params[i].value;
  let dropBackup = false;
  
  // Calculate lowercase key once per parameter
  const lowerKey = key.toLowerCase();

  for (let j = 0; j < restoreTable.length; j++) {
    const row = restoreTable[j];
    
    // Case-insensitive match for the backup parameter
    if (!row.backupParam || lowerKey !== row.backupParam) continue;
    
    let targetExists = false;
    
    // Check case-insensitively only if the target name is configured to be lowercased
    if (data.paramLowerCase && data.lowercaseScope === 'valuesAndNames' && (lowercaseAll || lowercaseList.indexOf(row.originalParam.toLowerCase()) !== -1)) {
      targetExists = existingKeysLower.indexOf(row.originalParam.toLowerCase()) !== -1;
    } else {
      targetExists = existingKeys.indexOf(row.originalParam) !== -1;
    }

    // Restore if valid and missing, otherwise destroy it.
    if (value !== undefined && value !== '' && !targetExists && restoredTargets.indexOf(row.originalParam) === -1) {
      key = row.originalParam;
      restoredTargets.push(key);
    } else {
      dropBackup = true; 
    }
    break;
  }

  // If it was an unused backup, drop it completely
  if (dropBackup) continue;

  // Strict Filter Check
  const listed = filterList.indexOf(key) !== -1;
  const filtered = data.paramInputChoice === 'paramWhitelist' ? !listed : data.paramInputChoice === 'paramExclude' ? listed : false;
  if (filtered && data.removeRedactChoice !== 'paramRedact') continue;

  if (data.paramLowerCase && (lowercaseAll || lowercaseList.indexOf(lowerKey) !== -1)) {
    if (data.lowercaseScope === 'valuesAndNames') key = lowerKey;
    if (value !== undefined) value = value.toLowerCase();
  }
  
  if (filtered) {
    value = redactText;
  } else if (emailRegex && value !== undefined && value.match(emailRegex)) {
    value = '[EMAIL REDACTED]';
  }

  output.push(encodeUriComponent(key) + (value === undefined ? '' : '=' + encodeUriComponent(value)));
}

const query = output.join('&');
const queryWithMark = output.length ? '?' + query : '';

switch (data.outputResult) {
  case 'url': return base + queryWithMark + hash;
  case 'path': return (url.pathname || '/') + queryWithMark + hash;
  case 'paramq': return queryWithMark;
  case 'param': return query;
}
return undefined;