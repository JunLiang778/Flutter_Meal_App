import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);
  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;

  //we wanna retrieve  the displayedMeals not in the build() method but earlier -> initState
  //the probelem is that the Context obj is not liked in the initState()
  //this doesnt work there(initState) bc context generally is a property that's globally available in our State object BUT not inside of initState because INITSTATE RUNS TOO EARLY
  //initState RUNS BEFORE our widget is created/fully created and BEFORE WE HAVE A CONTEXT FOR OUR WIDGET
  //so this point of time, I cant retrive my ROUTE DATA 
  //another LC hook -> didChangeDependencies
  //trigger whenever the references of the state change, which also means it will be called when the widget that belongs to the state has been fully initialized and we can tap into context
  //runs before build runs
  //initState wouldve been great if we wouldnt have required to use modal route of context

  @override
    void didChangeDependencies() {
      final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    displayedMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
      // TODO: implement didChangeDependencies
      super.didChangeDependencies();
    }

  void _removeMeal(String mealId) {
    setState(() {
          displayedMeals.removeWhere((meal)=>meal.id==mealId);
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayedMeals[index].id,
              title: displayedMeals[index].title,
              imageUrl: displayedMeals[index].imageUrl,
              duration: displayedMeals[index].duration,
              affordability: displayedMeals[index].affordability,
              complexity: displayedMeals[index].complexity,
            );
          },
          itemCount: displayedMeals.length,
        ));
  }
}
