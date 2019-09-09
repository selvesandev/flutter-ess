# flutteress
A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# FLUTTER ESSENTIALS

Framework for Dart build with a pre build set of widget which can be used in your app build with native features.

* Write Code with One Language
* Customise for different platform.
* Build & Publish with build tools.


`brew info dart` get the dart SDK location.


## Core Architecture

* **Flutter Works with Widget**
A app build with flutter is structured in a tree of widget.

* **Compiled to Native Code**
The dart code gets compiled to native code by the flutter SDK.

## Flutter Installation (MAC)

* flutter.io and **install on mac** button >> https://flutter.dev/docs/get-started/install/macos

* Follow the installation process.

* Check if the installation was successful by `flutter doctor` in the terminal.

* Open simulator with `open -a Simulator`

* Create a flutter project with `flutter create project_name`

* `cd project_name` && `flutter run`


## Project Environment In VS Code.

* Open Flutter Project folder in VSC.

* **Adding Some Extension to make the development pleasant.**
`>> View >> Extensions` search flutter and install which will also install the dart.

## Flutter & Material Design.
Flutter imbraces material design but it is completely costomizable.


## Coding the project from scratch.
* lib/main.dart file is the entry point for the app and you should not rename it.
* Android and IOS Folder will hold the native source code used by the build process.
* LIB folder is where we write our entire flutter app.
* Test is for automated test script folder.
* pubspec.yaml is track for all the project dependencies it's where we will add third party library.


## main.dart
* lib/main.dart file is the entry point for the app and you should not rename it. 
* One specific function will be executed here named `main()` flutter will call this function automatically where the app will start.
* To render something in the display you attact a widget to the `main()` function.

```


```

## Widgets.
* Tool or Block by which you build a User Interface. A mobile app contains multiple widgets.
* You can think of your flutter app as a tree of a widget.
* Widget is a object of a class. To be a widget a class needs certain features. Therefore the class has to extend something.
* To use the flutter functionality `import 'package:flutter/material.dart'` at top of the file.
```
    import 'package:flutter/material.dart';

    main(){

    }

    class MyApp extends StatelessWidget{
        build(){

        }
    }
```


* The build method takes one argument the `context` will contain few informations.
* The build method returns something that has to be drawn on the screen.
* The build method always returns another widget in the build method until you reach the widget that ships with flutter.
```
    build(context) {
        return MaterialApp();
    }
```

* the `MaterialApp` is a special core widget which is used to wrap your entire app also responsible for adding theme, navigation etc.
* Now it can be used to draw something to the screen.


* Scaffold create a nice white background container or page to your app where you provide data to show in the page.
```
class MyApp extends StatelessWidget {
  build(context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('First Flutter ECommerce'),),
      ),
    );
  }
}

```

## DART
Better Syntax in our code with Dart's syntax. Dart is a typed language therefor we can add types to variable function return types etc. Using types is strongly recommeded and helps to write better code.

```
//returns nothing.
void main() {
  runApp(MyApp());
}

//short cut arrow notation. Only valid if you have one statement
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  
  Widget build(BuildContext context) {

  }
}

```