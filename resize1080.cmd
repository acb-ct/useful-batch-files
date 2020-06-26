@echo off
cls
setlocal

rem Copyright (c) 2020 Achim Barczok (achim@barczok.de)
rem All rights reserved.

rem Requires Irfanview


rem File type
set filetype=*.jpg

rem Width
set width=1080

rem JPEG quality
set quality=75

rem temporary file
set tmpfile="%temp%\imageinfo.txt"

echo Converting...
for /r "%~1" %%a in (%filetype%) do call :Resize "%%a"

:resize
"C:\Program Files (x86)\IrfanView\i_view32.exe" %1 /info=%tmpfile%
set imagewidth=0
for /f "tokens=4 delims= " %%b in ('type %tmpfile% ^| find /i "image dimensions"') do set /a imagewidth=%%b
if "%imagewidth%" gtr "%width%" (
 echo Resizing file "%~1"
 "C:\Program Files (x86)\IrfanView\i_view32.exe" "%~1" /resize_long=%width% /aspectratio /resample /jpgq=%quality% /convert="C:\Users\%USERNAME%\Desktop\upload.jpg"
)