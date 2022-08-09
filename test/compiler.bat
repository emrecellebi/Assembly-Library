@echo off

ml /c /coff src/*.asm
link /SUBSYSTEM:WINDOWS *.obj /OUT:bin/01.exe