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
* Flutter is both and SDK which build the app as well as a Dart Framework that offers a rich set of classes and widget.
* Dart is statically typed object oriented programming.

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


#### Flutter is all about Widget
* You compose the user interface from a set of build in or custom widget.
* Stateless widget takes only data as input and render a new widget tree.
* Statefull widget works with both external data and internal data which can change (so called state).
* Changes to the external or internal data lead to a re-render cycle.




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

## Card & Images
register your images in pubspec.yaml
```
  assets:
   - assets/barbell.jpg
```

## Flutter Widgets Docs
`flutter.dv >> Docs >> Widget Catalog`


## Stateless Widget
* A stateless widget is a very simple widget only able to except external data and build the UI or Widget tree.
* Should be overriden by a build method.
* It can't work with internal data, it can't change such internal data and it can't recall build method if some data changes.
* The build method is only called when it created for  first time or some external data which it receive changes.
```
  Widget build(BuildContext context) {
  }
```

## Statefull Widget
* A statefull widget can contain a state/data which you can change it's state. 
* Should be overriden by a createState method which return a State class.
```
  class MyHomePage extends StatefulWidget {
    _MyHomePageState createState() => _MyHomePageState();
  }

  class _MyHomePageState extends State<MyHomePage> {
    //this class will have the state/data
    List<String> _products = ['Barbell'];

  }
```
* Here the `MyHomePage statefullWidget` belongs to the `_MyHomePageState State Class`.

* The state class contains a build method and a state here `_products` in our state class.


## Modularizing your widgets in different files.

* create a file `products` small case or `products_name` in lib folder which will contain a stateless class which will receive a state.

```
  class Products extends StatelessWidget {
    final List<String> products;
    Products(this.products); 

    @override
    Widget build(BuildContext context) {
      return Column(
        children: products
            .map((element) => Card(
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/barbell.jpg'),
                      Text(element)
                    ],
                  ),
                ))
            .toList(),
      );
    }
  }
```

* Here the `Products` class receives a `products` state in the constructor which will be used by the build method.

## Life Cycle Hooks
### Stateless
> Input Data > Widget > Renders UI

* A stateless widget have a constructor method
* Then it has the build function, can be called multiple times when the state changes.
* That's only in the lifecycle hook of stateless.


### Stateful
> Input Data > Widget > Renders UI
* Constructor function
* `initState()` function is called then 
* `build()` function is called.

* `setState()` can be called.

* You can have some changes to your external data which calls the `didUpdateWidget` which will eventually call the `build()` method again.



## Material Theme.
```
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.dark, primarySwatch: Colors.deepOrange),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Ecommerce'),
        ),
        body: ProductManager('Barbell'),
      ),
    );

```


## Passing Data Up.
If you want to pass data up, you have something hapening in a widget and if the parents widget needs to know about it, then you do that by passing a reference to a function which is executed by the parent widget.
```
  void _addProduct(String product) {
    setState(() {
      _products.add(product);
    });
  }

  //pass the setState function to the widget
  Products(_products)

  //accept the _product in constructor and call it.
  ProductControl(this.addProduct);  
  
```

## Const & Final
`final` means a property is final can't assign a new value but we the object in the memory can be updated by can't create a new one with equal sign. List and object are reference type and we use method on that reference is OK which changes the existing element but does not create a  new one. 

```
  final List<String> _products = [];
  //valid
  _products.add('Hello');

  //invalid
  _products=['hello']
```

`const` If we want to insure we do not want to change even the ref. So if you want to make sure a value can never be changed use `const` in the right side of the equal sign.

```
  final List<String> _products = const [];
```


## Debuggin a Flutter Error
Different kind of errors and way to find and fix these errors.

#### Syntax Error.
* In Vs Code hover over the red mark in the syntax error to get the message.

#### Run Time Errors
* Run time error is display on the projects running console.

#### Logical Errors.

`break points` to Pause our code excution and move step by step to debug the app. For this you need to stop the process and start it with debugging enabled `Debug > Start Debugging`. Click on the left side of the editor to mark a stop point / line for the execution to pause. And you can use the control panel provided by VS code to control the execution.


## DebugPaintSize
```
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = true;ss
  debugPaintBaselinesEnabled = true;
  debugPaintPointersEnabled = true; 

 runApp(MyApp()); 
}
```

To Get The GRID.
```
return MaterialApp(
      debugShowMaterialGrid: true,
)

```

## List View.
List view as the name suggest is the view to render list which has a children argument. 
```
ListView(
      children: products
          .map((element) => Card(
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/barbell.jpg'),
                    Text(element)
                  ],
                ),
              ))
          .toList(),
    );
```
**NOTE** If you want to have a list view below a `container` or a `Expanded` widger then you must include the list view inside the container widget.
```
return Column(children: <Widget>[
      Container(margin: EdgeInsets.all(10.0), child: ProductControl(_addProduct)),
      Container(height:300.00,child: Products(_products))
    ]);
```

```
Expanded(child: Products(_products))
```

#### Optimizing the List View (with builder).
```
  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset('assets/barbell.jpg'),
          Text(products[index])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildProductItem,
      itemCount: products.length,
    );
  }

```
Here we are using the `ListView.builder` method to display the list items. `itemBuilder` calls the `_buildProductItem` function to display the card each time. `itemCount` is the total item count.

**NOTE** The build method should not return `null` value it should atleast return a empty `Container()` widget.

## Navigation.
For the Navigation to work you should wrap your pages with `MaterialApp`
```
Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowMaterialGrid: true,
      theme: ThemeData(
          brightness: Brightness.light, primarySwatch: Colors.deepOrange),
      home: AuthPage()
    );
  }
```
#### Names Route
```
return MaterialApp(
      // debugShowMaterialGrid: true,
      theme: ThemeData(
          brightness: Brightness.light, primarySwatch: Colors.deepOrange),
      // home: AuthPage(),
      routes: {
        '/admin':(BuildContext context) => ProductAdmin(),
        '/':(BuildContext context) => ProductsPage()
      },
    );
```
**NOTE** `/` is a special route reserved for the home page hence the `/` name will only work if you don't have the `home` specified.

```
onTap: () {
  Navigator.pushReplacementNamed(context, '/' );
})
```

#### onGenerateRoute.
When the defined routes are not found then the `onGenerateRoute` function executed where you can handle your route.
```
onGenerateRoute: (RouteSettings setting) {
        final List<String> pathElement = setting.name.split('/');
        print(pathElement);
        if (pathElement[0] != '') {
          return null;
        }

        if (pathElement[1] == 'product') {
          final int index = int.parse(pathElement[2]);

          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => ProductPage(
                _products[index]['title'], _products[index]['image']),
          );
        }
        return null;s
      },
```

### onUnknownRoute
When the route is not found in route definition or when the route is not handled in `onGenerateRoute` i.e it returning null, then the `onUnknownRoute is rendered`
```

```


#### Summary

* Navigation works with stack of pages, the top most is visible.
* You push pages into the stack and pop them off.
* The navigator does not directly push the page widget but instead uses routes (eg: `MaterialPageRoute`)
* You can pass data to pages via page widget constructor.
* You can return data by passing it to `pop()` and handling it in `then` method of the `Future` object

* Besides direclty pushing pages, you can also use a global route registry and named routes.
* Passing data is still possible.
* `onGenerateRoute` can be used to implement custom route parsing and handling logic.
* `onUnknownRoute` can be used to display the 404 routes.
* `Dialog` and `Modals` are also managed via the navigator.
* `Navigator.pop()` closes the overlay, a second call closes the page.