#!/usr/bin/env python3
"""Wait for an OTP/verification code in an assistant-owned mails.dev mailbox.

Reads the mailbox API key from ~/.mails/<name>.json (mode 600 config written by
the claim flow; keys: api_key, mailbox, default_from, domain, mode,
storage_provider). The API key is never printed. Output is a single JSON line:
{"found": true, "code": "...", "email_id": "..."} or {"found": false}.

Usage:
  mailbox_wait_code.py --config myproject --sender kaggle --timeout 120
  mailbox_wait_code.py --config clientb --subject "verify" --digits 6
"""
import argparse
import json
import os
import re
import sys
import time
import urllib.request
import urllib.error

API_BASE = os.environ.get("MAILS_API_BASE", "https://api.mails.dev")


def load_key(config_name):
    path = os.path.expanduser(os.path.join("~", ".mails", config_name + ".json"))
    if not os.path.exists(path):
        sys.exit(f"mailbox config not found: {path}")
    with open(path) as f:
        cfg = json.load(f)
    key = cfg.get("api_key")
    if not key:
        sys.exit(f"no api_key in {path}")
    return key, cfg.get("mailbox", "")


def api_get(key, path):
    req = urllib.request.Request(API_BASE + path, headers={
        "Authorization": f"Bearer {key}",
        "Accept": "application/json",
    })
    with urllib.request.urlopen(req, timeout=30) as resp:
        return json.load(resp)


def extract_code(text, digits):
    # Prefer codes near cue words, then any standalone digit run of the length.
    if digits:
        m = re.search(r"(?:code|verify|verification|otp)[^0-9]{0,40}(\d{%d})" % digits,
                      text, re.I)
        if m:
            return m.group(1)
        m = re.search(r"(?<!\d)(\d{%d})(?!\d)" % digits, text)
        return m.group(1) if m else None
    m = re.search(r"(?:code|verify|verification|otp)[^0-9]{0,40}([A-Z0-9]{4,10})",
                  text, re.I)
    return m.group(1) if m else None


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--config", required=True, help="name of ~/.mails/<name>.json")
    ap.add_argument("--sender", default="", help="sender substring filter")
    ap.add_argument("--subject", default="", help="subject substring filter")
    ap.add_argument("--digits", type=int, default=6, help="code length (0 = alphanumeric)")
    ap.add_argument("--timeout", type=int, default=120, help="seconds to poll")
    ap.add_argument("--interval", type=int, default=5, help="poll interval seconds")
    ap.add_argument("--seen-file", default="", help="JSON file of already-seen email ids")
    args = ap.parse_args()

    key, _mailbox = load_key(args.config)
    seen = set()
    if args.seen_file and os.path.exists(args.seen_file):
        seen = set(json.load(open(args.seen_file)))

    deadline = time.time() + args.timeout
    while True:
        try:
            inbox = api_get(key, "/v1/inbox")
        except (urllib.error.URLError, ValueError) as e:
            print(json.dumps({"found": False, "error": str(e)}))
            return 1
        emails = inbox if isinstance(inbox, list) else inbox.get("emails", inbox.get("data", []))
        for em in emails:
            eid = str(em.get("id", ""))
            if not eid or eid in seen:
                continue
            frm = (em.get("from") or em.get("sender") or "")
            subj = (em.get("subject") or "")
            if args.sender and args.sender.lower() not in frm.lower():
                continue
            if args.subject and args.subject.lower() not in subj.lower():
                continue
            try:
                full = api_get(key, f"/v1/email?id={eid}")
            except (urllib.error.URLError, ValueError):
                full = em
            body = " ".join(str(full.get(k, "")) for k in
                            ("subject", "body", "text", "html", "snippet"))
            code = extract_code(body or subj, args.digits)
            if code:
                print(json.dumps({"found": True, "code": code, "email_id": eid}))
                return 0
            seen.add(eid)
        if time.time() >= deadline:
            print(json.dumps({"found": False}))
            return 1
        time.sleep(args.interval)


if __name__ == "__main__":
    sys.exit(main())
