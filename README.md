# FavoriteAthletes

Aplicación iOS sencilla con patrón MVC para mantener una lista de atletas favoritos.

## Características
- Ver lista de atletas favoritos
- Agregar nuevos atletas (nombre, edad, liga, equipo)
- Editar atletas existentes
- Eliminar atletas deslizando

## Arquitectura MVC
- **Model:** `Athlete.swift`
- **View:** Storyboards + celdas UITableView
- **Controller:** `AthleteTableViewController` (lista) y `AthleteDetailTableViewController` (agregar/editar)

## Requisitos
- Xcode 15+
- iOS 17+
