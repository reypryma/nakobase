import 'package:flutter/cupertino.dart';
import 'package:nakobase/data/menu_drawer.dart';

class MenuDrawerProvider extends ChangeNotifier{
  int _selectedItem = 1;

  int get selectedItem => _selectedItem;

  set selectedItem(int value) {
    _selectedItem = value;
    notifyListeners();
  }

  List<Widget> listMenus(){
    List<Widget> menuDrawers = [
      TextMenu(menuText: 'Home', isSelected: selectedItem == 0,),
      TextMenu(menuText: 'Profile', isSelected: selectedItem == 1,),
    ];
    return menuDrawers;
  }
}