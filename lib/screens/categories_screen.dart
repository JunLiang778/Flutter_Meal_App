import 'package:flutter/material.dart';
import '../widgets/category_item.dart';
import '../dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //the gridView also hv .builder() mode if u want to build dynamic amount of items (dont know in advance how many items ull have)
    return  GridView(
        padding:const EdgeInsets.all(25),
        children: DUMMY_CATEGORIES.map((catData) {
          return CategoryItem(
            catData.id,
            catData.title,
            catData.color,
          );
        }).toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
    );

    //slivers in Flutter r rly just scrollable areas on the screen
    //grid delegate means that for the grid, this takes care about structuring, layouting the grid, so this task of providing a layout is delegated away to this class
    //withMaxCrossAxisExtent simply means preconfigured class which allows us to define a max width for each grid item and then it will auto create as many columns as we can fit items with that provided width next to each other
    //maxCrossAxisExtent: 200, -> it depends on the device size of how many columns we get in that grid. Eg: Device size = 500, 2 columns
    //childAspectRatio: 3/2 defines how the items should be sized regarding their height/width. 3 by 2 relation (3/2 or 1.5)-> 200width, 300height
  }
}
