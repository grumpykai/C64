@echo off


REM Check if the local file name parameter is provided
if "%~1"=="" (
    echo Usage: %0 local_file_name
    exit /b 1
)

REM Set the local file name from the command-line parameter
set "local_file=%~1"

REM Compile
REM ..\..\retroassembler\retroassembler.exe -O=PRG %local_file%.asm 

REM Format the Floppy
..\..\vice\bin\c1541.exe -format "%local_file%,01" d64 %local_file%.d64 

REM copy PRG file to floppy
..\..\vice\bin\c1541.exe -attach %local_file%.d64 -write %local_file%.prg  %local_file%

if "%~2"=="ftp" (
    REM Prepare and execute FTP to send the disk to Ultimate-II
    echo put %local_file%.d64 /Flash/disks/%local_file%.d64 > ftpcmd.dat
    echo quit >> ftpcmd.dat
    ftp -A -s:ftpcmd.dat Ultimate-II
    del ftpcmd.dat
)

if "%~2"=="vice" (
    REM Run with VICE
    ..\..\vice\bin\x64sc.exe -autostart .\%local_file%.d64 && exit 0 || exit 1
)
