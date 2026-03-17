@echo off
set IVERILOG=C:\iverilog\bin\iverilog.exe
set VVP=C:\iverilog\bin\vvp.exe
set GTKWAVE=C:\iverilog\gtkwave\bin\gtkwave.exe

del /f /q sim 2>nul

"%IVERILOG%" -g2012 -o sim alu_tb.v alu.v
if errorlevel 1 exit /b %errorlevel%

"%VVP%" sim

if exist dump.vcd start "" "%GTKWAVE%" dump.vcd
