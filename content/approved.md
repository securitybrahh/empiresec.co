---
title: "Approved"
date: 2025-03-25T00:49:58Z
draft: false
---

# Approved Products

2-3 onlykeys

yubikey series 5 nfc

coldcard mk4

bitaxe <d-central>

mudiv2, ... maybe mofi 5500

[jmp esim adapter](https://jmp.chat/esim-adapter)

silent . link

[Permanode](https://github.com/ArmanTheParman/Parmanode/pull/157)

trueNAS.com/m-series

macbook, maximum RAM for utm VM's

latest pixel, https://pixel-pricing.netlify.app, [GOS support page](https://grapheneos.org/faq#device-support)

apple music subscription, cider.sh itch.io version

upscreen spy shield

buskill

> Amazon Books and products ([one link](https://affiliate-program.amazon.com/help/node/topic/GKHRXG4YEJBTCAFC) or geni.us?)


{{ $image := resources.Get "images/approved/art-of-x.png" }}
{{ $image := $image.Process "resize 600x" }}
{{ $image := $image.Process "crop 600x400" }}
{{ $image := $image.Process "fit 600x400" }}
{{ $image := $image.Process "fill 600x400" }}
{{ with $image }}
  <a href="https://gumroad.com/a/426377683/XFFpt"><img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}"></a>
{{ end }}
