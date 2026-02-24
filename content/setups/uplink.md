---
title: "Phone Number and the internet"
date: 2026-02-21T00:00:52Z
# weight: 1
aliases: ["/uplink"]
tags: ["number", "privacy", "security", "Internet", "router"]
author: "Security Brahh"
description: "Threat modeling phone numbers, SIMs, IMEI, and internet connectivity"
draft: false
---

# Phone Number and Internet Connectivity

Modern telephony is no longer copper-bound.  
Everything is IP-backed, database-controlled, and identity-scored.

Your “phone number” is:

- A database entry
- Linked to an IMSI
- Routed via IP infrastructure
- Reputation-scored by online services

This document threat-models the full stack.

---

# 1. Identity Stack Diagram

Below is the real identity chain inside mobile networks:

            ┌──────────────────────────┐
            │        MSISDN            │
            │  (Your Phone Number)     │
            └─────────────┬────────────┘
                          │
                          ▼
            ┌──────────────────────────┐
            │          IMSI            │
            │  (Subscriber Identity)   │
            └─────────────┬────────────┘
                          │
                          ▼
            ┌──────────────────────────┐
            │          ICCID           │
            │  (Physical SIM ID)       │
            └─────────────┬────────────┘
                          │
                          ▼
            ┌──────────────────────────┐
            │          EID             │
            │  (eSIM Chip ID)          │
            └─────────────┬────────────┘
                          │
                          ▼
            ┌──────────────────────────┐
            │          IMEI            │
            │  (Device Modem ID)       │
            └─────────────┬────────────┘
                          │
                          ▼
            ┌──────────────────────────┐
            │        Cell Tower        │
            └─────────────┬────────────┘
                          │
                          ▼
            ┌──────────────────────────┐
            │      Carrier Core        │
            └─────────────┬────────────┘
                          │
                          ▼
            ┌──────────────────────────┐
            │        Internet          │
            └──────────────────────────┘


Key Reality:

- The network primarily tracks **IMSI**
- The device is identified by **IMEI**
- The number (MSISDN) is just a routing alias

Changing one layer does not remove linkage unless aligned with other layers.

---

# 2. eSIM Provisioning Flow Diagram

User scans QR Code
│
▼
SM-DP+ Server (Profile Server)
│
│ (EID identifies eSIM chip)
▼
Profile Downloaded
│
│ (Profile contains IMSI + carrier data)
▼
eSIM Activated
│
▼
Modem authenticates using:
IMEI + IMSI


Important:

- EID identifies the eSIM hardware
- IMSI identifies the subscriber
- IMEI identifies the modem
- MSISDN maps to IMSI in carrier database

---

# 3. Threat Model Matrix

Below is a structured comparison of common connectivity models.

## Legend

- ✅ = Strong advantage  
- ⚠️ = Partial / situational  
- ❌ = Weak / exposed  

---

## A. Physical SIM (KYC)

| Threat Vector | Exposure Level | Notes |
|---------------|---------------|-------|
| Carrier tracking | ❌ High | IMSI tied to legal ID |
| IMEI logging | ❌ High | Historical device mapping |
| SIM swap risk | ⚠️ Medium | Mitigated with carrier PIN |
| Stingray attacks | ❌ High | Radio-layer exposure |
| SMS interception | ❌ High | Plaintext at interconnect |
| Service acceptance | ✅ High | Trusted as “mobile” |
| Anonymity | ❌ Very Low | KYC-bound |

---

## B. eSIM (KYC)

| Threat Vector | Exposure Level | Notes |
|---------------|---------------|-------|
| Carrier tracking | ❌ High | Same as physical SIM |
| Remote provisioning attack | ⚠️ Medium | SM-DP+ trust dependent |
| IMEI logging | ❌ High | Same baseband behavior |
| Profile rotation | ⚠️ Possible | If new IMSI issued |
| Service acceptance | ✅ High | Appears as mobile |
| Anonymity | ❌ Low | Usually KYC |

---

## C. Data-only eSIM + VoIP Number

| Threat Vector | Exposure Level | Notes |
|---------------|---------------|-------|
| Carrier subscriber identity | ⚠️ Medium | Data IMSI separate from voice |
| IMEI linkage | ⚠️ Medium | Still visible to carrier |
| Stingray exposure | ⚠️ Medium | Data-only still attaches to tower |
| SMS plaintext | ⚠️ Depends | VoIP SMS often routed via SIP |
| Service rejection | ❌ High | Often flagged as VoIP |
| KYC requirements | ⚠️ Depends | Jurisdiction-specific |
| Local radio identity | ❌ Present | Still cellular |

---

## D. Public WiFi + Virtual Number

| Threat Vector | Exposure Level | Notes |
|---------------|---------------|-------|
| Carrier tracking | ✅ None | No SIM attached |
| IMSI exposure | ✅ None | Airplane mode possible |
| IP logging | ❌ High | WiFi operator logs |
| Physical attribution | ⚠️ Moderate | CCTV + time correlation |
| Service rejection | ❌ Medium | VoIP flagged often |
| Local radio attack | ✅ None | No baseband usage |
| SMS plaintext | ⚠️ Depends | VoIP routing path |

---

## E. Home WiFi + VPN Router

| Threat Vector | Exposure Level | Notes |
|---------------|---------------|-------|
| ISP attribution | ❌ High | ISP knows address |
| Public IP visibility | ✅ Low | VPN masks exit |
| IMSI exposure | ✅ None | If no SIM used |
| Metadata logging | ⚠️ VPN dependent | Trust shifts to VPN |
| Service acceptance | ⚠️ Depends | VPN IP reputation |
| Physical location leakage | ❌ High | Subscriber tied to address |

---

# 4. Identity Rotation Strategy Matrix

| Strategy | Effective Against | Ineffective Against | Risk |
|----------|-------------------|--------------------|------|
| Change IMEI only | Historical device linkage | IMSI tracking | Carrier anomaly detection |
| Change IMSI only | Subscriber history | IMEI logging | KYC persistence |
| Change EID only | eSIM hardware trace | Carrier logs | Minimal benefit |
| Rotate IMEI + IMSI + EID | Long-term carrier correlation | Real-world surveillance | Operational complexity |
| Use virtual number | Radio-layer attacks | Database scoring | Service rejection |
| Remove SIM entirely | IMSI tracking | IP attribution | WiFi logs |

---

# 5. Attack Surface Summary

## Radio Layer Risks
- IMSI catchers
- Downgrade attacks (2G)
- Baseband exploits
- Tower triangulation

Mitigation:
- Disable 2G
- Force LTE/5G only
- Keep baseband updated
- Airplane mode when possible

---

## Network Layer Risks
- ISP logging
- VPN logging
- Public WiFi logging
- IP reputation scoring

Mitigation:
- Router-level VPN
- IP rotation
- Avoid KYC-bound WiFi portals

---

## Application Layer Risks
- SMS OTP
- SIM swap
- Account recovery abuse
- Metadata correlation

Mitigation:
- Hardware security keys
- TOTP instead of SMS
- Compartmentalized SIM roles

---

# 6. Core Insight

There is no magic SIM.  
There is no magic carrier.  
There is no magic IMEI trick.

There are only tradeoffs between:

- Metadata exposure
- Legal identity binding
- Radio-layer visibility
- Platform trust heuristics
- Operational complexity

Privacy comes from:

- Compartmentalization
- Minimization
- Jurisdiction awareness
- Removing SMS as root identity
- Aligning identifier rotation correctly

Everything else is optimization.

---

# Optional Additions

Future expansions could include:

- Probability modeling of IMEI collision
- Carrier fraud scoring mechanisms
- Detailed RCS vs SMS trust boundary diagram
- Lawful intercept architecture overview
- Stingray protocol flow breakdown


Phone Number and Internet Connectivity

The modern phone number is no longer what people think it is.

Copper is being replaced by fibre. The traditional PSTN is being phased out in many countries. Nearly everything is now IP-based, routed over TLS at some layer, and provisioned via centralized servers.

Your “phone number” is no longer tied to a wire — it’s tied to databases.

1. No SIM, No Problem?

A device without a SIM:

Cannot attach to a carrier network

Cannot expose IMSI

Cannot be triangulated by cell towers

Still connects over Wi-Fi

This reduces mobile-layer exposure but does not make you anonymous. Your identity moves to:

IP address

Device fingerprint

Accounts

Behavioral patterns

Removing a SIM removes radio identity, not network identity.

2. VPN on the Router

Running a VPN at the router level (e.g. GL.iNet Mudi V2) provides:

Network-wide tunneling

IP masking for all connected devices

Device-level isolation

However:

Carrier still sees IMSI + IMEI

VPN provider sees exit traffic

Mobile metadata still exists if using cellular uplink

A buffer router between your phone and ISP is generally good practice.

3. “Zero Click” & Local Attacks

Zero-click attacks exploit:

Baseband firmware

Messaging parsers

VoIP stacks

Stingrays / IMSI catchers exploit:

Downgrade attacks (2G)

Weak authentication in legacy protocols

Mitigation in GrapheneOS:

Disable 2G

Force LTE-only / 5G-only

Avoid automatic downgrades

The attack surface shrinks significantly when legacy protocols are removed.

4. What Is (and Isn’t) a “VoIP” Number?

Today, almost all telephony is IP-backed.

Even traditional carriers use VoIP internally.

So what does “VoIP number” mean?

It usually means:

A number allocated from providers classified as “non-wireless” or “virtual” in commercial carrier databases.

Services check databases (e.g., carrier lookup APIs) and flag numbers as:

Mobile (good)

Fixed line

VoIP (often rejected)

High-risk / disposable

Heuristics include:

Carrier type

Area code reputation

Prior abuse signals

Two numbers from the same provider may be treated differently.

This is not technical — it’s policy.

5. How eSIM Works

An eSIM is provisioned over the internet.

Flow:

You scan QR code.

Device contacts SM-DP+ server.

EID identifies the chip.

Profile containing IMSI is downloaded.

Modem uses IMEI + IMSI to authenticate.

Once provisioned, it behaves like a normal SIM.

Important identifiers:

IMEI → identifies modem

IMSI → identifies subscriber

ICCID → identifies SIM

EID → identifies eSIM chip

MSISDN → phone number

The network primarily tracks IMSI, not IP.

6. A New Carrier Doesn’t Solve Much

Switching carriers:

Does not remove radio-layer tracking.

Does not prevent lawful intercept.

Does not stop metadata logging.

It only changes who logs you.

7. KYC Reality

Many countries require ID for SIM activation.

If KYC is mandatory:

Avoid highly centralized IDs where possible.

Don’t use your most globally traceable document unless required.

Understand local SIM registration laws before travel.

Some countries offer prepaid anonymity. Others don’t.

8. Defeating PSTN (Or Trying To)

PSTN calls and SMS are plaintext at various interconnect points.

Even when signaling is secured, SMS:

Is store-and-forward

Often unencrypted end-to-end

Accessible to operators

Some countries are shutting down copper PSTN, but that does not mean SMS becomes encrypted.

It just becomes IP-transported plaintext.

9. SIM Swap Defense

To reduce SIM swap risk:

Enable carrier-level 2FA / PIN

Remove SMS as account recovery where possible

Use app-based TOTP or hardware keys

Your phone number should not be your root identity.

10. SIM Operational Security

Segmentation model:

Banking SIM

Government ID SIM

Public / Misc SIM

Do not mix roles.

Compartmentalization > rotation.

11. IMEI: Should You Change It?

IMEI structure:

8 digits TAC (device model)

6-digit serial

1 Luhn checksum

Changing IMEI:

Breaks historical linkage

Removes prior SIM association

Resets device fingerprint at carrier layer

But risks:

Carrier anomaly detection

IMEI mismatch patterns

Duplicate TAC/serial conflicts

The real tracking anchor is IMSI.

If you rotate IMEI but keep IMSI constant, nothing meaningful changes.

If rotating, do it aligned with:

New IMSI

New EID

New profile

Frequent random changes can make you more suspicious, not less.

Blend into a large device population.

12. IP Address: Mobile vs WiFi

Mobile:

IP changes frequently

Location triangulation possible

Identity = IMSI

WiFi (home):

IP changes less frequently

ISP knows your address

Stable subscriber identity

Public WiFi:

Harder physical pinpointing

But logs MAC + time + possibly onboarding data

If you give real identity to public WiFi onboarding:
Static IP + KYC = strong attribution.

Mobile identifies the SIM.
WiFi identifies the subscriber.

Choose your threat model.

13. Virtual Numbers vs Physical SIM

Virtual number advantages:

Not tied to IMEI

No exposure to local IMSI catchers

Often no KYC (jurisdiction dependent)

Disadvantages:

Often flagged as VoIP

SMS still plaintext

Limited country availability

In some regions, virtual numbers are restricted.

Sometimes you must bridge:

Bank OTP

Government messages

This is where services like US/UK virtual number providers come in.

But availability is geography-dependent.

14. Voice: VoNR, VoWiFi

Modern voice paths:

VoLTE

VoNR (5G standalone)

VoWiFi

All are IP-based.

But signaling metadata still exists.

Voice encryption at radio layer ≠ end-to-end encryption.

15. SMS vs RCS vs Encrypted Messaging

SMS:

Plaintext

Carrier-readable

RCS:

Often encrypted only within vendor ecosystems

Not universal

True E2EE:

Signal

WhatsApp

Similar modern messengers

Banks and governments still rely heavily on SMS.

This is a systemic weakness.

16. Local Attacks & Downgrades

Defenses:

Disable 2G

Avoid auto network switching

Keep baseband updated

Prefer devices with hardened OS (e.g., GrapheneOS)

Android 16 + improved radio HAL may reduce downgrade vectors.

17. Online Identity Strategy

Many services treat US numbers more favorably.

Jurisdiction affects:

Number acceptance

Fraud scoring

Access to services

Your MSISDN is reputation-scored.

Not all countries are equal in platform trust heuristics.

18. The Real Takeaway

There is no magic SIM.
There is no magic carrier.
There is no magic IMEI trick.

There are only tradeoffs between:

Metadata exposure

Legal identity

Radio-layer tracking

Platform trust scoring

Usability

Privacy is achieved through:

Compartmentalization

Minimization

Jurisdictional awareness

Reducing single points of identity

Avoiding SMS as root authentication

Everything else is optimization.

Phone Numbers and the Internet: Privacy, Security, and Operational Considerations in 2026Whitepaper
Author: Compiled from Security Brahh analysis and verified sources
Date: February 22, 2026
Version: 1.0  AbstractPhone numbers remain a critical bridge between physical identity and digital services, yet they expose users to surveillance, SIM-swapping, location tracking, and VoIP heuristics. This whitepaper consolidates technical realities of cellular networks, eSIM provisioning, PSTN migration, IMEI management, and IP-based alternatives. It provides actionable opsec recommendations for privacy-conscious users on GrapheneOS, custom routers (e.g., GL.iNet MudiV2), and no-SIM setups. Key findings: traditional SIMs are obsolete for high-threat models; all-IP networks (VoIP/5G) improve encryption potential but centralize new risks; disciplined rotation and compartmentalization remain the strongest mitigations.1. No-SIM Connectivity: The Gold Standard for Local Threat ModelsEliminating the SIM entirely removes the primary vector for carrier-level tracking (IMEI + IMSI linkage, tower triangulation, GNSS pings).Core Setup (The Hated One model, 2024–2026):GrapheneOS device in permanent airplane mode (or no SIM/eSIM inserted).
All traffic over trusted public Wi-Fi + full-device VPN (Mullvad/Proton) or Tor.
Communication: Signal / Matrix / Session (E2EE).
Rare voice/SMS needs: Offline “dumbphone” (e.g., Nokia feature phone) powered only when required, stored in Faraday bag.
Data: Pre-download offline maps/content; public Wi-Fi ubiquitous in urban areas.

Privacy GainsNo IMSI/IMEI exposure to carriers.
Location reduced to Wi-Fi AP spherical radius (vs. meter-level cellular + GNSS).
Zero persistent carrier metadata.

Limitations: Inconvenient for always-on mobile data or banking/government OTPs.2. eSIM Provisioning Mechanics and VulnerabilitiesHow eSIM Works

sequenceDiagram
    participant User
    participant Device_LPA
    participant SM_DP_Plus
    participant eUICC
    User->>Device_LPA: Scan QR (SM-DP+ address + token)
    Device_LPA->>SM_DP_Plus: EID + authentication request (TLS)
    SM_DP_Plus->>Device_LPA: Encrypted profile (IMSI, Ki, 5G keys)
    Device_LPA->>eUICC: Install profile (ISD-P)
    eUICC-->>Device_LPA: Confirmation

LPA (Local Profile Assistant) runs with high privileges.
SM-DP+ (remote server) generates profile.
EID (Embedded Identity) uniquely identifies the eUICC chip.
Once installed, behaves like physical SIM (IMEI + IMSI pair).

Major Vulnerabilities (2025–2026)eSIM Swap — Social engineering carrier support with breached PII.
QR Code Theft — Interception via email compromise.
Privileged Malware — Zero-click (Pegasus-class) control of LPA → silent profile injection.
Untrusted SM-DP+ — Travel eSIM resellers often route through Chinese/Hong Kong infrastructure (Northeastern University study, 2025): IMSI exposure + ~800 m location accuracy in some cases.
OpenRSP (Blockchain-Powered eSIM) proposal: decentralizes SM-DP+ via smart contracts + ZKPs for trustless, user-controlled provisioning (still WIP, GPL-3.0).

Hardware AdaptersJMP.chat eSIM adapter (ST33G1M2 chip in SIM form factor) — loads any profile via JMP SIM Manager app.
9eSIM V3 card + reader — stores up to 50 profiles (1.5 MB), lpac support on Android/PC/iOS.

Mitigation: Rotate entire profile + EID + IMEI together; use only reputable providers (Silent.Link, JMP Data); always VPN; prefer data-only plans.3. PSTN Switch-Off and the All-IP Reality (2026 Status)Copper PSTN is being globally replaced by fiber + VoIP. Voice/SMS now travel over TLS-encrypted IP in most new deployments.Global Timeline (selected):Region
Status
Full Switch-Off
UK (BT)
Delayed
Jan 2027
Netherlands
Completed
—
Germany
Completed (phased)
—
Estonia
Completed
—
Japan
Ongoing
2026–2027
Singapore
Completed
—

ImplicationsPlaintext PSTN era ending → SMS/voice now at least transport-encrypted.
RCS E2EE (Apple iOS 26.4 beta, Feb 2026) emerging but limited (mostly iOS-to-iOS; Google extension server-dependent).
WhatsApp/Messenger E2EE increasingly used by banks/governments as PSTN replacement.

Recommendation: Treat any number that touches legacy PSTN as plaintext; prefer pure VoIP/XMPP bridges.4. VoIP vs “Real” Carrier Numbers and Detection HeuristicsServices (banks, Google, Meta, PayPal, etc.) block “bad” VoIP via:NPA-NXX block lookup.
NPAC database queries.
Carrier reputation + location heuristics.
IP geolocation cross-check.

Cloaked.app Model — Real numbers via routing/forwarding (4-number chain: recipient → Cloaked # → personal # → routing #). Still flagged as VoIP by many sites.Best Persistent Options (2026)JMP.chat — US/CA/UK numbers, XMPP/Cheogram integration, eSIM adapter, Monero-friendly, low rejection rate once aged.
Silent.Link — Data-only anonymous eSIMs, crypto payments, no expiration.
Port physical SIM → VoIP (Google Voice, JMP) to inherit “good carrier” reputation.

Database Resourcesesimdb.com — Mobile data plan catalog.
freecarrierlookup.com — Carrier type checks.

5. IMEI Management and Rotation OpsecIMEI (15 digits): TAC (8) + serial + Luhn check digit.
Changing IMEI erases carrier history tied to modem but must match device TAC for low collision probability (<0.001 until ~99k units of same model).Recommended Workflow (MudiV2 + Blue Merle)

flowchart TD
    A[Acquire new eSIM profile/EID] --> B[Change IMEI via Blue Merle LuCI before activation]
    B --> C[Activate profile on router/phone]
    C --> D[Use for session]
    D --> E[Dispose profile + EID]
    E --> F[Change IMEI again]
    F --> G[New adapter/profile cycle]

Legal in most jurisdictions for personal privacy use (no fraud intent).
GrapheneOS recommendation: avoid unless aligned with other metadata.
Tools: Blue Merle firmware on GL.iNet (enables AT commands on supported modems), OpenEUICC, lpac.

Collision Probability — Negligible for popular models (<1/100,000 per TAC).6. Mobile IP vs Wi-Fi: Location Privacy ComparisonFactor
Mobile Data
Public Wi-Fi
Home Wi-Fi
Location Accuracy
Tower triangulation + GNSS (meters)
AP spherical radius (hundreds of m)
Exact address
Tracking Vector
IMEI/IMSI (persistent)
MAC (randomized) + dynamic IP
Static IP + ISP logs
Visibility to Sites
ISP public IP
ISP public IP
ISP public IP
Best For
When proxying
Daily opsec
Avoid

Rule: Public Wi-Fi + VPN > mobile data for location privacy when not using paid residential proxies.7. KYC, Compartmentalization, and Country-Specific Reality185/245 countries require SIM registration (passport/biometrics in 13).
Exceptions (no KYC): USA, Canada, Mexico, Chile, etc.SIM Opsec TiersBanking/government — Dedicated physical/eSIM with minimal KYC ID.
High-privacy daily — Data-only anonymous eSIM (Silent.Link) + JMP US number bridge.
Throwaways — smspool.net / temporary VoIP.

Emergency Calls — Still require valid SIM profile in most jurisdictions.8. Router-Centric Stack (Recommended Endgame)GL.iNet MudiV2 (GL-E750v2) + Blue MerleKernel 5.10.176+.
eSIM support via lpac.
IMEI change via LuCI → Network → Blue Merle.
WireGuard + VPN Hotspot.
Starlink as upstream buffer (GPS-disablable, ~24 km location blur).

Full Chain
Starlink → MudiV2 (Blue Merle) → WireGuard → Devices (GrapheneOS, no SIM).9. DiagramseSIM Provisioning Flow (see Section 2)IMEI Rotation Workflow (see Section 5)Connectivity Privacy Hierarchy

graph TD
    A[No SIM + Public Wi-Fi + VPN] --> B[Data-only eSIM + JMP VoIP bridge]
    B --> C[Physical SIM compartmentalized]
    C --> D[Legacy PSTN number]

Conclusion and Actionable ChecklistDefault to no SIM wherever possible.
For persistent numbers: JMP.chat (US identity) + eSIM adapter.
Rotate EID + profile + IMEI together on supported hardware.
Use data-only anonymous eSIMs (Silent.Link preferred) behind VPN.
Migrate off PSTN-dependent services; push for WhatsApp-style E2EE in banking/government.
Compartmentalize: separate SIMs for banking / gov / daily.
Monitor OpenRSP and decentralized eSIM projects for long-term sovereignty.

Phone numbers are legacy identity anchors in an IP world. Treat them as disposable bridges, never as persistent personal identifiers.References (key sources consulted)The Hated One – “Why I don’t use a SIM card” (YouTube, 2024)
Cloaked.app help articles (routing mechanics & VoIP rejection)
PrivacyGuides threads on JMP, Silent.Link, travel eSIMs, mobile options
Northeastern University eSIM routing study (USENIX Security 2025)
BT Group / global PSTN switch-off reports
PhoneTravelWiz SIM registration database
OpenRSP GitHub repository
an.dywa.ng carrier GNSS analysis
Letters.EmpireSec JMP & Starlink deep-dives
Wikipedia (PSTN, IMEI) and GSMA references

This document is licensed under CC-BY-SA 4.0. Distribute and improve freely. Feedback welcome.



## no SIM

https://www.youtube.com/watch?v=4Dei2buz1X0

## VPN on the router

## Zero Click?

## What is not a "VoIP" number

worldwide the copper is being replaced by fibre and with it, everything is TLS. So VoIP is basically all numbers rn and systems test for "good" carriers.

https://www.freecarrierlookup.com

if a Product or a service's DB thinks that your number is from a good carrier, the services allow that number.

More heuristics maybe at play because one number may work as non-VoIP and other may not from same carrier, maybe area codes at play also.

but mostly the Phone Numbers are being allocated on servers and fibre, note the PSTN is still copper i. e. free text. 

https://help.cloaked.app/hc/en-us/articles/11841989344404-How-do-Phone-Calls-and-Text-Messages-Work

https://help.cloaked.app/hc/en-us/articles/20683558341780-Why-do-some-sites-reject-Cloaked-numbers

https://help.cloaked.app/hc/en-us/articles/20373440034708-Why-can-t-I-verify-my-phone-numbers-on-some-websites

https://wiki.soprani.ca/FAQ/Why%20isn%27t%20my%20number%20being%20accepted%20by%20an%20online%20service%3F

## how does an esim Functions?

https://discuss.privacyguides.net/t/what-is-a-jmp-chat-esim-adapter/19165/14

In the case of an esim adapter, the provisioning of esim profile takes place over the internet, lpac gets the profile from rsp server like G+D, IDEMIA, thales, by feeding the EID and IMSI gotten from sm-dp+ server hostname in the esim QR code.

once the esim is provisioned, the adapter functions like a normal sim, IMEI of the modem and IMSI of the sim is used to communicate with the carrier.

## A new carrier doesn't solve anything

https://discuss.privacyguides.net/t/a-new-anonymous-phone-carrier-lets-you-sign-up-with-nothing-but-a-zip-code/33561/13

## Pricing

https://discuss.privacyguides.net/t/anyone-here-tried-pikasim-for-anonymous-esims-legit-or-not/33760

https://discuss.privacyguides.net/t/virtual-phone-number-for-graphene-os-user-no-esim/33367/6

https://wiki.soprani.ca/EuropeanNumberProviders

## Database of per-country code "VoIP" Provider

> github link like bank reports GOS

https://discuss.privacyguides.net/t/mobile-internet-options/19080

## eSIM vulnerabilities? 

https://youtube.com/watch?v=1cEMUlrpu7o

https://discuss.privacyguides.net/t/need-help-the-vulnerability-of-esim-this-bad/35209

https://github.com/Blockchain-Powered-eSIM/OpenRSP

https://discuss.privacyguides.net/t/travel-esims-secretly-route-traffic-over-chinese-and-undisclosed-networks-study/30277

https://discuss.privacyguides.net/t/data-only-esim-provider-local-ip-breakout/34542

https://discuss.privacyguides.net/t/issue-with-no-kyc-esim-provider/34792/3

https://discuss.privacyguides.net/t/experience-with-silent-link/19242/14

## Emergency Calls

## Online Identity

Its far better to have an American Identity on the internet as services will treat you better and US laws are somewhat forgiving.

so jmp.chat is nice

## Local Attacks

## Data Only SIM

ss7 can still be used for fraud - make illegitimate calls/sms,disable usage limits, rack up the bill.

## Location

phone# -> Anytime Integration interrogation (ATI) -> Location

phone# -> SRI -> IMSI -> PSI -> Location

## KYC

if you have to buy a sim with kyc, buy it with an ID that makes it difficult to centralize tracking

for eg, don't use a passport

in India, don't use Aadhar

https://www.phonetravelwiz.com/phone-travel-options/sim-card-registration/

## Airplane Mode

switch off all radios

## defeat the PSTN 

https://www.uctoday.com/unified-communications/bt-group-delays-pstn-switch-off/

https://www.yay.com/blog/voip/global-pstn-switchoff-learnings/

https://business.bt.com/why-choose-bt/insights/ip-technology/ip-what-we-can-learn/

https://www.mila.is/um-milu/frettasafn/nidurlagning-koparheimtaugakerfis-milu

## SIM Swap

have 2fa with your operator

## SIM opsec

1. sim for banking
2. sim for gov ID
3. sim for others

## SIM Lock

## 2FA 

Banks still use sms as verification mechanism, inbound sms can't still be used to hack accounts if 1FA is not known - so use strong passwords and have email opsec

## Email and password OPSEC

1. banking email - firstnamelastname protonmail
2. non-banking email - random passphrase
3. audience email - forward email
4. backend email 1 - critical accounts (TUta)
5. backend email 2 - non critical accounts (Proton)

https://letters.empiresec.co/p/pass

## IMEI

Should you change your IMEI on your devices?

GOS says you shouldn't because there are other carrier metadata that if not aligned to the IMEI, the device becomes more identifiable and raise some eyebrows. I beg to differ.

Most modems lock the capability to change the IMEI. Contrary to popular opinion on the internet, changing imei isn't something countries have made laws against.

I am pretty sure in USA, it's legal, and reading other countries' particular laws, there is not really a mention of IMEI spoofing.

There are a very small number of devices in which you can issue "AT" commands to change the IMEI. eg mudiV2 router with blue-merle, google pixels with samsung exynos modems (pixel 6 and above), some other routers.

IMEI is a 15 digit number that identifies your mobile, more precisely your mobile's modem which is issued by a regulatory body like gsma.

The first 8 digits is a TAC code which identifies brand, model, manufacturing origin, and network capabilities. The last digit is the Luhn check digit, which is used for integrity check. The middle digits is a serial number often allotted by the manufacturer.

To produce a viable IMEI for a device you need its TAC and the Luhn algorithm.

Luhn algo is in public domain but you need a TAC database or at least your device's TAC. (Which you can find from the stock IMEI which you should write it down somewhere for safe keeping or when/if you want to return to stock IMEI for whatever reasons)

You can use a generator like imei(dot)info or create your own program/do it with hand.

Changing IMEI basically erases your past history, which sim's you used, when you used them, also if you bought the device with your legal name, somewhere that record is also stored.

But changing your IMEI frequently can alert the carrier operator and trace your IMSI. IMSI is the ID given by the carrier network to the device. IMSI is linked to the billing details & kyc. a SIM is practically eCCID + IMSI.

SIM manufacturers give the chip an eccid, while the carrier gives it imsi. IMSI is a permanent number attached to your sim but carrier networks often use tmsi which is temporary.

What ICCID is to a sim card, EID is to an eSim.  An eSim profile contains the IMSI and other data to connect to the carrier.

So what you want to do is this: change imei per eid for a particular IMSI.

Dispose off the EID, dispose off the profile, change IMEI and get new eSim Adapter, and a new profile from time to time. 

The main problem is, using an imei that another device is using in the same carrier. The probability of that happening is pretty low (see Appendix) 

But ensure that you are using a device that is being used by a lot of people to have a crowd to hide in.

Appendix A: Probability of IMEI collision

The probability of imei collision is basically proportional to 1/(100,000 - the number of your model's sold.)

But kindly note if the number of the same model sold approaches 100,000, the brand will probably ask for a new TAC.

So the graph is highly zoomed in on the y axis and value ranges from 0 to 1 , the first value is 1/100,000 and increase expenonentially till there is new issue of TAC then again it will start at 1/100,000.

Also note that for probability to be 0.001 the number of devices needs to be 99,000.

So you have less than a 1 in a thousand chance for x < 99,000.

And it would be okay to assume after that point, a new TAC will be issued.

So we prove for most cases IMEI collision is miniscule.

Appendix B:

MSISDN is a code made with your country code and your mobile number. MSISDN is basically the parameter through which the packets are transmitted to the correct destination.

https://en.wikipedia.org/wiki/International_Mobile_Equipment_Identity

## IP

Which IP address should you choose?

Mobile v. WiFi

The public don't see your IP address, they can only see ISP's internal LAN's IP.

Your internal IP changes in both Mobile and WiFi, because most residential connections are dynamic not static.

Mobile's IP changes more, because well, it has to connect to the nearest tower, so if you are travelling, the connection gets reset and your IP changes more frequently.

On the other hand, WiFi's IP may not change for days if you don't switch on/off it, ISP may reset it from their end if they want but the IP usually changes whenever the router restarts.

in WiFi's case, your home address is basically doxxed by the ISP.

But if you use a cafe or McDonald or airport WiFi or whatever, it's very difficult to pinpoint where you are - the Wifi can only give them a Spherical region where you can be.

On the other hand, If you are using a mobile IP, its way easier to pinpoint your location because towers can triangulate.

But in the case of mobile, they track through IMEI & IMSI not the IP. 

Change those from time to time.

Clearly public WiFi's are better than mobile but if you are buying a Proxy, then the reverse is true.

in mobiles, they can pinpoint you but they may never know who you are, in public WiFi, they can identify you because, remember, the IP is static there.

Also don't give PII to public WiFi onboarding lol. Static IP + kyc - > they have your identity.

##
jmp.chat

https://letters.empiresec.co/p/number

## one-time verification

smspool.net

<blockquote class="twitter-tweet" data-media-max-width="560"><p lang="en" dir="ltr">Showing off the soon-to-be-released in-app onboarding flow for JMP from Cheogram Android, including setting up a Snikket instance! <a href="https://twitter.com/JMP_chat/status/1648413895357235203/video/1">pic.twitter.com/xcXLG8muVR</a></p>&mdash; JMP (@JMP_chat) <a href="https://twitter.com/JMP_chat/status/1648413895357235203/video/1">April 18, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

https://www.9esim.com/product/strengthen-package/

https://en.wikipedia.org/wiki/Public_switched_telephone_network

https://an.dywa.ng/carrier-gnss.html

https://github.com/srlabs/blue-merle/blob/main/Documentation.pdf

In Graphene OS:

Network & Internet > SIMs > Select SIM:

{{< figure
  src="images/setups/avoid_2g.jpg"
  alt="Avoid 2g Settings in Graphene OS SIMs"
  class="ma0 w-75"
>}}

{{< figure
  src="images/setups/5g_or_LTE_only.jpg"
  alt="Avoid downgrade attacks in Graphene OS SIMs"
  class="ma0 w-75"
>}}

# gl-inet mudiV2 (gl-e750v2)

https://dl.gl-inet.com/router/e750/beta

5.10.176 kernel https://lwn.net/Articles/926874/

from:@GrapheneOS hotspot

https://x.com/GrapheneOS/status/1946230891648254445?s=19

https://x.com/GrapheneOS/status/1905844919287112181

https://x.com/GrapheneOS/status/1753329219407331488

https://x.com/GrapheneOS/status/2004699245606220207

https://x.com/GrapheneOS/status/1846712535480774794

https://docs.gl-inet.com/router/en/4/faq/repair_network_or_reset_firmware/

https://github.com/openwrt/luci/wiki/Documentation

change password of wifi

change ssid

wiregaurd config

disable LCD password and Wifi SSID 

https://github.com/srlabs/blue-merle

install blue-merle > 9esim > silent.link profile, change imei from System > Advanced Settings (LuCi) > Network > blue merle before enabling new Profile (can be done via jmp esim manager)

toggle button > sim on/off

## battery

I always wondered whether having a “virtual number” better than a "normal SIM". Because you can always get prepaid / burner phones.

A virtual number can protect you from local attacks / stringrays. It isn’t attached to an IMEI/ your device or an EID and hopefully no kyc.

But calls and SMS are in plain text anyhow so using sim’s other than, for internet doesn’t make sense. Depending on your country there is of course kyc in getting SIM’s. So just use silent(dot)link?

But in different countries you get Bank OTP’s and other governmental messages through SMS, so you need a bridge. 

That’s where jmp(dot)chat guys come in, but its just US, Canada, and UK numbers for now. I heard Indian authorities don’t allow virtual numbers and there are no burner / prepaid options but you can get a SIP trunk and channels which can cost you $$$ for a shell business, which does not have SMS receiving capabilities…

So depending on your country you maybe out of options.

Atleast you can protect yourself from local attacks by having a phone in some undisclosed location and running an automation that sends the message on your favourite messenger to you.

(Android 16 + iRadio HAL v3 seems promising for downgrading attacks)

But once the message or call uses PSTN, everything is plaintext.

A few countries are switching off / have switched off PSTN, so you wanna check your country’s status.

Some companies are shifting to WhatsApp for Comms, I think that’s way better. Governments and banks should too.

Comment down below what are the options for "VoIP numbers" in your country 👇

## Identity

global sim identifier: 

{{< figure
  src="images/setups/number_identity.jpg"
  alt="phone number identifier"
  class="ma0 w-75"
>}}

## Voice

if you use 4G-only, 4G/5G-only or 5G-only then you're using VoLTE/VoNR which is an encrypted IPsec tunnel to a carrier server over TCP/IP (mobile data)

voNR (SA and NSA) > voWifi? 

https://en.wikipedia.org/wiki/List_of_5G_NR_networks

https://en.wikipedia.org/wiki/Voice_over_NR

{{< figure
  src="images/setups/voice_overrides.jpg"
  alt="Voice Overrides in Graphene OS"
  class="ma0 w-75"
>}}

## SMS

IMS/SIP via IpSec?? 
https://support.apple.com/en-us/104972

e2ee-rcs is an unspecified extension by Google, works only on google's servers, imessage gateway to rcs, apple gets plaintext maybe

https://news.ycombinator.com/item?id=43813083

https://alternativeto.net/news/2024/9/meta-to-integrate-whatsapp-and-messenger-with-third-party-chats-in-eu-to-comply-with-dma/

https://www.youtube.com/watch?v=miXRoy-5LLo

https://www.macrumors.com/2026/02/16/ios-26-4-rcs-encryption-testing/

https://www.privacyguides.org/news/2026/02/19/apple-introduces-end-to-end-encrypted-rcs-messaging-in-the-ios-26-4-beta/

https://discuss.privacyguides.net/t/apple-will-soon-support-encrypted-rcs-messaging-with-android-users/25804/7

https://www.wired.com/story/5g-security-stingray-surveillance/

https://zetier.com/5g-imsi-catcher/

https://www.eff.org/pages/cell-site-simulatorsimsi-catchers

## Video

https://booth.video/about

https://support.google.com/meet/answer/12387251?hl=en

https://element.io/blog/secure-video-conferencing-for-matrix/

https://support.apple.com/en-in/guide/security/seca331c55cd/web

## eSIM "server"

https://discuss.privacyguides.net/t/privacy-differences-between-esim-vs-physical-sim/32629/4

## VpnHotspot

Graphene OS then 

https://projectblack.io/blog/google-pixel-root-guide/

then 

https://github.com/Mygod/VPNHotspot

then

https://codeberg.org/luxferre/lexipwn

## Starlink?

having a buffer router is the way to go. 

https://letters.empiresec.co/p/starlink

## Addendum A: Videos

https://www.youtube.com/watch?v=wVyu7NB7W6Y





<script src="https://giscus.app/client.js" data-repo="securitybrahh/empiresec.co" data-repo-id="R_kgDOOL5WwA" data-category="General" data-category-id="DIC_kwDOOL5WwM4CpBdp" data-mapping="pathname" data-strict="1" data-reactions-enabled="1" data-emit-metadata="1" data-input-position="top" data-theme="catppuccin_mocha" data-lang="en" data-loading="lazy" crossorigin="anonymous" async> </script>
