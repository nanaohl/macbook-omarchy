# Next Steps for Wi-Fi Troubleshooting

If adding the kernel parameter did not fix your Wi-Fi, here are the next steps to try. Run these commands in your terminal.

## 1. Check for the correct firmware

The `brcmfmac` driver requires a specific firmware file to work. This step checks if the file is on your system.

**Command to run:**
```bash
ls -l /lib/firmware/brcm/brcmfmac43602-pcie.bin
```

**What to look for:**
If the command returns "No such file or directory", the firmware is missing. If it shows the file, the firmware is present.

## 2. Check your network manager

This checks if Arch's network management service is running.

**Command to run:**
```bash
systemctl status NetworkManager
```

**What to look for:**
The output should include a line that says `Active: active (running)`.

## 3. Check for a kill switch

This checks if your Wi-Fi card has been disabled by a software or hardware switch.

**Command to run:**
```bash
rfkill list
```

**What to look for:**
Check if your wireless device is listed as "Soft blocked: yes" or "Hard blocked: yes". If both are "no", then it is not blocked.