# MySnemovna

## Description

This application was created as diploma thesis on the FIT CTU (FIT ČVUT).
This application is front-end mobile application written in Flutter, that has back-end data provider service:
```
https://github.com/demchiva/MySnemovna.git
```

The application consumes api endpoints with data of "Poslanecká sněmovna" (PSP) and show it results to user.
The source data used for this app can be found on the official PSP web:
```
https://www.psp.cz/sqw/hp.sqw?k=1300
```

The application in current version shows next PSP agendas:

- Meetings. PSP meetings on which parliament members votes for some points.
- Votes. Votes of parliament members and point (Default screen).
- Members. PSP member which can vote (search allowed).

For information about another agendas see official web (link above).

## Project requirements

Project requirements:

- Flutter 3.7.10 or higher for project build and run
- Dart 2.19.6 or higher for project build and run
- Cocoapods 1.12.0 or higher (for MacOs only) for project build and run
- Android Studio or Visual Code for project open

## Steps to run project

Clone this repository using:
```
git clone https://github.com/demchiva/MySnemovnaFrontend.git
```

Open project in Android Studio:
```
Open Android Studio -> File -> Open -> Find project and click Open
```

Enable Dart SDK for project.

Download the project dependencies.
```
flutter pub get 
```

Create Android Simulator Device and open or Open iPhone Simulator (only on MacOS).

Now you can run the project locally. 
Run green triangle and application should be started and opened in simulator.
Also application can be run using next command:
```
flutter run
```

## Copyright

This program can be distributed under GNU General Public License.

If you use this code please cite:

```
Bc. I. Demchenko, "Aplikace pro zobrazení výsledků hlasování Poslanecké
sněmovny", MySnemovna 2023
```