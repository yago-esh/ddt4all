@echo off
cd /d "%~dp0"
python main.py --autoconnect --adapter VLINKER --speed 115200 --project X67
pause
