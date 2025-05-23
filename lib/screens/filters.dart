import 'package:flutter/material.dart';

enum FilterEnum { glutenFree, lactoseFree, vegetarian, vegan }

class Filters extends StatefulWidget {
  final Map<FilterEnum, bool> currentFilters;

  const Filters({super.key, required this.currentFilters});

  @override
  State<StatefulWidget> createState() {
    return _FiltersState();
  }
}

class _FiltersState extends State<Filters> {
  bool isGlutenFree = false;
  bool isLactoseFree = false;
  bool isVegetarian = false;
  bool isVegan = false;

  @override
  void initState() {
    isGlutenFree = widget.currentFilters[FilterEnum.glutenFree] ?? false;
    isLactoseFree = widget.currentFilters[FilterEnum.lactoseFree] ?? false;
    isVegetarian = widget.currentFilters[FilterEnum.vegetarian] ?? false;
    isVegan = widget.currentFilters[FilterEnum.vegan] ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Sidebar(onSelectScreen: (identifier) {
      //   Navigator.pop(context);
      //   if(identifier == 'meals') {
      //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => Tabs()));
      //   }
      // }),
      appBar: AppBar(title: Text('Your filters')),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (isPopped, result) {
          if (isPopped) return;
          Navigator.of(context).pop({
            FilterEnum.glutenFree: isGlutenFree,
            FilterEnum.lactoseFree: isLactoseFree,
            FilterEnum.vegetarian: isVegetarian,
            FilterEnum.vegan: isVegan,
          });
        },
        child: Column(
          children: [
            SwitchListTile(
              value: isGlutenFree,
              onChanged: (isChecked) {
                setState(() {
                  isGlutenFree = isChecked;
                });
              },
              title: Text(
                'Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Only include gluten-freen meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: isLactoseFree,
              onChanged: (isChecked) {
                setState(() {
                  isLactoseFree = isChecked;
                });
              },
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Only include lactose-freen meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: isVegetarian,
              onChanged: (isChecked) {
                setState(() {
                  isVegetarian = isChecked;
                });
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Only include vegetarian meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: isVegan,
              onChanged: (isChecked) {
                setState(() {
                  isVegan = isChecked;
                });
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Only include vegan meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
