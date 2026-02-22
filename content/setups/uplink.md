---
title: "Phone Number and the internet"
date: 2026-02-21T00:00:52Z
# weight: 1
aliases: ["/uplink"]
tags: ["number", "privacy", "security", "Internet", "router"]
author: "Security Brahh"
description: "state of Encryption on whatsapp"
draft: false
---

# Phone Number and Internet Connectivity

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

## Location

## KYC

if you have to buy a sim with kyc, buy it with an ID that makes it difficult to centralize tracking

for eg, don't use a passport

in India, don't use Aadhar

https://www.phonetravelwiz.com/phone-travel-options/sim-card-registration/

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

voNR (SA and NSA) > voWifi? 

https://en.wikipedia.org/wiki/List_of_5G_NR_networks

https://en.wikipedia.org/wiki/Voice_over_NR

{{< figure
  src="images/setups/voice_overrides.jpg"
  alt="Voice Overrides in Graphene OS"
  class="ma0 w-75"
>}}

## SMS

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
