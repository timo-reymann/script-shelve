# 
# This script stops the spooler service of windows, clears all printer jobs and restarts the service afterwards
#
echo "Stop pooler service ..."
net stop spooler

echo "Delete all printer jobs ..."
del %systemroot%\System32\spool\printers\* /Q /F /S

echo "Starting spooler service again ..."
net start spooler

echo "Done."
