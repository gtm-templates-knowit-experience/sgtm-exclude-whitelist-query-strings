# Exclude or Whitelist Query String Parameters  - SGTM Variable
The probably most common cause for **Personally Identifiable Information (PII)** leaking into analytics tools is through the URL of the website.
This **Variable Template** for **Google Tag Manager Server-Side (SGTM)** fixes this problem by making it possible to **Exclude** or **Whitelist** Query String Parameters from the URL.

Images of the Template is at the bottom.

## Variable Settings
### Page URL
As standard **page_location** is chosen, but you can use any Variable containing a valid URL as input.

### Output Result

| Setting  | Example Output |
| ------------- | ------------- |
| Page URL with Parameters | ht<span>tps://domain</span>.com/path?query=something  |
| Page Path with Parameters  | /path?query=something  |
| Parameters with Question Mark  | ?query=something  |
| Parameters without Question Mark  | query=something  |

### Lowercase Parameters
Parameter matching is by default **Case Sensitive**. By ticking this box, all incoming parameters will be set to **lowercase**, making it easier to match parameters.

### Whitelist or Exclude Query Parameters
You can either **Whitelist** or **Exclude** Parameters.

**Whitelist** means only parameters listed are allowed to pass through. This is the safest option for not allowing PII parameters leaking into your analytics and marketing tools. If you choose this option, it's important that you **add all parameters that you need**. That can be campaign tracking parameters and internal search parameters.

**Exclude** can also be used as a method for blocking PII parameters. It's less "safe" than using **Whitelist**, but are added as an option. With this method, add parameters you **don't want to be passed through** to your analytics tool.

### Remove or Redact Parameter Value
If you choose **Remove**, you remove the parameter and the parameter value. 
Choosing **Redact** means that the parameter will be kept, but the value will be redacted.
Example: **query=[REDACTED]**.

### Add Query Parameters for Whitelisting/Exclusion
Add the parameters to the table that you want to Whitelist/Exclude.

## Example Setups
### Example Setup for Google Analytics 4 (GA4)
In the GA4 example setup below, 1 extra GA4 parameter has been created (page_query_string). Settings below:

1. **page_location** with Page URL Parameters Whitelisted and other Parameters Removed.
2. Query String without Question Mark, Whitelisted and other Parameters Redacted is sent to parameter **page_query_string**.

We overwrite **page_location** with the new URL where Parameters are Whitelisted and other Parameters removed. To **page_query_string** we send the Query String with the Whitelisted Parameters other Parameters as Redacted.

![Google Analytics 4 (GA4) example setup](https://github.com/gtm-templates-knowit-experience/sgtm-exclude-whitelist-query-strings/blob/main/images/ga4-overwriting-example.png)

#### Example Output
| Settings | Allowed parameters | page_location input | page_location output |
| -------------| -------------| ------------- | ------------- |
| Page URL with Parameters (removed) | query | ht<span>tps://domain</span>.com/path?query=something&secondparam=something-else | ht<span>tps://domain</span>.com/path?query=something  |
| Parameters without Question Mark (redacted) | query | ht<span>tps://domain</span>.com/path?query=something&secondparam=something-else | query=something&secondparam=[REDACTED] |

### Example Setup for Universal Analytics
In the Universal Analytics example setup below, 3 different variables have been created:
1. Page URL with Parameters Whitelisted and Removed
2. Query String without Question Mark, Whitelisted and Redacted
3. Referral with Parameters Whitelisted and Removed

We overwrite **page_location** with the new URL where parameters are Whitelisted and other Parameters removed. 
To **Custom Dimension 1 (cd1)** we send the Query String with the Whitelisted Parameters and other Parameters as Redacted.
We overwrite **page_referral** with the new Referral where parameters are Whitelisted and other Parameters removed.

Using this setup we get "clean" URLs and referrals, while we at the same time can investigate what other parameters are in use.

![Universal Analytics example setup](https://github.com/gtm-templates-knowit-experience/sgtm-exclude-whitelist-query-strings/blob/main/images/ua-overwriting-example.png)

# Images of the Variable Template
Variable Template (Server) for Google Tag Manager that Exclude or Whitelist Query String Parameters.

![Exclude and Redact Query Parameters](https://github.com/gtm-templates-knowit-experience/sgtm-exclude-whitelist-query-strings/blob/main/images/sgtm-exclude-redact-query-string.png)

![Whitelist (include) Query Parameters](https://github.com/gtm-templates-knowit-experience/sgtm-exclude-whitelist-query-strings/blob/main/images/sgtm-whitelist-remove-query-string.png)
