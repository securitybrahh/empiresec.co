---
title: "Mac"
date: 2025-03-31T14:24:44Z
draft: false
---

you should run an insecure app in a vm, ideally but sandbox-exec is nice as well - eg to run zoom -- https://gist.github.com/cielavenir/02f322e322a2a3555dbf2b38f2fedd59

https://github.com/sunknudsen/privacy-guides/tree/master/how-to-spoof-mac-address-and-hostname-automatically-at-boot-on-macos

https://github.com/sunknudsen/privacy-guides/tree/master/how-to-disable-cups-printer-job-history-on-macos

# Driver

https://gofetch.fail/, [fix](https://social.treehouse.systems/@marcan/112238385679496096)

My daily driver Config

https://support.apple.com/en-us/HT201222 on mullvad browser autostart

## VPN

"Our macOS app installs a [Network Extension](https://developer.apple.com/system-extensions/), which is a fully sandboxed process with no kernel-level access to your system." - Obscura

"AFAIK all traffic is now adequately routed thru the network extensions
meaning, firewalls should be able now be comprehensive"

check via charles proxy, wireshark, router logs.

is it bypasses utm, VM's, containers, docker, etc? how extensive

## M1 Pro 32 GB

Karabiner Elements - commamd key to open launchpad,  

command + e - finder

option+tab - scroll through apps

buy a used one preferabilly with cash.

connect to a router with vpn / android with [vpnhotspot](https://github.com/Mygod/VPNHotspot)

create media usb disk 

reset, reboot

activate via vpn only (other device)

generic computer name & strong pass phrase

any privacy related prompt - disable.

fix your timezone to some other country - if you are not in New York, Ney York time is nice.

disable touch id, siri etc

Enable Firewall

"pool.ntp.org"

disable everything

automatic security updates

change dns to mullvad - dns.mullvad.net

switch on filevault

```
softwareupdate --install-rosetta --agree-to-license
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install --cpolicies
kknock
brew install --cask taskexplorer
```

```
sudo mdutil -a -i off
sudo mdutil -s /
sudo spctl --master-disable
sudo mdutil -X /
```


install little snitch, allow only stuff you need to stuff you allow.

mullvad browser

mullvad vpn

edge with policies

taskexplorer + knockknock + activity monitor

system information

## UTM

shared directory

acceleration

usb passthrough

spice tools

### Windows 11 ltsc iot

active directory

switch off hibernation / swap file

mullvad vpn

qemu

hard configurator 

// portmaster not available on ARM rn

I use this for ms office mainly, rarely adobe aftereffects (seamless mode??)

firefox dev edition with arken fox  & ublock

edge with policies

ms office & edge is working through prism prob

### Fedora Silverblue

with **apple virtusalization**

swap ctrl & super with gnome tweaks

keyboard shortcuts

remove bloat

my apps on deck, photogimp, freetube

flatseal

wireguard config of mullvad

ungoogled chromium 

arkenfox firefox dev

mullvad ARM

cromite?

edge ARM linux not available (maybe emulate with qemu/box86/rosetta-flatpack)

hardenedmalloc in flatpack, disable zram

disable null passwords

hardened ssh, kernel, disabled coredump,

xwayland???, hardened dconf

gnome extensions as a flatpack package

MAC/DAC/umask/private home

hardened chrony - correct timezone on pocket watch

dnf alias for toolbox, rpm-ostree for removal, layering?

fwupd, microcode, bios

tuned, tlp

hardened firewalld, networkmanager, mac randomization, dnssec unbound,

### Macos

You can test stuff here

adguard mac

edge

mullvad

tor

lulu

charles proxy / wireshark

## Apps

Element Desktop

Thunderbird

Obsidian with git-crypt

jdownloader2 

qbittorent

## Browsing

default cookie autodelete, save history, can firefix sync, no image & js loading, balanced tracking protection, rfp, send do not track, create exceptions for indivdual sites.

mullvad is esr, be warned.

temp container vs profile

ublock lite/home with filters

predirect

request controller / no script

user agent of edge is best

to verify risky url's first - fast forward, url haus better, only trusted domains though...

### Human Experience

https://github.com/dessant/buster
