# Guía de Contribución y Organización

Este documento describe cómo agregar y organizar el contenido en este repositorio.

## 📝 Convenciones de Nombres

### Prácticas
```
Practicas/Practica[XX]-[NombreDescriptivo]/
```
Ejemplo: `Practicas/Practica01-HolaMundo/`

### Proyectos
```
Proyectos/Proyecto[XX]-[NombreDelProyecto]/
```
Ejemplo: `Proyectos/Proyecto01-AppTareas/`

### Tareas
```
Tareas/Tarea[XX]-[DescripcionBreve]/
```
Ejemplo: `Tareas/Tarea01-CalculadoraSimple/`

## 📁 Estructura de Carpetas

Cada práctica, proyecto o tarea debe seguir esta estructura:

```
NombreCarpeta/
├── README.md                    # Documentación
├── [NombreProyecto].xcodeproj  # Proyecto Xcode
├── [NombreProyecto]/           # Código fuente
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   ├── ViewController.swift
│   └── ...
├── Screenshots/                 # Capturas de pantalla (opcional)
│   ├── screenshot1.png
│   └── screenshot2.png
└── Assets/                      # Recursos adicionales (opcional)
```

## 📄 Plantilla README.md

Cada carpeta debe incluir un README.md con la siguiente información:

```markdown
# [Nombre del Proyecto/Práctica/Tarea]

## Descripción
[Breve descripción de qué hace la aplicación o qué problema resuelve]

## Objetivos
- Objetivo 1
- Objetivo 2
- Objetivo 3

## Características
- Característica 1
- Característica 2

## Tecnologías Utilizadas
- Swift (especificar versión, ej: 5.7)
- UIKit / SwiftUI
- [Otras frameworks o librerías si aplica]

## Capturas de Pantalla
[Si aplica, incluir imágenes]

## Instrucciones de Ejecución
1. Abrir el archivo `.xcodeproj` en Xcode
2. Seleccionar el simulador deseado
3. Presionar `Cmd + R` para ejecutar

## Requisitos
- Xcode (especificar versión, ej: 14.0)
- iOS (especificar versión mínima, ej: 15.0)

## Notas Adicionales
[Cualquier información adicional relevante]
```

## 🔄 Workflow de Trabajo

1. **Crear nueva carpeta** para cada práctica/proyecto/tarea
2. **Agregar el proyecto Xcode** completo
3. **Crear README.md** con la documentación
4. **Agregar capturas de pantalla** si es necesario
5. **Commit y push** al repositorio

## ✅ Checklist Antes de Commit

- [ ] El proyecto compila sin errores
- [ ] README.md está completo
- [ ] Capturas de pantalla incluidas (si aplica)
- [ ] .gitignore está configurado correctamente
- [ ] No se incluyen archivos generados (DerivedData, build/, etc.)

## 🚫 Qué NO incluir

- Archivos de configuración personal de Xcode (`xcuserdata/`)
- Carpetas de build (`build/`, `DerivedData/`)
- Archivos temporales de macOS (`.DS_Store`)
- Pods o dependencias que se puedan generar automáticamente

## 📞 Contacto

Para dudas o sugerencias sobre la organización del repositorio, contactar al autor.
