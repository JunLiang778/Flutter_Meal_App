import 'package:flutter/material.dart';
import '../screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem(this.id, this.title, this.color);

  void selectCategory(BuildContext ctx) {
    // Navigator.of(ctx).push(
    //   MaterialPageRoute(builder: (ctx) { --> MaterialPageRoute as a WRAPPER to handle things like the animation from the old page to new page
    //     return CategoryMealsScreen(id, title);
    //   }),
    // );

    Navigator.of(ctx).pushNamed(CategoryMealsScreen.routeName, arguments: {
      'id': id,
      'title': title,
    });
  }

  @override
  Widget build(BuildContext context) {
    //GestureDetector allows us to add onTap, doubleTap and many other listeners
    //But it would be nice to have some VISUAL FEEDBACK -> InkWell (basically a GestureDetector which also fires off a RIPPLE EFFECT[splashColor] )
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor, //ripple effect
      borderRadius: BorderRadius.circular(15), //border radius of ripple effect
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.title,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
