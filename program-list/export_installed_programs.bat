REM
REM This script will generate a csv file located at C:/programs.txt containing version and name for all installed programs
REM

wmic product get name,version /format:csv > C:/programs.txt
