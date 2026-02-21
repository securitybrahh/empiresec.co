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

jmp.chat

https://letters.empiresec.co/p/number

<blockquote class="twitter-tweet" data-media-max-width="560"><p lang="en" dir="ltr">Showing off the soon-to-be-released in-app onboarding flow for JMP from Cheogram Android, including setting up a Snikket instance! <a href="https://twitter.com/JMP_chat/status/1648413895357235203/video/1">pic.twitter.com/xcXLG8muVR</a></p>&mdash; JMP (@JMP_chat) <a href="https://twitter.com/JMP_chat/status/1648413895357235203/video/1">April 18, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

https://www.9esim.com/product/strengthen-package/

https://www.wired.com/story/5g-security-stingray-surveillance/

https://zetier.com/5g-imsi-catcher/

https://www.eff.org/pages/cell-site-simulatorsimsi-catchers

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

## IP

> that Twitter post

## eSIM "server"

https://discuss.privacyguides.net/t/privacy-differences-between-esim-vs-physical-sim/32629/4

## VpnHotspot

Graphene OS then 

https://projectblack.io/blog/google-pixel-root-guide/

then 

https://github.com/Mygod/VPNHotspot

then

https://codeberg.org/luxferre/lexipwn

<script src="https://giscus.app/client.js" data-repo="securitybrahh/empiresec.co" data-repo-id="R_kgDOOL5WwA" data-category="General" data-category-id="DIC_kwDOOL5WwM4CpBdp" data-mapping="pathname" data-strict="1" data-reactions-enabled="1" data-emit-metadata="1" data-input-position="top" data-theme="catppuccin_mocha" data-lang="en" data-loading="lazy" crossorigin="anonymous" async> </script>
