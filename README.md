# Nojoch (Herencia Viva)

iOS app connecting rural Mexican communities to the world by promoting their cultural and natural heritage through AR experiences, interactive maps, and ML-powered indigenous language translation.

## Features

- **AR Heritage Viewer** — View 3D cultural artifacts (USDZ models) in augmented reality with RealityKit
- **Interactive Map** — Explore patrimonios, comunidades, and estados on a MapKit-based map with location awareness
- **Indigenous Language Translation** — CoreML text classifiers for Nahuatl and Maya language identification
- **Heritage Collection** — Track visited patrimonios, favorites, and earned insignias (gamification)
- **Onboarding** — Guided introduction to the app's cultural mission

## Tech Stack

| Layer | Technology |
|-------|-----------|
| UI | SwiftUI |
| Persistence | SwiftData |
| Maps | MapKit |
| AR | RealityKit, SceneKit |
| ML | CoreML (NahualtClass, MayaClass text classifiers) |
| 3D Assets | USDZ (Reality Composer Pro package) |
| Navigation | Hand-rolled Router.swift |
| Location | CoreLocation |

## Project Structure

```
Nojoch/
├── NojochApp.swift              # App entry point, SwiftData container setup
├── ContentView.swift            # TabView (Inicio, Explora, Herencia) + onboarding gate
├── Views/
│   ├── ARView/                  # CustomARView, ARManager, ARViewModel, ARInsigniasView
│   ├── MainView/                # Home screen
│   ├── ExploreView/             # Map-based exploration
│   ├── MiHerenciaView/          # User's heritage collection & stats
│   ├── PatrimonioView/          # Individual patrimonio detail
│   ├── EstadoView/              # State-level view
│   ├── ComunidadView/           # Community-level view
│   └── OnBoardingView/          # First-launch onboarding
├── Components/                  # Reusable UI (cards, DonutChart, HeaderAppView, LocationManager)
├── Helpers/                     # SwiftDataModels, Router, Extensions
├── Text Classifier/             # CoreML model wrappers (Nahuatl, Maya)
├── Resources/                   # USDZ 3D models (aztec, skull, vase, tree, etc.)
├── Fonts/                       # Poppins, Raleway
└── Assets.xcassets/             # Images (Patrimonios, Comunidades, Estados, icons)
Alebrije/                        # Reality Composer Pro package (AR assets)
NahualtClass.mlproj/            # Create ML project for Nahuatl classifier
PatrimonioTags.mlproj/          # Create ML project for patrimonio tagging
```

## Data Models

- **Patrimonio** — Heritage site (tags, persona, estado, comunidad, coordinates, fotos, idioma, favorited/visited status, insignia)
- **Estado** — Mexican state (nombre, icono, fotos, ubicacion)
- **Comunidad** — Rural community (nombre, fotos, estado, coordenadas)

## Prerequisites

- Xcode 16+
- iOS 17+ device (AR features require a physical device with LiDAR or A12+ chip)
- macOS Sonoma or later

## Run

1. Clone the repository
2. Open `Nojoch.xcodeproj` in Xcode
3. Select a physical iOS device as the run destination (AR does not work in Simulator)
4. Build and run (⌘R)

## Team

| Name | GitHub |
|------|--------|
| Tlanetzi Chavez | |
| Axel Hernández | [@Axel3246](https://github.com/Axel3246) |
| Fausto Pinto Cabrera | [@Fausto1712](https://github.com/Fausto1712) |
| Alejandra Coeto | [@Ale-Coeto](https://github.com/Ale-Coeto) |

## License

This project is not currently licensed for redistribution.
