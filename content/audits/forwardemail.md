---
title: "Why forwardemail is one of a kind"
date: 2026-04-003T00:00:52Z
# weight: 1
aliases: ["/forwardemail"]
tags: ["email", "smtp", "encryption", "identity", "domain"]
author: "Security Brahh"
description: "Threat modeling phone numbers, SIMs, IMEI, and internet connectivity"
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

Regarding your account settings (domains, aliases, routing rules): these are stored in our MongoDB database and are accessible to us through the dashboard at https://forwardemail.net/my-account so we can help troubleshoot delivery issues. However, the actual mailbox contents (your emails, contacts, calendars) live exclusively in the encrypted SQLite databases — we cannot access them without your password.

For server-level hardening, they use Ansible to provision all infrastructure:
- Security playbook (1,484 lines): https://github.com/forwardemail/forwardemail.net/blob/d087cd6816be680d38f74c63fe1f5630a8c4741b/ansible/playbooks/security.yml
- Ansible documentation: https://github.com/forwardemail/forwardemail.net/blob/d087cd6816be680d38f74c63fe1f5630a8c4741b/ansible/README.md
