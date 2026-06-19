@echo off
REM Script de utilidades para desarrollo Sofia Decorations (Windows)

setlocal enabledelayedexpansion

set COMMAND=%1

if "%COMMAND%"=="start" (
    echo 🚀 Levantando contenedores...
    docker-compose up -d
    echo ✅ Contenedores iniciados
    echo 🌐 Odoo disponible en: http://localhost:8069
    goto end
)

if "%COMMAND%"=="stop" (
    echo ⛔ Deteniendo contenedores...
    docker-compose down
    echo ✅ Contenedores detenidos
    goto end
)

if "%COMMAND%"=="logs" (
    echo 📋 Mostrando logs de Odoo...
    docker-compose logs -f odoo
    goto end
)

if "%COMMAND%"=="bash" (
    echo 🔧 Accediendo a bash del contenedor Odoo...
    docker-compose exec odoo bash
    goto end
)

if "%COMMAND%"=="psql" (
    echo 🗄️ Accediendo a PostgreSQL...
    docker-compose exec db psql -U postgres
    goto end
)

if "%COMMAND%"=="restart" (
    echo 🔄 Reiniciando Odoo...
    docker-compose restart odoo
    echo ✅ Odoo reiniciado
    goto end
)

if "%COMMAND%"=="rebuild" (
    echo 🔨 Reconstruyendo contenedores...
    docker-compose down
    docker-compose up -d --build
    echo ✅ Contenedores reconstruidos
    goto end
)

if "%COMMAND%"=="clean" (
    echo 🧹 Limpiando pycache y archivos temporales...
    for /d /r . %%d in (__pycache__) do if exist "%%d" rmdir /s /q "%%d" 2>nul
    goto end
)

echo 📖 Uso: develop.bat [comando]
echo.
echo Comandos disponibles:
echo   start    - Levanta los contenedores
echo   stop     - Detiene los contenedores
echo   logs     - Muestra los logs de Odoo
echo   bash     - Accede a bash del contenedor Odoo
echo   psql     - Accede a la base de datos PostgreSQL
echo   restart  - Reinicia el contenedor Odoo
echo   rebuild  - Reconstruye los contenedores
echo   clean    - Limpia archivos temporales

:end
