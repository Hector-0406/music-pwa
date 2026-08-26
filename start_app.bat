@echo off
setlocal
title Music App

:: Configuración de caracteres para color ANSI en CMD
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set "ESC=%%b"

echo ==== Iniciando servidor ====

set PUERTO=3300
set URL=http://localhost:3300

:: Pausa de 5 segundos compatible con Git Bash, CMD y PowerShell
ping 127.0.0.1 -n 6 >nul

:: Mostrar información al usuario
echo.
echo URL: %ESC%[94m%URL%%ESC%[0m
echo Carpeta: /app
echo Logs: %ESC%[93mserver.log%ESC%[0m
echo Apagar servidor: %ESC%[93mPresiona una tecla%ESC%[0m

:: Inicia el servidor enviando los logs a server.log en segundo plano
start /B python -m http.server %PUERTO% --directory ./app > server.log 2>&1

:: Verificación rápida del inicio
if %ERRORLEVEL% equ 0 (
  echo Estado: %ESC%[92mServidor corriendo en background%ESC%[0m
) else (
  echo %ESC%[91mError al iniciar el servidor.%ESC%[0m
  exit /b 1
)

:: Abrir el navegador por defecto
start %URL%

:: Detener el proceso cualquier tecla
echo.
pause >nul
taskkill /F /IM python.exe >nul 2>&1
echo %ESC%[91mServidor detenido.%ESC%[0m