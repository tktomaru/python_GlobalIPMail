@echo off

rem �o�b�`���s�f�B���N�g�����擾
set BATCH_PATH=%~dp0
set S_ENV=env
set APP_PATH=%~dp0\src
cd /D %BATCH_PATH%

setlocal enabledelayedexpansion

cmd /k "%BATCH_PATH%\%S_ENV%\Scripts\activate.bat & cd src & python GlobalIPMail.py"

endlocal