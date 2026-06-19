# Sofia Decorations - Desarrollo de Módulos Personalizados

## 📋 Estructura del Proyecto

```
WebSite_SofiaDecorations/
├── docker-compose.yml       # Configuración de contenedores
├── init-db.sh              # Script inicialización base de datos
├── secrets/                # Credenciales (gitignored)
├── logs/                   # Logs de Odoo
└── custom-addons/          # Módulos personalizados
    └── sofia_base/         # Módulo base del proyecto
        ├── __init__.py
        ├── __manifest__.py
        ├── models/
        ├── views/
        └── static/
```

## 🚀 Inicio Rápido

### 1. Levantar los contenedores
```bash
docker-compose up -d
```

### 2. Acceder a Odoo
- URL: http://localhost:8069
- Base de datos: `postgres`
- Usuario/Contraseña: Ver en `secrets/db_user.txt` y `secrets/db_password.txt`

### 3. Instalar el módulo base
1. Ir a Apps → Buscar "Sofia Decorations - Base"
2. Hacer clic en "Instalar"

## 📦 Crear un Nuevo Módulo

### Estructura recomendada
```
custom-addons/nuevo_modulo/
├── __init__.py
├── __manifest__.py
├── models/
│   ├── __init__.py
│   └── tu_modelo.py
├── views/
│   ├── tu_modelo_views.xml
│   └── menus.xml
├── static/
│   ├── description/
│   │   ├── index.html
│   │   └── icon.png
│   └── js/
└── data/
    └── datos_iniciales.xml
```

### Plantilla de __manifest__.py
```python
{
    'name': 'Sofia - Tu Módulo',
    'version': '17.0.1.0.0',
    'category': 'Custom',
    'depends': ['sofia_base'],  # Depende de nuestro módulo base
    'data': [
        'views/menus.xml',
        'views/tu_modelo_views.xml',
        'data/datos_iniciales.xml',
    ],
    'installable': True,
}
```

## 🛠️ Desarrollo

### Cambios en tiempo real
- Los archivos en `custom-addons/` se sincronizan automáticamente
- Después de cambios en Python: **Actualizar el módulo en Apps**
- Después de cambios en XML: **Actualizar el módulo en Apps**

### Ver logs
```bash
docker-compose logs -f odoo
```

### Acceder a bash del contenedor
```bash
docker-compose exec odoo bash
```

### Reiniciar contenedores
```bash
docker-compose restart odoo
```

## 📝 Convenciones del Proyecto

1. **Nombres de modelos**: `sofia_xxx` (en minúsculas, con guiones bajos)
2. **Nombres de carpetas**: `sofia_nombremodulo` (minúsculas)
3. **Idioma**: Español en comentarios y descripciones
4. **Versionado**: Seguir semántica: `17.0.MAJOR.MINOR.PATCH`

## 🔗 Recursos

- [Documentación oficial Odoo 17](https://www.odoo.com/documentation/17.0/)
- [Desarrollo de módulos](https://www.odoo.com/documentation/17.0/es_ES/developer/index.html)
- [Models API](https://www.odoo.com/documentation/17.0/es_ES/developer/reference/backend/orm.html)

## ⚙️ Variables de entorno disponibles

En `docker-compose.yml`:
- `HOST`: Servidor PostgreSQL (db)
- `PORT`: Puerto PostgreSQL (5432)
- `LANG` / `LC_ALL`: Idioma (es_ES.UTF-8)
- `ODOO_ADDONS`: Ruta de módulos personalizados (/mnt/extra-addons)

## 📚 Próximos Pasos

1. ✅ Crear módulo base (`sofia_base`) - HECHO
2. ⏳ Crear módulo de productos personalizados
3. ⏳ Crear módulo de configuración de decoraciones
4. ⏳ Crear módulo de reportes

---

**Última actualización**: 2026-06-19
