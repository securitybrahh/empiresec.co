---
title: "VoIP Providers"
date: 2026-02-22T00:00:52Z
# weight: 1
aliases: ["/voip-providers"]
tags: ["number", "privacy", "security", "Internet", "voip", "carrier"]
author: "Security Brahh"
description: "Lisrt of VoIP Providers per country code"
draft: false
---

# VoIP Providers

  
**Maintained List of VoIP Providers per Country Code**    
   
This list includes vendors that have been tested, submitted, reviewed, and verified.  
    
**[LIST](#vendors) | [SUBMIT](#submit-a-new-vendor-report) | [UPDATE](#update-status-of-vendor-report)**  

## Introduction

Welcome to the crowd-sourced dataset of VoIP Vendors
  
New visitors are encouraged to read the [official usage guide on banking apps](https://grapheneos.org/usage#banking-apps) for comprehensive details about how these apps function on GrapheneOS.  

### IMPORTANT 

Please read GrapheneOS's important announcement, officially released on Dec 1, 2023:  
[X](https://x.com/GrapheneOS/status/1730491676760633426) | [Mastodon](https://grapheneos.social/@GrapheneOS/111504057316755618) | [Bluesky](https://bsky.app/profile/grapheneos.org/post/3kfhrujfcih2m)   
   
Also available as a [pinned issue](https://github.com/PrivSec-dev/banking-apps-compat-report/issues/342), detailing the latest developments about [SafetyNet's replacement by Play Integrity API](https://developer.android.com/privacy-and-security/safetynet/deprecation-timeline), which could impact _some_ banking apps' [compatibility](https://discuss.grapheneos.org/d/8330-app-compatibility-with-grapheneos#:~:text=issuecomment%2D1766887298%29-,Not%20compatible,-Due%20to%20the) with GrapheneOS after the app updates.  

---

<!-- 
TODO: 
- remove language and geo-language from app store url link after testing locally
- i.e., users in different countries / languages locale defaults 

EXAMPLE:

  INCORRECT:
    Germany
    - [Commerzbank Banking](https://play.google.com/store/apps/details?id=de.commerzbanking.mobil&hl=en_US&gl=US)

  CORRECT:
    - [Commerzbank Banking](https://play.google.com/store/apps/details?id=de.commerzbanking.mobil)

  REMOVE:
    &hl=en_US&gl=US

NOTE: Some only have either/or, remove:
    - &hl=en
    - &gl=FR

    OTHER:
        - &hl=de&gl=US
        - &hl=en&gl=US
        - &hl=en_IN&gl=US

TEST: Test url again after removing the parameters and verify there is no mistakes in url
-->
                            
## Vendors
                            
### Australia

- [ANZ Australia](https://play.google.com/store/apps/details?id=com.anz.android.gomoney) - [Report](https://github.com/PrivSec-dev/banking-apps-compat-report/issues/157)
- ~~[ANZ Plus](https://play.google.com/store/apps/details?id=com.anz.lotus)~~ - [Report](https://github.com/PrivSec-dev/banking-apps-compat-report/issues/313)
  - This 2FA app is broken on GrapheneOS, but can be set up if you have a second phone in reach. The TD apps work fine otherwise.
                        
                            
---

## Prerequisites

This section covers how to submit or update a banking app report.

### Submit a new app report 

There are several methods for GrapheneOS users to contribute their banking app report:  

| Method | Description | Action |
| :--- | :--- | :---: |
| **GitHub** | Fill out the form on the [issue tracker](https://github.com/PrivSec-dev/banking-apps-compat-report/issues) using your GitHub account | [`SUBMIT REPORT`](https://github.com/PrivSec-dev/banking-apps-compat-report/issues/new?assignees=&labels=&template=app_report.yml) |
| **Non-GitHub** | View gist → Raw → Save template markdown file to fill out. | [`Gist`](https://gist.github.com/akc3n/e845078ddbbb28ada0dd055c51ec45af) |
| Curl | Terminal → `curl -O` → paste copied url (gist form `.md` template) ⟶ | [`Copy link address`](https://gist.githubusercontent.com/akc3n/e845078ddbbb28ada0dd055c51ec45af/raw/c2bb563db726b80491a59c68d7f15c0897f563a0/banking-app-report-issue-form.md) |  
  
Alternatively, curl and pipe the output directly into your preferred text editor for editing, for example:  
  
```bash
curl https://gist.githubusercontent.com/akc3n/e845078ddbbb28ada0dd055c51ec45af/raw/c2bb563db726b80491a59c68d7f15c0897f563a0/banking-app-report-issue-form.md\?T | nvim -
```

### Update status of app report

Please avoid opening a new issue to update the status of a banking app report.  
  
Instead, use `CTRL` + `F` on this page or search on the [issue tracker](https://github.com/PrivSec-dev/banking-apps-compat-report/issues) for the app and open its `Report`. Then, simply add your update as a comment to the existing report.  
  
For non-GitHub users, if you have tried all the combinations from these [possible workaround solutions](https://discuss.grapheneos.org/d/8330-app-compatibility-with-grapheneos) and still cannot resolve your specific banking app compatibility issue, feel free to [contact me](https://github.com/akc3n/akc3n?tab=readme-ov-file#connect) for further assistance.  

---

## Note

GrapheneOS has a [detailed guide](https://grapheneos.org/articles/attestation-compatibility-guide) for app developers on how to support GrapheneOS with the hardware attestation API. Direct use of the hardware attestation API provides much higher assurance than using SafetyNet so these apps have nothing to lose by using a more meaningful API and supporting a more secure OS.  
