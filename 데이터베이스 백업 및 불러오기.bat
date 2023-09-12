@echo off

:: MYSQL bin ����
set MYSQL_PATH="C:\Program Files\MariaDB 10.11\bin"

:: ��ġ���� ���
set ORIGIN_PATH=%~dp0

C:
cd %MYSQL_PATH%

:set_mysql_credentials
echo.
echo ���� MySQL bin ���� ���: %MYSQL_PATH%
echo (��ΰ� �ùٸ��� �ʴٸ� ��ġ���Ͽ��� �����ϼ�)
echo.
set /p mysql_user=mysql ����� �̸�: 
set /p mysql_password=mysql ��ȣ: 

:main_menu
cls
echo.
echo 	1. ����ϱ�
echo 	2. �ҷ�����
echo.
set /p choice=��ȣ �Է�: 
if "%choice%"=="1" goto backup
if "%choice%"=="2" goto restore
goto main_menu

:backup
cls
set /p dbname=����� DB �̸�: 
cd %MYSQL_PATH%
mysqldump -u %mysql_user% -p%mysql_password% %dbname% > %ORIGIN_PATH%/DB/%dbname%.sql
echo ��� ��
pause > NUL
goto main_menu

:restore
cls
echo.
echo ����� DB ���:
for %%i in (%ORIGIN_PATH%/DB/*.sql) do echo  - %%~ni
echo.
set /p restoredb=�ҷ��� DB �̸�: 
cd %MYSQL_PATH%
mysql -u %mysql_user% -p%mysql_password% %restoredb% < %ORIGIN_PATH%/DB/%restoredb%.sql
echo �ҷ��Խ����
pause > NUL
goto main_menu
