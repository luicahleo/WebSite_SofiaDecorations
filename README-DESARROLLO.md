# Guía de Desarrollo - Sofia Decorations Website

## 🏗️ Estructura del Proyecto

```
c:\WFuentesNet\Ariel\WebSite_SofiaDecorations\
├── docker-compose.yml          # Orquestación de contenedores
├── init-db.sh                  # Script inicialización DB
├── .gitignore                  # Archivos a excluir de Git
├── secrets/                    # Credenciales (NO versionar)
├── odoo-source/                # ⭐ Solo referencia LOCAL - NO montar
│   ├── addons/                 # Módulos estándar de Odoo
│   └── ...
└── custom-addons/              # ✅ Tus módulos personalizados (VERSIONAR)
    ├── website/                # Módulo website modificado
    │   ├── __manifest__.py
    │   ├── models/
    │   ├── views/
    │   ├── controllers/
    │   └── static/
    └── (otros módulos)
```

## 🚀 Workflow de Desarrollo

### 1. Configuración Inicial

```bash
# Ya hecho, pero si necesitas reiniciar:
docker-compose up -d
```

### 2. Desarrollar Módulos

- Edita los archivos en `custom-addons/website/` desde VS Code
- Los cambios se reflejan **inmediatamente** en el contenedor (volumen montado)
- Recarga Odoo en el navegador: `http://localhost:8069`

### 3. Versionar Cambios

```bash
# Ver cambios
git status

# Agregar cambios (solo custom-addons)
git add custom-addons/

# Commit
git commit -m "Descripción del cambio"

# Push
git push origin main
```

## 📁 Montajes en el Contenedor

| Origen (Local) | Destino (Contenedor) | Tipo | Propósito |
|---|---|---|---|
| `./custom-addons/` | `/mnt/extra-addons/` | bind mount (rw) | Tus módulos |
| `sofia-web-data` | `/var/lib/odoo` | volume | Datos persistentes |

## ⚠️ Qué NO Versionar

- ❌ `odoo-source/` - Código base de Odoo (es referencia local)
- ❌ `secrets/` - Credenciales
- ❌ `__pycache__/` - Bytecode Python
- ❌ `*.pyc` - Compilados Python

## 📚 Archivos Clave del Módulo `website`

```
custom-addons/website/
├── __manifest__.py          # Metadata y dependencias
├── models/
│   ├── website.py           # Modelo principal
│   ├── website_page.py      # Páginas web
│   └── ...
├── views/
│   ├── website_templates.xml
│   ├── website_pages_views.xml
│   └── ...
├── controllers/
│   └── main.py              # Rutas HTTP
└── static/src/
    ├── css/                 # Estilos
    ├── js/                  # JavaScript
    └── xml/                 # Templates Qweb
```

## 🔄 Ciclo de Cambios

1. **Edita localmente** en `custom-addons/website/`
2. **Guarda archivo** (Ctrl+S)
3. **Recarga Odoo** en navegador
4. **Probá los cambios** en `http://localhost:8069`
5. **Git commit** cuando esté listo

## 🐛 Debugging

```bash
# Ver logs del contenedor
docker-compose logs -f odoo

# Acceder al shell del contenedor
docker exec -it website_sofiadecorations-odoo-1 bash

# Ver módulos instalados en Odoo
docker exec website_sofiadecorations-odoo-1 python3 -c "
import odoo.addons
import pkgutil
addons = [name for _, name, _ in pkgutil.iter_modules(odoo.addons.__path__)]
for addon in sorted(addons):
    print(addon)
" | grep website
```

## 💾 Persistencia

- Los datos de Odoo se guardan en el volumen `sofia-web-data`
- El contenedor se puede reiniciar sin perder datos
- Los módulos en `custom-addons/` están siempre sincronizados

## 🚫 Remover odoo-source

Si quieres liberar espacio (39MB):

```bash
# Borrá la carpeta local (es solo referencia)
Remove-Item -Path "odoo-source" -Recurse -Force

# No afecta el contenedor porque ya no lo monta
```

---

**Happy coding! 🎉**
