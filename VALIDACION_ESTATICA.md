# 🔍 Validación Estática de Código (Type Checking)

Para un desarrollador .NET, Python tradicionalmente se siente sin seguridad porque no compila. Aquí te mostramos cómo tener **validación estática como en C#**.

## 📊 Comparación .NET vs Odoo/Python

```
┌─────────────────────────────────────────────────────────────┐
│                      .NET                                   │
├─────────────────────────────────────────────────────────────┤
│  1. Escribes código (C#)                                    │
│  2. Compilas (dotnet build) ← Detecta errores AQUÍ         │
│  3. Ejecutas                                                │
│  4. Si compila, casi seguro que funciona                   │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                   Python (Tradicional)                      │
├─────────────────────────────────────────────────────────────┤
│  1. Escribes código (Python)                               │
│  2. Ejecutas directamente ← Errores explotan en runtime    │
│  3. Esperas a encontrar errores en ejecución              │
│  ❌ Débil                                                   │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│              Python (Con Herramientas Modernas)             │
├─────────────────────────────────────────────────────────────┤
│  1. Escribes código (Python + Type Hints)                 │
│  2. python-check check (mypy + pylint) ← Detecta AQUÍ     │
│  3. Ejecutas                                               │
│  4. Si pasa validación, es seguro                         │
│  ✅ Mucho más seguro                                       │
└─────────────────────────────────────────────────────────────┘
```

## 🛠️ Las 4 Herramientas Principales

### 1. **Pylance** (Extension VS Code)
**Lo que hace**: Type checking en tiempo real mientras escribes
**Equivalente .NET**: Intellisense + Roslyn Analyzer

```python
# ❌ Pylance detecta AQUÍ (línea roja)
usuario: str = 123  # Error: esperaba str, obtuve int

# ✅ Pylance detecta AQUÍ
mensaje = usuario.upper()  # ¡Correcto!
```

**Instalación**:
1. Ve a Extensions en VS Code
2. Busca "Pylance"
3. Instala (oficial de Microsoft)
4. Settings.json ya está configurado ✅

---

### 2. **mypy** (Type Checker)
**Lo que hace**: Valida tipos estáticamente (como compilador)
**Equivalente .NET**: Compilación en `dotnet build`

```python
# Archivo: models/usuario_model.py

from odoo import models, fields

class Usuario(models.Model):
    _name = 'mi.usuario'
    
    # Sin type hints (sin validación)
    def saludar(self, nombre):
        return f"Hola {nombre}"
    
    # Con type hints (con validación)
    def saludar_tipado(self, nombre: str) -> str:
        return f"Hola {nombre}"
```

**Ejecutar mypy**:
```powershell
python-check check
```

**Salida esperada**:
```
custom-addons/sofia_hola_mundo/models/hola_mundo_model.py: note: No errors found!
Success: no issues found in 1 source file
```

---

### 3. **Pylint** (Linter)
**Lo que hace**: Detecta errores lógicos, malas prácticas, naming
**Equivalente .NET**: StyleCop + FxCop

```python
# ❌ Pylint detecta esto:
def mi_funcion():  # Error: snake_case, no camelCase
    x = 1  # Error: variable sin usar
    y = 2  # Error: nombre muy corto
    return y

# ✅ Pylint acepta esto:
def mi_funcion() -> int:
    resultado = 1 + 2
    return resultado
```

**Ejecutar pylint**:
```powershell
python-check check
```

---

### 4. **Black** (Formatter)
**Lo que hace**: Formatea automáticamente (como Roslyn Formatter)
**Equivalente .NET**: `dotnet format`

```python
# ❌ Código sin formato
def func(a,b,c):return a+b+c

# ✅ Black lo convierte a:
def func(a, b, c):
    return a + b + c
```

**Ejecutar Black**:
```powershell
python-check fix
```

---

## 🚀 Guía Rápida: Venir de .NET

### En .NET haces:
```bash
dotnet build      # Compila y valida
dotnet test       # Ejecuta tests
dotnet format     # Formatea código
```

### En Odoo ahora haces:
```powershell
python-check check      # Compila y valida (como dotnet build)
python-check test       # Ejecuta tests
python-check fix        # Formatea código (como dotnet format)
.\develop.bat logs      # Ver logs (como Debug)
```

---

## 📋 Flujo de Trabajo Recomendado

### 1️⃣ Escribir Código con Type Hints

```python
from odoo import models, fields, api
from typing import List, Optional

class Producto(models.Model):
    _name = 'sofia.producto'
    _description = 'Producto'
    
    nombre: str = fields.Char(string='Nombre', required=True)
    precio: float = fields.Float(string='Precio', required=True)
    stock: int = fields.Integer(string='Stock', default=0)
    
    def obtener_disponibles(self) -> int:
        """Retorna el stock disponible"""
        return self.stock
    
    def buscar_por_nombre(self, nombre: str) -> Optional['Producto']:
        """Busca producto por nombre"""
        resultado = self.search([('nombre', 'ilike', nombre)], limit=1)
        return resultado[0] if resultado else None
    
    def aplicar_descuento(self, descuento: float) -> float:
        """Aplica descuento al precio"""
        if descuento < 0 or descuento > 100:
            raise ValueError("Descuento debe estar entre 0 y 100")
        return self.precio * (1 - descuento / 100)
```

### 2️⃣ Validar Código (como `dotnet build`)

```powershell
python-check check
```

**Resultado**:
```
✅ Black: Código formateado correctamente
✅ mypy: No errors found!
✅ Pylint: Your code has been rated at 9.50/10
✅ Flake8: No issues detected
```

### 3️⃣ Corregir Automáticamente

```powershell
python-check fix
```

### 4️⃣ Ejecutar Tests

```powershell
python-check test
```

---

## 💡 Type Hints Comunes en Odoo

```python
from typing import List, Optional, Dict, Tuple, Any
from odoo import models, fields, api

class Ejemplo(models.Model):
    _name = 'mi.ejemplo'
    
    # Fields
    nombre: str = fields.Char()
    cantidad: int = fields.Integer()
    
    # Type hints en métodos
    def obtener_datos(self) -> Dict[str, Any]:
        return {'nombre': self.nombre}
    
    def buscar(self, condiciones: List[tuple]) -> List['Ejemplo']:
        return self.search(condiciones)
    
    def opcional(self) -> Optional[str]:
        return self.nombre if self.nombre else None
    
    @api.constrains('cantidad')
    def validar(self) -> None:
        if self.cantidad < 0:
            raise ValueError("La cantidad no puede ser negativa")
```

---

## 🔧 Pre-commit Hooks (Automático)

Los hooks se ejecutan **antes de hacer commit** (como pre-build):

```powershell
# Instalación única
pip install pre-commit
pre-commit install

# Ahora, cada vez que hagas:
git commit -m "Mi cambio"

# Se ejecuta automáticamente:
# - Black (formato)
# - isort (imports)
# - mypy (tipos)
# - flake8 (errores)
```

---

## 📚 Extensiones VS Code Recomendadas

| Extensión | Función |
|---|---|
| **Pylance** | Type checking en tiempo real |
| **Python** | Soporte base de Python |
| **Black Formatter** | Formato automático |
| **ruff** | Linter rápido |
| **GitLens** | Git integration |

Todas están en `.vscode/extensions.json` ✅

---

## ❓ FAQ: .NET → Python

**P: ¿Dónde están los errores de compilación?**
R: En `python-check check` (mypy detecta errores de tipo antes de ejecutar)

**P: ¿Cómo sé si el código está bien sin ejecutar?**
R: `python-check check` valida todo sin ejecutar (como `dotnet build`)

**P: ¿Es Python tan seguro como C#?**
R: Con type hints + herramientas = casi igual de seguro

**P: ¿Qué pasa si olvido los type hints?**
R: El código funciona, pero no tienes validación estática. Usa Pylance para que te avise.

---

## 🎯 Resumen

```
┌────────────────────────────────────────────────────────────┐
│  Herramienta   │  .NET Equivalente     │  Comando         │
├────────────────────────────────────────────────────────────┤
│  Pylance       │  Intellisense         │  Automático      │
│  mypy          │  dotnet build         │  python-check    │
│  pylint        │  StyleCop             │  python-check    │
│  Black         │  dotnet format        │  python-check    │
│  pytest        │  dotnet test          │  python-check    │
└────────────────────────────────────────────────────────────┘
```

¡Ya tienes **validación estática** como en .NET! 🎉
