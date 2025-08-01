# Momentum - Productivity App

Una aplicación de productividad construida con SwiftUI utilizando arquitectura MVVM.

## 📱 Descripción

Momentum es una aplicación de productividad diseñada para ayudar a los usuarios a gestionar sus tareas diarias, sesiones de enfoque y estadísticas de productividad. La aplicación utiliza patrones de diseño modernos y buenas prácticas de desarrollo iOS.

## 🏗️ Arquitectura

La aplicación sigue el patrón **MVVM (Model-View-ViewModel)** con inyección de dependencias:

- **Model**: Modelos de datos (`MomentumTask`, `FocusSession`)
- **View**: Vistas SwiftUI (`TodayDashboardView`)
- **ViewModel**: Lógica de negocio y estado (`TodayDashboardViewModel`)
- **Services**: Capa de servicios para persistencia y red

## 📂 Estructura del Proyecto

## Estructura del Proyecto

```
Momentum/
├── Momentum/
│   ├── App/
│   │   └── MomentumApp.swift
│   ├── Core/
│   │   ├── Models/
│   │   └── Services/
│   ├── Features/
│   │   └── TodayDashboard/
│   └── Shared/
│       └── Extensions/
├── MomentumTests/
├── MomentumUITests/
├── MomentumApp.swift
├── ContentView.swift
├── Item.swift
└── Momentum.xcodeproj
```

## 🎯 Funcionalidades Implementadas

### ✅ Dashboard de Hoy (TodayDashboard)
- **Gestión de Tareas**: Crear, completar y eliminar tareas
- **Estadísticas Diarias**: Contador de tareas completadas
- **Sesiones de Enfoque**: Seguimiento del tiempo de enfoque diario
- **Interfaz Intuitiva**: Diseño limpio con SwiftUI

### ✅ Arquitectura Sólida
- **MVVM Pattern**: Separación clara de responsabilidades
- **Inyección de Dependencias**: Servicios intercambiables
- **Persistencia Local**: Almacenamiento con UserDefaults
- **Manejo de Errores**: Sistema robusto de gestión de errores
- **Async/Await**: Operaciones asíncronas modernas

### ✅ Sistema de Diseño
- **Paleta de Colores**: Colores personalizados con soporte para modo oscuro
- **Componentes Reutilizables**: `StatCard`, `TaskRow`
- **Tipografía Consistente**: Sistema de fuentes escalable

## 🔧 Tecnologías Utilizadas

- **SwiftUI**: Framework de interfaz de usuario
- **Swift 5**: Lenguaje de programación
- **Async/Await**: Concurrencia moderna
- **UserDefaults**: Persistencia local
- **Combine**: Programación reactiva (@Published)

## 📋 Modelos de Datos

### MomentumTask
```swift
struct MomentumTask: Codable, Identifiable {
    let id: UUID
    var title: String
    var notes: String?
    let creationDate: Date
    var dueDate: Date?
    var isCompleted: Bool
    var isPriority: Bool
    var estimatedTimeInMinutes: Int?
}
```

### FocusSession
```swift
struct FocusSession: Codable, Identifiable {
    let id: UUID
    let date: Date
    let durationInMinutes: Int
    let taskId: UUID?
}
```

## 🎨 Sistema de Colores

- **momentumBoneBackground**: Color de fondo principal
- **momentumAccentBlue**: Color azul de acento para elementos interactivos
- **momentumAccentOrange**: Color naranja de acento para elementos de prioridad

## 🔄 Servicios

### PersistenceService
- **Protocolo**: `PersistenceServiceProtocol`
- **Implementación**: `LocalPersistenceService`
- **Almacenamiento**: UserDefaults con codificación JSON
- **Operaciones**: CRUD completo para tareas y sesiones de enfoque

### NetworkService (Futuro)
- **Protocolo**: `NetworkServiceProtocol`
- **Implementación**: `APIService`
- **Preparado para**: Sincronización con backend

## 🚀 Instalación y Ejecución

1. **Clonar el repositorio**
2. **Abrir** `Momentum.xcodeproj` en Xcode
3. **Seleccionar** un simulador iOS
4. **Ejecutar** el proyecto (⌘+R)

### Requisitos
- Xcode 15.0+
- iOS 18.5+
- macOS Sonoma+

## 📱 Funcionalidades de la App

### Dashboard Principal
- Vista de tareas del día actual
- Estadísticas de productividad
- Botón para agregar nuevas tareas
- Iniciador de sesiones de enfoque

### Gestión de Tareas
- Crear tareas con título y notas
- Marcar como completadas
- Eliminar tareas con deslizar
- Indicador de prioridad

### Sesiones de Enfoque
- Timer Pomodoro (25 minutos)
- Seguimiento de tiempo total diario
- Asociación con tareas específicas

## 🔮 Próximas Funcionalidades

### 1. Planner (Planificador)
- **Vista Semanal/Mensual**: Calendario interactivo
- **Programación de Tareas**: Asignación de fechas y horarios
- **Vista de Agenda**: Lista cronológica de actividades

### 2. FocusMode (Modo Enfoque)
- **Timer Personalizable**: Sesiones de 15, 25, 45, 60 minutos
- **Bloqueo de Distracciones**: Notificaciones silenciadas
- **Música de Enfoque**: Sonidos ambientales
- **Estadísticas de Enfoque**: Gráficos de productividad

### 3. Stats (Estadísticas)
- **Gráficos de Productividad**: Visualización de datos
- **Tendencias Semanales**: Análisis de patrones
- **Objetivos y Metas**: Sistema de logros
- **Exportar Datos**: CSV, PDF reports

### 4. Características Avanzadas
- **Sincronización en la Nube**: iCloud/Backend API
- **Categorías de Tareas**: Organización por proyectos
- **Recordatorios**: Notificaciones push
- **Widgets**: Información en pantalla de inicio
- **Apple Watch**: Extensión para watchOS

## 🧪 Testing

- **Unit Tests**: Pruebas de ViewModels y Services
- **UI Tests**: Pruebas de interfaz automatizadas
- **Coverage**: Objetivo del 80%+

## 📚 Documentación Técnica

### Patrones de Diseño
- **MVVM**: Model-View-ViewModel
- **Repository Pattern**: Capa de abstracción de datos
- **Dependency Injection**: Inversión de dependencias
- **Protocol-Oriented Programming**: Interfaces bien definidas

### Buenas Prácticas
- **Single Responsibility**: Una responsabilidad por clase
- **SOLID Principles**: Principios de diseño sólido
- **Clean Code**: Código limpio y legible
- **Error Handling**: Manejo robusto de errores

## 🤝 Contribución

1. Fork del proyecto
2. Crear feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a branch (`git push origin feature/AmazingFeature`)
5. Abrir Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE.md](LICENSE.md) para detalles.

## 👨‍💻 Autor

**Josh Tienda** - Desarrollo iOS

---

*Momentum - Transforma tu productividad, un día a la vez* 🚀
