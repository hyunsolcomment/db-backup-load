@echo off

:: MYSQL bin 폴더
set MYSQL_PATH="C:\Program Files\MariaDB 10.11\bin"

:: 배치파일 경로
set ORIGIN_PATH=%~dp0

C:
cd %MYSQL_PATH%

:set_mysql_credentials
echo.
echo 현재 MySQL bin 폴더 경로: %MYSQL_PATH%
echo (경로가 올바르지 않다면 배치파일에서 수정하셈)
echo.
set /p mysql_user=mysql 사용자 이름: 
set /p mysql_password=mysql 암호: 

:main_menu
cls
echo.
echo 	1. 백업하기
echo 	2. 불러오기
echo.
set /p choice=번호 입력: 
if "%choice%"=="1" goto backup
if "%choice%"=="2" goto restore
goto main_menu

:backup
cls
set /p dbname=백업할 DB 이름: 
cd %MYSQL_PATH%
mysqldump -u %mysql_user% -p%mysql_password% %dbname% > %ORIGIN_PATH%/DB/%dbname%.sql
echo 백업 끗
pause > NUL
goto main_menu

:restore
cls
echo.
echo 백업된 DB 목록:
for %%i in (%ORIGIN_PATH%/DB/*.sql) do echo  - %%~ni
echo.
set /p restoredb=불러올 DB 이름: 
cd %MYSQL_PATH%
mysql -u %mysql_user% -p%mysql_password% %restoredb% < %ORIGIN_PATH%/DB/%restoredb%.sql
echo 불러왔스빈당
pause > NUL
goto main_menu
