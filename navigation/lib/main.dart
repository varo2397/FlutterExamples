import 'package:flutter/material.dart';

import './dummy-data.dart';
import './models/meal.dart';
import './screens/filters.dart';
import './screens/tabs.dart';
import './screens/categories.dart';
import './screens/category_meals.dart';
import './screens/meal_detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false
  };

  List<Meal> availableMeals = DUMMY_MEALS;

  void setFilter(Map<String, bool> filteredData) {
    setState(() {
      filters = filteredData;

      availableMeals = DUMMY_MEALS.where((meal) {
        if(filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if(filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if(filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        if(filters['vegan'] && !meal.isVegan) {
          return false;
        }
        return true; 
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            body2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            title: TextStyle(
                fontSize: 20.0,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold)),
      ),
      initialRoute: '/', // this is the default one
      routes: {
        '/': (context) => Tabs(),
        CategoryMeals.routeName: (context) => CategoryMeals(availableMeals),
        MealDetail.routeName: (context) => MealDetail(),
        Filters.routeName: (context) => Filters(setFilter),
      },
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   return MaterialPageRoute(builder: (context) => Categories());
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => Categories());
      },
    );
  }
}
