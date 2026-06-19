# 🔍 Validación Estática SIN mypy (Usando Pylance)

## ❓ ¿Qué pasó?

`mypy` necesita compilación (Microsoft Visual C++ Build Tools) en Windows, lo que es innecesariamente complicado.

**Solución:** Usar **Pylance** que ya tienes en VS Code. Es más simple y más rápido.

---

## 🎯 Nuevo Flujo (Simplificado)

### **ANTES (Con mypy en terminal):**
```
Escribes código → python -m mypy → .\develop.bat logs
```

### **AHORA (Con Pylance en VS Code):**
```
Escribes código → Pylance valida automáticamente → .\develop.bat logs
```

---

## ✨ Ventajas de Pylance

| Aspecto | mypy (Terminal) | Pylance (VS Code) |
|---|---|---|
| **Instalación** | ❌ Necesita compilador | ✅ Ya instalado |
| **Validación** | Manual en terminal | ⚡ Automática en editor |
| **Errores** | Ves después de ejecutar | Ves MIENTRAS escribes |
| **Rapidez** | Lento (necesita compilación) | Instantáneo |
| **Confiabilidad** | Depende de compilador | Nativo de Microsoft |

---

## 🚀 Cómo Usar

### 1️⃣ **Escribir Código (Con Validación Automática)**

Abre cualquier archivo `.py` en `custom-addons/`:

```python
class Producto(models.Model):
    _name = 'sofia.producto'
    
    nombre: str = fields.Char()
    cantidad: int = fields.Integer()
    
    def calcular_precio(self, cantidad: int) -> float:
        return cantidad * 10.0  # ← Pylance valida AQUÍ automáticamente
```

**Pylance automáticamente:**
- ✅ Subraya errores en rojo
- ✅ Muestra hover con tipos
- ✅ Autocomplete inteligente
- ✅ Refactoring

### 2️⃣ **Si Hay Errores en VS Code**

Pylance los subraya en rojo:

```python
nombre: str = 123  # ← Línea roja: "Expected str, got int"
```

**Fijar error:**
- Ctrl+. → Ver sugerencias
- O simplemente corregir manualmente

### 3️⃣ **Antes de Ejecutar en Odoo**

```powershell
# Formatear código
python -m black custom-addons --line-length=120

# Ejecutar en Odoo (Pylance ya validó)
.\develop.bat logs
```

---

## 📋 El Flujo Completo

```
┌────────────────────────────────────────────────────────────────┐
│  1. Escribir Código en VS Code                                 │
│     └─→ Pylance valida en TIEMPO REAL (automático)            │
├────────────────────────────────────────────────────────────────┤
│  2. Pylance Muestra Errores (línea roja)                       │
│     └─→ Ctrl+. para sugerencias o corregir                    │
├────────────────────────────────────────────────────────────────┤
│  3. Formatear Antes de Ejecutar (Opcional)                     │
│     python -m black custom-addons --line-length=120            │
├────────────────────────────────────────────────────────────────┤
│  4. Ejecutar en Odoo                                           │
│     .\develop.bat logs                                         │
└────────────────────────────────────────────────────────────────┘
```

---

## 🔧 Herramientas Disponibles (Sin mypy)

```powershell
# Formatear código
python -m black custom-addons --line-length=120

# Organizar imports
python -m isort custom-addons --profile=black --line-length=120

# Análisis de código
python -m pylint custom-addons --rcfile=.pylintrc

# Errores de estilo
python -m flake8 custom-addons --max-line-length=120

# Tests
pytest custom-addons
```

---

## ✅ Checklist: Antes de Ejecutar

- [ ] Abri archivo Python en VS Code
- [ ] Pylance NO muestra líneas rojas (errores)
- [ ] Ejecuté: `python -m black custom-addons --line-length=120`
- [ ] Ejecuté: `.\develop.bat logs`

---

## 💡 Resumen

```
ANTES: python -m mypy custom-addons  (Con errores de compilación)
AHORA: Pylance en VS Code             (Automático, sin instalaciones)

Resultado: ¡Más simple y más rápido! 🚀
```

---

## 🎯 Type Hints (Sigue siendo importante)

Sigue usando type hints para que Pylance valide correctamente:

```python
from typing import List, Optional

def procesar(datos: List[str]) -> int:
    """Procesa datos y retorna cantidad"""
    return len(datos)

def obtener_opcional(id: int) -> Optional[str]:
    """Retorna string opcional"""
    return None
```

Pylance validará estos tipos automáticamente ✨

---

**¡Ahora tienes validación estática SIN complicaciones de compilación!** 🎉
