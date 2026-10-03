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
  "description": "Exclude or Allowlist query string parameters to prevent PII leaks. Remove or redact values, restore stripped Click IDs, selectively lowercase, and output clean URLs or paths",
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
        "name": "restoreClickIds",
        "checkboxText": "Restore Click IDs from backup parameters",
        "simpleValueType": true,
        "help": "Browsers like Safari sometimes strip known click IDs like gclid. By passing a custom backup parameter from your ads, this tool can rename it back to the original parameter so your tracking tags function normally.",
        "enablingConditions": [
          {
            "paramName": "outputResult",
            "paramValue": "urlwoq",
            "type": "NOT_EQUALS"
          }
        ]
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
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "clickIdRestoreTable",
        "displayName": "Restore Click IDs from backup parameters",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Backup Parameter Name",
            "name": "backupParam",
            "type": "TEXT",
            "valueHint": "backup_gclid",
            "isUnique": false
          },
          {
            "defaultValue": "",
            "displayName": "Original Parameter Name",
            "name": "originalParam",
            "type": "TEXT",
            "valueHint": "gclid"
          }
        ],
        "enablingConditions": [
          {
            "paramName": "restoreClickIds",
            "paramValue": true,
            "type": "EQUALS"
          }
        ],
        "help": "Map your custom backup parameters (e.g., \u003ci\u003ebackup_gclid\u003c/i\u003e) to their original names (e.g., \u003ci\u003egclid\u003c/i\u003e).\n\u003cbr /\u003e\u003cbr /\u003e\n\u003cb\u003eNote:\u003c/b\u003e If you are using an Whitelist, you must whitelist the original parameter name.",
        "newRowButtonText": "Add Click ID",
        "valueValidators": []
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


