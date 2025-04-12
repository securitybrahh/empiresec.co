---
title: "Securitybrahh"
date: 2025-03-27T04:56:59Z
draft: false
---


My Current Setup
================

Priorities:

1.  Freedom
2.  Security
3.  Usability
4.  Reasonable Privacy
5.  not LARP
6.  Robustness aka redundancy

Strictly following that order.

if you are not secure, thinking about privacy is a waste. For eg. if you switch off all comms from windows to microsoft, or mac to apple -- You won't get any security updates hence lol. The correct approach is to switch on that specific comms when [there](https://www.bleepingcomputer.com/news/microsoft/microsoft-adds-new-rss-feed-for-security-update-notifications/) is a critical update. For apple, just have [this](https://support.apple.com/en-us/100100) page on mullvad browser home and start it up at boot.

If you can't be productive, privacy doesn't matter because you didn't do anything that mattered. People who don't do actual work, get politicized. I never really cared much about [politics](https://www.youtube.com/watch?v=veY0v35aTCM&t=135).... and [words](https://www.youtube.com/watch?v=dZRSVX5NIFM&t=153).

The Privacy and Security space is filled with adult children who just want to whine and LARP'ers who don't know shit and want to disobey gov and big tech in all instances and at all costs. MarketingTards use undue fear to get attention and to obey the SEO lord.

This is my current setup, the best way to stay updated to any changes, is via [substack](https://letters.empiresec.co/) & [Telegram](https://empiresec.co/store/tg)

Work
----

I do contractual work (kinda) remotely hence I don't really have an employer nor I have to keep up with the whims of random HR people. These guys have my legal identity mostly because of historical reasons. I don't like fame, it gives you nothing and takes away everything, if you need to use a face in public, use AI generated.

Comms
-----

For work, I prefer email encrypted with [pgp](https://github.com/securitybrahh/thunderbird). For personal stuff, I prefer signal voice calls (burner number). For romance, I prefer face to face.

Living Situation
----------------

This is one of the very few cases where privacy causes security, lesser people know where you are, more security there is. I like freedom and travel hence I just rent. I have  alias ID and just tell the owner that I go by a different name than that as well. So whatever proofs the owner needs, its just backstopped to that ID. if you like to own some vehicles and/or homes its almost always better to do them under trusts / llc's. I have several mailboxes & amazon style proxies across the globe, that I use for different stuff (sometimes I just want to change the invoice to reduce customs, sometimes I just want to proxy some stuff)

Internet
----

Whenever I land to a new country, I grab any data-only [eSim](https://esimdb.com/)/[silent.link](https://silent.link) I can get without kyc (DM me for my preferences), use an [eSim adaptor](https://jmp.chat/esim-adapter), hook it into IMEI [generated](https://codeberg.org/luxferre/lexipwn) [GOS](https://github.com/nullbytepl/pixel-devinfo-parser) device.

Another option is [Mudi v2](https://www.gl-inet.com/products/gl-e750/) - https://github.com/srlabs/blue-merle. According to [GrapheneOS](https://grapheneos.social/@GrapheneOS/113319956422621755) guys mobile hotspot devices are easy to monitor by carrier operators so Pixel device maybe better.

https://github.com/davwheat/shannon-pixel-modem-nvitem-enabler-scripts

Number
-------------

I operate US/CA/[UK](https://wiki.soprani.ca/AASetup) numbers via [Cheogram](https://lettters.empiresec.co/p/number). If I think its of utmost importance that I need to get a local number -- for banking & otherwise, I just grab a prepaid sim without kyc with cash.

Laptop
------

M1, with my own [config](https://empiresec.co/store/apple). (I think we have atleast 3-5 yrs of support left on this one), though If you are going to buy, just get maximum ram and maximum storage on any m series. Macbook has the best battery life & most secure [boot process](https://support.apple.com/guide/security/boot-process-secac71d5623), and its pretty portable. You can skip MacOS completely, and just use Asahi.

I sometimes use windows apps seamlessly via parallels & game via crossover. I run a fedora silver blue ARM image (TODO: hardened via [secure blue](https://github.com/secureblue/secureblue/issues/476)) on [utm](https://mac.getutm.app/) for mullvad browser, Thunderbird and other linux stuff. The linux setup is where I do the most sensitive stuff. No need to encrypt storage inside vm's, I assume if an attacker has my mac password, it has everything. File vault is of course switched on the host. If you want to do something black hat-y its better to start from an another machine altogether (linux from the ground up). Your daily drivers should be optimized for security not privacy, unless your all operations are black hat-y (lollll -- you need to think a little).

asahi? asahi's [boot](https://leo3418.github.io/asahi-wiki-build/distroboot-process-guide/) process, [isn't](hhttps://davidalger.com/posts/fedora-asahi-remix-on-apple-silicon-with-luks-encryption/) encrypted by default.

I use ~~mullvad~~ Obscura vpn at all [times](https://mullvad.net/en/help/different-entryexit-node-using-wireguard-and-socks5-proxy).

Mobile
------

I use Graphene os, only drawback is people identifying you as a security person hence keeping their guard up. Also in a romantic pursuit, women feels the green bubble as "icky" but just use whatsapp. And you can almost always give anything a flirtatious angle.

Authentication
--------------

https://bitwarden.com/products/passwordless/

Bitwarden Stored Passkeys

[Resident Passkeys](https://developers.yubico.com/WebAuthn/WebAuthn_Developer_Guide/Resident_Keys.html) on [Onlykey](https://docs.onlykey.io/usersguide.html#security-key-advanced) {12} & [yubikey](https://docs.yubico.com/hardware/yubikey/yk-tech-manual/yk5-overview.html#id4) {100}

https://www.privacyguides.org/articles/2025/03/06/yubikey-reset-and-backup/

jArb?
-----

I have banking in Panama, Mexico and EU. And ofcourse I have nice USA credit.

Digital Arbitrage via Turkey and I buy cheaper stuff when I travel from Georgia etc.

AI
--

I use t3.chat & OpenRouter.ai

Workstation
-----------

https://github.com/juanfont/headscale

Gaming
------

https://asahilinux.org/2024/10/aaa-gaming-on-asahi-linux/

Home Server
-----------

[Parmadrive](https://parmanode.com/parmadrive/) + [homesec](https://github.com/securitybrahh/homesec/).

I don't particularly like self hosting, but you may want to:

1. 


SmartWatch / Ring / Fitness
---------------------------

ADP'd apple watch.

<script src="https://giscus.app/client.js"
        data-repo="securitybrahh/empiresec.co"
        data-repo-id="R_kgDOOL5WwA"
        data-category="General"
        data-category-id="DIC_kwDOOL5WwM4CpBdp"
        data-mapping="pathname"
        data-strict="1"
        data-reactions-enabled="1"
        data-emit-metadata="1"
        data-input-position="top"
        data-theme="catppuccin_mocha"
        data-lang="en"
        data-loading="lazy"
        crossorigin="anonymous"
        async>
</script>
