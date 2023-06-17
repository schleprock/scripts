@echo off
SET pages="https://mail.google.com/mail/u/0/#inbox" "https://calendar.google.com/calendar/b/0/r?tab=mc" "https://voice.google.com/u/0/messages"
start "" "c:\program files\google\chrome\application\chrome.exe" --new-window %pages%
