---
title: "Why forwardemail is one of a kind"
date: 2026-04-03T00:00:52Z
# weight: 1
aliases: ["/forwardemail"]
tags: ["email", "smtp", "encryption", "identity", "domain"]
author: "Security Brahh"
description: "Email can be salvaged!!"
draft: false
---

# Why forwardemail is one of a kind

https://forwardemail.net/en/blog/docs/email-protocols-rfc-compliance-imap-smtp-pop3-comparison#dane-dns-based-authentication-of-named-entities

here is exactly how it works in the 100% open-source codebase:

The emails are encrypted with the SMTP password (the generated alias password). The SQLite database file is encrypted at rest using ChaCha20-Poly1305, and the encryption key is your password. The staff cannot access the mailbox contents.

the code that enforces this:

1. SQLite Encryption (PRAGMA cipher + key):
   https://github.com/forwardemail/forwardemail.net/blob/d087cd6816be680d38f74c63fe1f5630a8c4741b/helpers/setup-pragma.js#L30-L41
   - Line 36 sets the cipher to ChaCha20-Poly1305
   - Lines 37-41 set the PRAGMA key using your decrypted password
   - Line 74 enables secure_delete=ON (overwrites deleted data with zeros)

2. The encrypted SQLite driver (better-sqlite3-multiple-ciphers):
   https://github.com/forwardemail/forwardemail.net/blob/d087cd6816be680d38f74c63fe1f5630a8c4741b/helpers/get-database.js#L10

3. Password is encrypted in-memory during auth (never stored in plaintext in Redis or on disk):
   https://github.com/forwardemail/forwardemail.net/blob/d087cd6816be680d38f74c63fe1f5630a8c4741b/helpers/on-auth.js#L275

4. The AES-256-GCM encryption used to wrap the password in the session:
   https://github.com/forwardemail/forwardemail.net/blob/d087cd6816be680d38f74c63fe1f5630a8c4741b/helpers/encrypt-decrypt.js#L36-L70

5. Password hashed with Argon2 before storage (only hash + salt stored, never plaintext):
   https://github.com/forwardemail/forwardemail.net/blob/d087cd6816be680d38f74c63fe1f5630a8c4741b/helpers/create-password.js#L71

Regarding the account settings (domains, aliases, routing rules): these are stored in the MongoDB database and are accessible to the staff through the dashboard at https://forwardemail.net/my-account so they can help troubleshoot delivery issues. However, the actual mailbox contents (the emails, contacts, calendars) live exclusively in the encrypted SQLite databases — we cannot access them without the SMTP password.

For server-level hardening, they use Ansible to provision all infrastructure:
- Security playbook (1,484 lines): https://github.com/forwardemail/forwardemail.net/blob/d087cd6816be680d38f74c63fe1f5630a8c4741b/ansible/playbooks/security.yml
- Ansible documentation: https://github.com/forwardemail/forwardemail.net/blob/d087cd6816be680d38f74c63fe1f5630a8c4741b/ansible/README.md

caldav/carddav/etc is all in same sqlite file (encrypted with the imap/smtp password, the staff don't have access)

## What MX records expose:

Every domain using Forward Email points to the same shared MX servers: mx1.forwardemail.net and mx2.forwardemail.net. These are public DNS records — anyone can run "dig MX yourdomain.com" and see them. So yes, an observer can determine "this domain uses Forward Email" just by looking at the MX records. However, that's the only thing MX records reveal. They do not expose who owns the domain, what aliases exist, where mail is forwarded, or any email content.

### Can someone correlate vanity domains?

In theory, if someone owns alice-secret.com and alice-work.com, and both point to mx1/mx2.forwardemail.net, an observer could note they both use the same email provider. But this is a very weak signal — over 1.6M+ domains use Forward Email, including the US Naval Academy, Netflix Games, the Linux Foundation, Canonical, Tufts University, the University of Cambridge, and the Government of South Australia (Whitepaper p.1, Abstract — https://forwardemail.net/technical-whitepaper.pdf#page=1). Correlating two domains just because they share MX records would be like correlating two websites because they both use Cloudflare.

### The actual privacy risk: DNS TXT records (free plan only)

The more significant exposure is on the free plan, where forwarding is configured via plaintext DNS TXT records like forward-email=user@gmail.com. These TXT records are publicly queryable and reveal your forwarding destination. Forward Email addresses this with two mitigations:

1. Encrypted TXT records — available at no cost even on the free plan at https://forwardemail.net/en/encrypt. This tool encrypts your TXT record so the forwarding destination is hidden from public DNS queries.

2. Paid plan — aliases are configured via the web dashboard, not DNS. No forwarding destinations appear in DNS at all. Only the shared MX records are visible.

What Forward Email does NOT leak:

The Privacy Policy (https://forwardemail.net/en/privacy) and Technical Whitepaper (https://forwardemail.net/technical-whitepaper.pdf) confirm:

- No email content or metadata stored to disk — forwarding is entirely in-memory (Whitepaper p.15, Metadata Protection)
- No logs, no IP addresses stored (Privacy Policy, "Information Not Collected")
- Zero-knowledge architecture — encryption keys derived from user passwords, not stored on servers (Whitepaper p.17, Zero-Knowledge Architecture)
- Sandboxed encrypted SQLite mailboxes using ChaCha20-Poly1305 (Whitepaper p.16, Sandboxed Encryption)
- DNS over HTTPS for all DNS queries, preventing ISPs from monitoring DNS traffic (Whitepaper p.44, DNS Infrastructure)
- No third-party analytics or telemetry

Relevant FAQ entry:

"We use MX and TXT record verification, therefore if you add this service's respective MX and TXT records, then you're registered. If you remove them, then you're unregistered. You have ownership of your domain and DNS management."
— FAQ: "Can people unregister or register my email forwarding without my permission" (https://forwardemail.net/en/faq)

Bottom line: The MX records are a shared signal across 1.6M+ domains — knowing someone uses Forward Email tells you very little. If you want to eliminate even the TXT record exposure, use the encrypted TXT record tool (https://forwardemail.net/en/encrypt) (free) or upgrade to a paid plan where aliases are configured entirely via the dashboard.

## Metadata

The service don't store email metadata to disk — no sender addresses, recipient addresses, subjects, timestamps, or IPs are persisted. Email processing happens entirely in-memory. Once the message is delivered, that data is gone.  Only headers remain for 7 days typically on most error logs (only for 4xx and 5xx errors), and outbound SMTP message retention time can be configured for retention as well in Settings page (headers only, not body).

For IMAP mailboxes on paid plans, the emails (including headers/metadata) are stored in individually encrypted SQLite databases using ChaCha20-Poly1305. The encryption key is derived from the SMTP password — the staff don't have it and can't access your mailbox contents.

The service don't collect phone numbers, device IDs, or login history. No recovery emails. No tracking pixels. No read receipts.

1. No email content stored to disk during forwarding  
  
The entire MX inbound pipeline lives in helpers/on-data-mx.js. Email data stays in Node.js Buffer objects in memory --- there's **_no_** fs.writeFile or createWriteStream anywhere in the forwarding path:  
  
[https://github.com/forwardemail/forwardemail.net/blob/master/helpers/on-data-mx.js\#L474](https://github.com/forwardemail/forwardemail.net/blob/master/helpers/on-data-mx.js#L474)  
[https://github.com/forwardemail/forwardemail.net/blob/master/helpers/on-data-mx.js\#L1987-L2004](https://github.com/forwardemail/forwardemail.net/blob/master/helpers/on-data-mx.js#L1987-L2004)  
  
Forwarding builds the message as Buffer.concat(\[headers.build(), body\]) and sends it directly over SMTP. IMAP delivery sends the raw buffer over WebSocket to the SQLite server --- never touches disk on the MX server:  
  
[https://github.com/forwardemail/forwardemail.net/blob/master/helpers/on-data-mx.js\#L482-L499](https://github.com/forwardemail/forwardemail.net/blob/master/helpers/on-data-mx.js#L482-L499)  
  
2. Encrypted SQLite mailboxes (ChaCha20-Poly1305)  
  
Each mailbox is an individually encrypted SQLite database using better-sqlite3-multiple-ciphers (SQLCipher-compatible). The default cipher is chacha20 and the encryption key is the SMTP password --- The service decrypt it only at open time, never store it:  
  
[https://github.com/forwardemail/forwardemail.net/blob/master/helpers/setup-pragma.js\#L30-L41](https://github.com/forwardemail/forwardemail.net/blob/master/helpers/setup-pragma.js#L30-L41)  
  
Line 30: cipher defaults to 'chacha20'  
Line 36: db.pragma(\`cipher='${cipher}'\`)  
Line 38: db.key(Buffer.from(decrypt(session.user.password)))  
  
The database module itself:  
[https://github.com/forwardemail/forwardemail.net/blob/master/helpers/get-database.js\#L10](https://github.com/forwardemail/forwardemail.net/blob/master/helpers/get-database.js#L10)  
  
3. Zero-knowledge --- encryption key derived from SMTP password  
  
During auth, the password is encrypted in-memory and attached to the session. It's never stored in Redis or on disk:  
  
[https://github.com/forwardemail/forwardemail.net/blob/master/helpers/on-auth.js\#L984](https://github.com/forwardemail/forwardemail.net/blob/master/helpers/on-auth.js#L984)  
[https://github.com/forwardemail/forwardemail.net/blob/master/helpers/on-auth.js\#L1020-L1022](https://github.com/forwardemail/forwardemail.net/blob/master/helpers/on-auth.js#L1020-L1022)  
  
Line 984: password: encrypt(auth.password) --- encrypted in session  
Line 1022: const { password: \_pw, ...userWithoutPassword } = user --- stripped before Redis cache  
  
The encrypt/decrypt implementation supports multiple cipher versions (AES-256-GCM current, ChaCha20-Poly1305 legacy, XWing quantum-resistant future):  
  
[https://github.com/forwardemail/forwardemail.net/blob/master/helpers/encrypt-decrypt.js](https://github.com/forwardemail/forwardemail.net/blob/master/helpers/encrypt-decrypt.js)  
  
4. Error logs retain headers only, body is redacted  
  
Outbound SMTP message retention is configurable per-domain (0-30 days). After the retention period, the body is replaced with a redaction notice --- only headers remain:  
  
[https://github.com/forwardemail/forwardemail.net/blob/master/app/models/emails.js\#L1010-L1069](https://github.com/forwardemail/forwardemail.net/blob/master/app/models/emails.js#L1010-L1069)  
  
Line 1012-1020: retention\_days check  
Line 1060-1069: Body replaced with "This message was successfully sent. It has been redacted and purged for your security and privacy."  
  
The retention\_days setting on the domain model:  
[https://github.com/forwardemail/forwardemail.net/blob/master/app/models/domains.js\#L319-L322](https://github.com/forwardemail/forwardemail.net/blob/master/app/models/domains.js#L319-L322)  
  
5. Passwords scrubbed from error logs  
  
Before any log is saved, passwords are explicitly deleted from the payload:  
  
[https://github.com/forwardemail/forwardemail.net/blob/master/app/models/logs.js\#L459-L462](https://github.com/forwardemail/forwardemail.net/blob/master/app/models/logs.js#L459-L462)  
  
6. No third-party analytics or telemetry  
  
Analytics is 100% first-party and self-hosted. IP addresses are used only for a daily-rotating session hash --- never stored. Events go to service's MongoDB, not to any external service:  
  
[https://github.com/forwardemail/forwardemail.net/blob/master/helpers/analytics.js\#L359-L365](https://github.com/forwardemail/forwardemail.net/blob/master/helpers/analytics.js#L359-L365)  
[https://github.com/forwardemail/forwardemail.net/blob/master/helpers/analytics.js\#L410-L412](https://github.com/forwardemail/forwardemail.net/blob/master/helpers/analytics.js#L410-L412)  
[https://github.com/forwardemail/forwardemail.net/blob/master/helpers/analytics.js\#L498-L501](https://github.com/forwardemail/forwardemail.net/blob/master/helpers/analytics.js#L498-L501)  
  
Line 362: "This is NOT a persistent identifier - it rotates daily"  
Line 412: "IP address (used for session hash only, NOT stored)"  
  
**_There's no Google Analytics, Mixpanel, Segment, or any third-party tracking SDK anywhere in the codebase. You can grep for it yourself.  
_**

7. No tracking pixels or read receipts  
  
**_The service doesn't inject tracking pixels or read receipt beacons into forwarded or delivered emails. There is zero code in the forwarding pipeline (on-data-mx.js) or IMAP delivery path that adds any tracking content to messages._**  
  
The entire codebase is open source --- you're welcome to audit any of it.
