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
