@echo on

set BATCH_PATH=%~dp0
set S_ENV=env

echo %BATCH_PATH%

cd /D %BATCH_PATH%

python -m venv %S_ENV%

Call .\%S_ENV%\Scripts\activate.bat

python -m pip install --upgrade pip

pip install -r requirements.txt

pip freeze