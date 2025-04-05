---
title: "Homesec"
date: 2025-04-05T02:02:29Z
draft: false
---

![Uploading image.png…]()

Setup on Parmadrive

https://github.com/home-assistant/supervised-installer
https://docs.frigate.video/frigate/installation#home-assistant-addon
https://github.com/ZoneMinder/zmdockerfiles


Apps

https://github.com/home-assistant/android (https://companion.home-assistant.io/docs/core/android-flavors/)

Notifications

https://docs.frigate.video/guides/ha_notifications/
https://www.home-assistant.io/integrations/shell_command/
https://companion.home-assistant.io/docs/notifications/notification-local/
https://github.com/ivanmihov/homeassistant-ntfy.sh

Customer Flow
Home Layout
How may sensors+alarms+cameras needed
Send Shipment
Video Support for Installation
Diagram



Software

https://github.com/arendst/Tasmota

https://zoneminder.com/ (useful for PTZ)

https://frigate.video/
RTSP Streams (through router)
hardware
IP Cameras (PoE/LiPo/Solar Cell) 
https://templates.blakadder.com/lilygo_T-Camera-S3.html

https://templates.blakadder.com/m5stack_unitcams3.html

https://konnected.io/products/konnected-alarm-panel-pro-12-zone-kit
Android Mobile for monitoring
PTZ (Pan-tilt-zoom) camera?
doorbell? - camera + 2-way mic+speaker
Network
TP-link/D-link/gl-inet OpenWRT.
Power
APC UPS Battery Backup Surge Protector 425VA BE425M 
Solar?
Outward Comms

HA mobile push notifs
https://companion.home-assistant.io/docs/notifications/actionable-notifications/


Emails
buy cusom domain from porkbun?
add to forwardemail
setup thunderbird and k-9
https://forwardemail.net/en/email-api#outbound-emails
curl -X POST https://api.forwardemail.net/v1/emails \
  -u API_TOKEN: \
  -d "from=alias@example.com" \
  -d "to=user%40gmail.com" \
  -d "subject=test" \
  -d "text=test"

Messages
<Jmp.chat>
https://libervia.org/__b/doc/backend/libervia-cli/index.html

li profile create -j my_jid@example.org  -x mypassword profile_name

li profile connect -p profile​

echo "hi, I'm writing with li" | li message send -e omemo pierre@example.net

(note that with OMEMO, you need to have previously validated fingerprint of your contact for this to work).
Backups
https://docs.frigate.video/configuration/record/
Saving streams & alerts with timestamps on the NAS.
Appendix A: jmp
https://x.com/JMP_chat/status/1648413895357235203/video/1
Appendix B: UnifiedPush
https://unifiedpush.org/news/20250131_push_for_decentralized/
https://github.com/home-assistant/android/issues/3174
