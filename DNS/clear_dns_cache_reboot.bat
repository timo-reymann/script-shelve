REM
REM Script for clearing dns cache and rebooting PC
REM
echo "DNS-Cache is cleared ..."
ipconfig /flushdns

echo "Reboot in 3 seconds ..."
shutdown /r /t 3
