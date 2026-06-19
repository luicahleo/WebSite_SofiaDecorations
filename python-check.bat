@echo off
REM Script para ejecutar herramientas de análisis estático Python
REM Equivalente a "dotnet build" en .NET

setlocal enabledelayedexpansion

set COMMAND=%1

if "%COMMAND%"=="check" (
    echo 🔍 Ejecutando verificaciones de calidad de código...
    echo.
    
    echo 📋 1. Ejecutando Black (formatter)...
    black --check --line-length=120 custom-addons
    if errorlevel 1 (
        echo ⚠️  Hay archivos que necesitan formato. Ejecuta: python-check fix
    )
    echo.
    
    echo 📋 2. Ejecutando mypy (type checking - como compilación)...
    mypy custom-addons --ignore-missing-imports --show-error-codes
    echo.
    
    echo 📋 3. Ejecutando Pylint (análisis estático)...
    pylint custom-addons --rcfile=.pylintrc
    echo.
    
    echo 📋 4. Ejecutando Flake8 (estilo y errores)...
    flake8 custom-addons --max-line-length=120
    echo.
    
    echo ✅ Verificación completada!
    goto end
)

if "%COMMAND%"=="fix" (
    echo 🔧 Arreglando formato automáticamente...
    echo.
    
    echo 📋 1. Black (formateador)...
    black --line-length=120 custom-addons
    echo.
    
    echo 📋 2. isort (organizador de imports)...
    isort custom-addons --profile=black --line-length=120
    echo.
    
    echo ✅ Código formateado!
    goto end
)

if "%COMMAND%"=="test" (
    echo 🧪 Ejecutando tests con pytest...
    pytest custom-addons -v
    goto end
)

if "%COMMAND%"=="install-tools" (
    echo 📦 Instalando herramientas de análisis...
    pip install mypy pylint black flake8 pytest isort
    pip install pre-commit
    echo ✅ Herramientas instaladas!
    goto end
)

echo 📖 Uso: python-check [comando]
echo.
echo Comandos disponibles:
echo   check          - Ejecuta todas las verificaciones
echo   fix            - Arregla formato automáticamente
echo   test           - Ejecuta tests
echo   install-tools  - Instala herramientas necesarias
echo.
echo Equivalente en .NET:
echo   check  = dotnet build (valida sin ejecutar)
echo   fix    = dotnet format
echo   test   = dotnet test

:end
