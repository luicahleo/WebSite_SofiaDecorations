#!/bin/bash
# Script de utilidades para desarrollo Sofia Decorations

set -e

COMMAND=$1

case $COMMAND in
  start)
    echo "🚀 Levantando contenedores..."
    docker-compose up -d
    echo "✅ Contenedores iniciados"
    echo "🌐 Odoo disponible en: http://localhost:8069"
    ;;
  
  stop)
    echo "⛔ Deteniendo contenedores..."
    docker-compose down
    echo "✅ Contenedores detenidos"
    ;;
  
  logs)
    echo "📋 Mostrando logs de Odoo..."
    docker-compose logs -f odoo
    ;;
  
  bash)
    echo "🔧 Accediendo a bash del contenedor Odoo..."
    docker-compose exec odoo bash
    ;;
  
  psql)
    echo "🗄️ Accediendo a PostgreSQL..."
    docker-compose exec db psql -U postgres
    ;;
  
  restart)
    echo "🔄 Reiniciando Odoo..."
    docker-compose restart odoo
    echo "✅ Odoo reiniciado"
    ;;
  
  rebuild)
    echo "🔨 Reconstruyendo contenedores..."
    docker-compose down
    docker-compose up -d --build
    echo "✅ Contenedores reconstruidos"
    ;;
  
  clean)
    echo "🧹 Limpiando pycache y archivos temporales..."
    find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
    find . -type f -name "*.pyc" -delete
    echo "✅ Limpieza completada"
    ;;
  
  *)
    echo "📖 Uso: ./develop.sh [comando]"
    echo ""
    echo "Comandos disponibles:"
    echo "  start    - Levanta los contenedores"
    echo "  stop     - Detiene los contenedores"
    echo "  logs     - Muestra los logs de Odoo"
    echo "  bash     - Accede a bash del contenedor Odoo"
    echo "  psql     - Accede a la base de datos PostgreSQL"
    echo "  restart  - Reinicia el contenedor Odoo"
    echo "  rebuild  - Reconstruye los contenedores"
    echo "  clean    - Limpia archivos temporales"
    ;;
esac
