@echo off
cd /d "%~dp0"
rem Se o executavel estiver nesta pasta (pasta do dist), o atalho abre o .exe.
rem Senao, o atalho abre o OSM Development.pyw com o Python.
set "PASTA=%~dp0"
set "ARGS="
if exist "%~dp0OSM Development.exe" goto :exe

set "PYW="
for /f "delims=" %%i in ('where pythonw 2^>nul') do if not defined PYW set "PYW=%%i"
if not defined PYW for /f "delims=" %%i in ('where pyw 2^>nul') do if not defined PYW set "PYW=%%i"
if not defined PYW (
  echo Python nao encontrado. Instale o Python 3 e marque "Add python.exe to PATH".
  pause
  exit /b 1
)
set "ALVO=%PYW%"
set "ARGS="%~dp0OSM Development.pyw""
set "ICONE=%PYW%"
goto :criar

:exe
set "ALVO=%~dp0OSM Development.exe"
set "ICONE=%~dp0OSM Development.exe"

:criar
rem O Windows guarda o icone pelo caminho do arquivo. Para o atalho nunca mostrar um icone antigo,
rem o icone.ico e copiado com um nome que muda quando a imagem muda (icone-atalho-XXXXXXXX.ico).
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$pasta=$env:PASTA; $lnk=Join-Path ([Environment]::GetFolderPath('Desktop')) 'OSM Development.lnk';" ^
  "if(Test-Path -LiteralPath $lnk){Remove-Item -LiteralPath $lnk -Force};" ^
  "$ico=$env:ICONE; $orig=Join-Path $pasta 'icone.ico';" ^
  "if(Test-Path -LiteralPath $orig){$h=(Get-FileHash -LiteralPath $orig -Algorithm MD5).Hash.Substring(0,8); $novo=Join-Path $pasta ('icone-atalho-'+$h+'.ico'); Get-ChildItem -LiteralPath $pasta -Filter 'icone-atalho-*.ico' | Where-Object { $_.FullName -ne $novo } | Remove-Item -Force -ErrorAction SilentlyContinue; Copy-Item -LiteralPath $orig -Destination $novo -Force; $ico=$novo};" ^
  "$s=(New-Object -ComObject WScript.Shell).CreateShortcut($lnk); $s.TargetPath=$env:ALVO; if($env:ARGS){$s.Arguments=$env:ARGS}; $s.WorkingDirectory=$pasta; $s.IconLocation=$ico+',0'; $s.Save()"
rem atualiza o cache de icones do Windows
ie4uinit.exe -show >nul 2>&1
echo Atalho "OSM Development" criado na area de trabalho.
pause
