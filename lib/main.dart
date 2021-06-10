import 'package:flutter/material.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import './models/meal.dart';
import './dummy_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<String,bool> _filters ={
    'gluten':false,
    'lactose':false,
    'vegan':false,
    'vegetarian':false,
  };

  List <Meal> _availableMeals =DUMMY_MEALS;
  List <Meal> _favouriteMeals = [];

    void _setFilters(Map<String,bool> filterData){
    setState(() {
      _filters= filterData;

      _availableMeals = DUMMY_MEALS.where((meal){
        if(_filters['gluten'] && !meal.isGlutenFree){
          //dont want to include it
          return false;
        }
        if(_filters['lactose'] && !meal.isLactoseFree){
          //dont want to include it
          return false;
        }
        if(_filters['vegan'] && !meal.isVegan){
          //dont want to include it
          return false;
        }
        if(_filters['vegetarian'] && !meal.isVegetarian){
          //dont want to include it
          return false;
        }
        return true;
      }).toList();
    });
  }

    void _toggleFavourite(String mealId){
    //indexWhere checks whether a certain element is part of that list and then automatically gives us the index of that meal if it is part, if not part, index will be -1.
    final existingIndex=_favouriteMeals.indexWhere((meal)=>meal.id == mealId);

    if (existingIndex >= 0){
      //remove the meal (bc it's a toggle method)
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    }else{
      //if didnt find the element -> add to list
      setState(() {
        _favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavourite(String id){
    return _favouriteMeals.any((meal)=> meal.id == id);
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                //normal text
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                //emphasized text
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/', //default is '/' so u dont really need to set this
      //routes table
      //the '/' is just a convention taken from web dev, u can have any path name here
      routes: {
        '/': (ctx) => TabsScreen(_favouriteMeals),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavourite,_isMealFavourite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters,_setFilters),
      },
    );
  }
}
