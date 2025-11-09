#!/bin/bash
# PAM_USER provided via env by pam_exec? Not always. Use PAM_USER or read from stdin?
# pam_exec passes PAM_USER via environment variable PAM_USER.
USERNAME="${PAM_USER}"

# Search common automount points for open.txt
# check run/media, /media, /mnt, /run/media/*/*
FOUND=0
for base in /run/media /media /mnt /tmp; do
  # recurse two levels to find open.txt
  find "${base}" -maxdepth 3 -type f -name 'open.txt' 2>/dev/null | while read -r f; do
    read -r candidate < "$f" || continue
    candidate=$(echo "$candidate" | tr -d '\r\n')
    if [ "$candidate" = "$USERNAME" ]; then
      FOUND=1
      break 2
    fi
  done
done

if [ "$FOUND" -eq 1 ]; then
  # extra safety: ensure user exists
  if id -u "$USERNAME" >/dev/null 2>&1; then
    exit 0
  fi
fi

exit 1
