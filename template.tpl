﻿___TERMS_OF_SERVICE___

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
"categories": ["UTILITY","TAG_MANAGEMENT","ANALYTICS"],
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "urlInput",
    "displayName": "Page URL",
    "macrosInSelect": true,
    "selectItems": [
      {
        "value": "urlInputDefault",
        "displayValue": "page_location"
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
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "url",
            "displayValue": "Page URL with Parameters"
          },
          {
            "value": "path",
            "displayValue": "Page Path with Parameters"
          },
          {
            "value": "paramq",
            "displayValue": "Parameters with Question Mark"
          },
          {
            "value": "param",
            "displayValue": "Parameters without Question Mark"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "url",
        "help": "Output Result can be \u003cb\u003ePage URL with Parameters\u003c/b\u003e (https://domain.com/path?query\u003dsomething), \u003cb\u003ePage Path with Query\u003c/b\u003e (/path?query\u003dsomething), \u003cb\u003eParameters with Question Mark\u003c/b\u003e (?query\u003dsomething) or \u003cb\u003eParameters without Question Mark\u003c/b\u003e (query\u003dsomething).",
        "alwaysInSummary": false
      },
      {
        "type": "CHECKBOX",
        "name": "paramLowerCase",
        "checkboxText": "Lowercase Parameters",
        "simpleValueType": true,
        "help": "Parameter matching is by default \u003cb\u003eCase Sensitive\u003c/b\u003e. By ticking this box, all incoming parameters will be \u003cb\u003elowercased\u003c/b\u003e.",
        "alwaysInSummary": true
      }
    ]
  },
  {
    "type": "RADIO",
    "name": "paramInputChoice",
    "displayName": "Whitelist or Exclude Query Parameters",
    "radioItems": [
      {
        "value": "paramWhitelist",
        "displayValue": "Whitelist Parameters"
      },
      {
        "value": "paramExclude",
        "displayValue": "Exclude Parameters"
      }
    ],
    "simpleValueType": true,
    "defaultValue": "paramWhitelist",
    "help": "Choose if the Parameters you add should be \u003cb\u003eWhitelisted\u003c/b\u003e (included) or \u003cb\u003eExcluded\u003c/b\u003e."
  },
  {
    "type": "SELECT",
    "name": "removeRedactChoice",
    "displayName": "Remove or Redact Parameter Value",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "paramRedact",
        "displayValue": "Redact"
      },
      {
        "value": "paramRemove",
        "displayValue": "Remove"
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
    "type": "SIMPLE_TABLE",
    "name": "queryParamTable",
    "displayName": "",
    "simpleTableColumns": [
      {
        "defaultValue": "",
        "displayName": "",
        "name": "queryParam",
        "type": "TEXT",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      }
    ],
    "newRowButtonText": "Add Parameter",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_SERVER___

const decodeUri = require('decodeUri');
const getEventData = require('getEventData');
const parseUrl = require('parseUrl');

let urlInput = parseUrl(data.urlInput === 'urlInputDefault' ? getEventData('page_location') : data.urlInput);
if(urlInput) {
	const fullURL = decodeUri(urlInput.href);
	let urlSplit = fullURL.split("?");
	let questionMark = '';
	let queryStringNew = [];
	
	if(fullURL.indexOf("?") > -1) {
		let queryURL = urlSplit[1];
		if(data.paramLowerCase) {
			queryURL = queryURL.toLowerCase();
		}
		queryURL = queryURL.split("&");
		questionMark = '?';
		
		let paramQuery = data.queryParamTable.map(x => x.queryParam);
		for(var query of queryURL){
			if(data.paramInputChoice === "paramWhitelist"){
				if(paramQuery.indexOf(query.split("=")[0]) > -1){
					queryStringNew.push(query);
				} else if(data.removeRedactChoice === "paramRedact"){
					queryStringNew.push(query.split("=")[0] + "=" + data.paramRedactText);
				}
			} else if(data.paramInputChoice === "paramExclude"){
				if(paramQuery.indexOf(query.split("=")[0]) === -1){
					queryStringNew.push(query);
				} else if(data.removeRedactChoice === "paramRedact"){
					queryStringNew.push(query.split("=")[0] + "=" + data.paramRedactText);
				}
			} else {
				queryStringNew(urlSplit[1]);
			}
		}
	}
	switch (data.outputResult) {
		case 'url':
			return urlSplit[0]+questionMark+queryStringNew.join('&');
		case 'path':
			return urlInput.pathname+questionMark+queryStringNew.join('&');
		case 'paramq':
			return questionMark+queryStringNew.join('&');
		case 'param':
			return queryStringNew.join('&');
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

