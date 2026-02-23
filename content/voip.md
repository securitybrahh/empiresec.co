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
   
This list includes vendors that have been tested, submitted, reviewed, and verified ny the community  
    
**[LIST](#vendors) | [SUBMIT](#submit-a-new-vendor-report) | [UPDATE](#update-status-of-vendor-report)**  

## Introduction

Welcome to the crowd-sourced dataset of VoIP Vendors
  
New visitors are encouraged to read the [official usage guide on carrier guide](https://www.empiresec.co/carrier)

---

<!-- 
TODO: 
- remove language and geo-language from vendor url link after testing locally
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

- Callcentric

### North America

### Latin America

### Central America

### Africa

### Middle East

### Europe

### India

### South East Asia

### China

### Russia

### Oceania

#### Australia

#### New Zealand
                            
### Australia

- [ANZ Australia](https://play.google.com/store/apps/details?id=com.anz.android.gomoney) - [Report](https://github.com/PrivSec-dev/banking-apps-compat-report/issues/157)
- ~~[ANZ Plus](https://play.google.com/store/apps/details?id=com.anz.lotus)~~ - [Report](https://github.com/PrivSec-dev/banking-apps-compat-report/issues/313)
  - This 2FA app is broken on GrapheneOS, but can be set up if you have a second phone in reach. The TD apps work fine otherwise.
                        
                            
---

## Prerequisites

This section covers how to submit or update a banking app report.

### Submit a new vendor report 

There are several methods for GrapheneOS users to contribute their banking app report:  

| Method | Description | Action |
| :--- | :--- | :---: |
| **GitHub** | Fill out the form on the [issue tracker](https://github.com/securitybrahh/voip-providers/issues) using your GitHub account | [`SUBMIT REPORT`](https://github.com/securitybrahh/voip-providers/issues/new?assignees=&labels=&template=vendor_report.yml) |

### Update status of vendor report

Please avoid opening a new issue to update the status of a vendor report.  
  
Instead, use `CTRL` + `F` on this page or search on the [issue tracker](https://github.com/securitybrahh/voip-providers/issues) for the app and open its `Report`. Then, simply add your update as a comment to the existing report.  
