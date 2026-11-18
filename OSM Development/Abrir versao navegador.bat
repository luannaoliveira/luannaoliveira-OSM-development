@echo off
chcp 65001 >nul
cd /d "%~dp0"
rem Na pasta do dist: abre a versao navegador pelo executavel (nao precisa de Python).
if exist "%~dp0OSM Development.exe" (
  start "" "%~dp0OSM Development.exe" --navegador
  exit /b 0
)
where py >nul 2>nul
if %errorlevel%==0 (
  py -3 app.py
) else (
  where python >nul 2>nul
  if errorlevel 1 (
    echo Python nao encontrado. Instale o Python 3 em https://www.python.org/downloads/ e marque "Add python.exe to PATH".
    pause
    exit /b 1
  )
  python app.py
)
if errorlevel 1 pause
