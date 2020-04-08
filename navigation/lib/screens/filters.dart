import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class Filters extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;

  Filters(this.saveFilters);

  @override
  _FiltersState createState() => _FiltersState();
}

Widget _buildSwitchTile(
    String title, String description, bool currentValue, Function updateValue) {
  return SwitchListTile(
    title: Text(
      title,
    ),
    value: currentValue,
    subtitle: Text(description),
    onChanged: updateValue,
  );
}

class _FiltersState extends State<Filters> {
  bool _gluteanFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Filters'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () => widget.saveFilters({
                'gluten': _gluteanFree,
                'lactose': _lactoseFree,
                'vegetarian': _vegetarian,
                'vegan': _vegan
              }),
            )
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text('Adjust your meal selection',
                  style: Theme.of(context).textTheme.title),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildSwitchTile(
                    'Gluten free',
                    'Only include gluten free meals',
                    _gluteanFree,
                    (newValue) {
                      setState(() {
                        _gluteanFree = newValue;
                      });
                    },
                  ),
                  _buildSwitchTile(
                    'Lactose free',
                    'Only include lactose  free meals',
                    _lactoseFree,
                    (newValue) {
                      setState(() {
                        _lactoseFree = newValue;
                      });
                    },
                  ),
                  _buildSwitchTile(
                    'Vegetarian',
                    'Only include vegetarian meals',
                    _vegetarian,
                    (newValue) {
                      setState(() {
                        _vegetarian = newValue;
                      });
                    },
                  ),
                  _buildSwitchTile(
                    'Vegan',
                    'Only include vegan meals',
                    _vegan,
                    (newValue) {
                      setState(() {
                        _vegan = newValue;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
