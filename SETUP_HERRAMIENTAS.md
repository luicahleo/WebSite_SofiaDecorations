# ⚙️ Setup de Herramientas de Validación Estática

## 🎯 Objetivo

Convertir Python en un lenguaje **tan seguro como C#** con validación estática ANTES de ejecutar código.

## 📦 Instalación Rápida

```powershell
# 1. Instalar herramientas
python-check install-tools

# 2. Configurar pre-commit hooks (opcional pero recomendado)
pip install pre-commit
pre-commit install
```

## 🔍 Usar las Herramientas

### Opción 1: Validar TODO (Como `dotnet build`)
```powershell
python-check check
```

**Output esperado**:
```
✅ Black: All done! 100 files left unchanged.
✅ mypy: Success: no issues found in 5 source files
✅ Pylint: Your code has been rated at 9.50/10
✅ Flake8: No errors detected
```

---

### Opción 2: Formatear Código Automáticamente
```powershell
python-check fix
```

---

### Opción 3: Ejecutar Tests
```powershell
python-check test
```

---

## 🧠 VS Code - Validación en Tiempo Real

**Pylance** está activo en VS Code automáticamente:

1. **Abre un archivo Python** en `custom-addons/`
2. **Verás líneas rojas** cuando haya errores de tipo
3. **Hover sobre el error** para ver detalles
4. **Ctrl+.** para ver sugerencias de fix

### Ejemplo:
```python
# Esta línea tendrá error de tipo en VS Code:
nombre: str = 123  # ❌ Línea roja

# Pylance te dirá: "Expected str, got int"
```

---

## 📝 Type Hints - Cómo Escribir Código Validable

### Sin Type Hints (Sin Validación)
```python
def saludar(nombre):
    return f"Hola {nombre}"
```
❌ Pylance no puede validar tipos

### Con Type Hints (Con Validación)
```python
def saludar(nombre: str) -> str:
    return f"Hola {nombre}"
```
✅ Pylance valida entrada y salida

---

## 🏗️ Archivos de Configuración Creados

| Archivo | Propósito |
|---|---|
| `pyproject.toml` | Configuración central (mypy, black, isort) |
| `.pylintrc` | Configuración de Pylint |
| `.pre-commit-config.yaml` | Hooks automáticos al hacer commit |
| `.vscode/settings.json` | Configuración VS Code |
| `requirements-dev.txt` | Dependencias para desarrollo |
| `python-check.bat` | Script de validación |

---

## 🔄 Flujo Diario

### 1. Escribir Código
```python
def procesar_datos(datos: List[str]) -> int:
    """Procesa datos y retorna cantidad"""
    return len(datos)
```

### 2. Validar (antes de ejecutar)
```powershell
python-check check
```

### 3. Si hay errores, fixear automáticamente
```powershell
python-check fix
```

### 4. Ejecutar en Odoo
```powershell
.\develop.bat logs
```

---

## 💻 Comparación: .NET vs Python

```
┌─────────────────────────────────────────────────────────┐
│                       .NET                              │
├─────────────────────────────────────────────────────────┤
│  dotnet build    → Detecta errores de compilación       │
│  dotnet format   → Formatea código                      │
│  dotnet test     → Ejecuta tests                        │
│  Intellisense    → Ayuda mientras escribes              │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│                   Python Moderno                        │
├─────────────────────────────────────────────────────────┤
│  python-check check → Detecta errores de tipo (mypy)    │
│  python-check fix   → Formatea código (black)           │
│  python-check test  → Ejecuta tests (pytest)            │
│  Pylance (VS Code)  → Ayuda mientras escribes           │
└─────────────────────────────────────────────────────────┘
```

---

## ✅ Checklist de Setup

- [ ] Instaladas herramientas: `python-check install-tools`
- [ ] VS Code con Pylance instalado
- [ ] `.vscode/settings.json` configurado (incluido)
- [ ] Primer `python-check check` ejecutado sin errores
- [ ] Pre-commit hooks configurados: `pre-commit install`
- [ ] Leído archivo `VALIDACION_ESTATICA.md`

---

## 🚀 Próximos Pasos

1. **Escribe tu código con type hints**
2. **Ejecuta `python-check check`**
3. **Revisa los errores**
4. **Ejecuta `python-check fix`** para arreglar automáticamente
5. **Commit y push** (pre-commit hooks validarán todo)

---

**¡Bienvenido a Python con seguridad de tipos! 🎉**

Para más detalles, lee `VALIDACION_ESTATICA.md`
