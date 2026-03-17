@echo off
rem -- ŚCIEŻKI (zostaw jak u Ciebie) --
set IVERILOG=C:\iverilog\bin\iverilog.exe
set VVP=C:\iverilog\bin\vvp.exe
set GTKWAVE=C:\iverilog\gtkwave\bin\gtkwave.exe

rem -- NAZWY PLIKÓW TEGO PROJEKTU --
set OUT=sim_pssw305
set SRC1=pssw305_counter.v
set SRC2=tb_pssw305_counter.v
set VCD=pssw305.vcd

rem -- SPRZĄTANIE --
del /f /q "%OUT%" 2>nul
del /f /q "%VCD%" 2>nul

rem -- KOMPILACJA --
"%IVERILOG%" -g2012 -o "%OUT%" "%SRC1%" "%SRC2%"
if errorlevel 1 exit /b %errorlevel%

rem -- SYMULACJA --
"%VVP%" "%OUT%"
if errorlevel 1 exit /b %errorlevel%

rem -- ODPAL GTKWAVE JEŚLI JEST VCD --
if exist "%VCD%" (
    start "" "%GTKWAVE%" "%VCD%"
) else (
    echo Nie znaleziono pliku %VCD%. Sprawdz $dumpfile w testbenchu.
)

