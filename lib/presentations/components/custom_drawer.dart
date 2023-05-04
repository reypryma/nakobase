import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nakobase/data/menu_drawer.dart';
import 'package:nakobase/presentations/routes.dart';
import 'package:nakobase/services/providers/menu_drawer_provider.dart';
import 'package:nakobase/translations/locale_keys.g.dart';
import 'package:nakobase/utils/colors.dart';
import 'package:provider/provider.dart';

/// Drawer state defines the current drawer state on app
enum DrawerState { open, closed, opening, closing }

class CustomDrawerController extends ChangeNotifier{
  final TickerProvider? vsync;
  final Duration duration;
  late final AnimationController _animationController;
  DrawerState state = DrawerState.closed;

  CustomDrawerController({@required this.vsync, this.duration = const Duration(milliseconds: 250)}){
    _animationController = AnimationController(vsync: vsync!, duration: duration);
    _initController();
  }

  void _initController(){
    _animationController.addListener(() {
      notifyListeners();
    });
    _animationController.addStatusListener((status) {
      switch(status){
        case AnimationStatus.forward:
          state = DrawerState.opening;
          break;
        case AnimationStatus.reverse:
          state = DrawerState.closing;
          break;
        case AnimationStatus.completed:
          state = DrawerState.closed;
          break;
        case AnimationStatus.dismissed:
          state = DrawerState.closed;
          break;
        default:
          state = DrawerState.closed;
      }
      notifyListeners();
    });
  }

  get percentOpen => _animationController.value;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void open() {
    _animationController.forward();
  }

  close() {
    _animationController.reverse();
  }

  void toggle() {
    if (state == DrawerState.open) {
      close();
    } else if (state == DrawerState.closed) {
      open();
    }
  }

}

class DrawerWrapper extends StatefulWidget {
  final CustomDrawerController controller;
  final bool hideOnContentTap;
  final double cornerRadius;
  final List<Widget> drawerItems;
  final double itemGap;
  final Color backgroundColor;
  final Widget child;

  const DrawerWrapper({Key? key, required this.controller, this.hideOnContentTap = true, this.cornerRadius = 8.0, required this.drawerItems, this.itemGap = 10.0, this.backgroundColor = successIcon, required this.child}) : super(key: key);

  @override
  State<DrawerWrapper> createState() => _DrawerWrapperState();
}

class _DrawerWrapperState extends State<DrawerWrapper> {

  @override
  void initState() {
    super.initState();
  }

  Widget _renderContent() {
    final slideAmount = 275.0 * widget.controller.percentOpen;
    final contentScale = 1.0 - (0.2 * widget.controller.percentOpen);
    final cornerRadius = widget.cornerRadius * widget.controller.percentOpen;

    return Transform(
      transform: Matrix4.translationValues(slideAmount, 0.0, 0.0)..scale(contentScale, contentScale),
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), offset: const Offset(0.0, 4.0), blurRadius: 40.0, spreadRadius: 10.0)]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(cornerRadius),
          child: GestureDetector(
            onTap: () {
              if (widget.hideOnContentTap) {
                widget.controller.close();
              }
            },
            child: widget.child,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: double.infinity,
          color: widget.backgroundColor,
          child: Padding(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.drawerItems.asMap().entries.map((item) {
                    return InkWell(
                      onTap: (){
                        setState(() {
                          if (kDebugMode) {
                            print("tap");
                          }
                          Provider.of<MenuDrawerProvider>(context, listen: false).selectedItem = item.key;
                          widget.controller.close();
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: widget.itemGap),
                        child: item.value,
                      ),
                    );
                  }).toList(),
                ),
                InkWell(
                    onTap: (){
                      Navigator.pushNamedAndRemoveUntil(context, Routes.login, (Route<dynamic> route) => false,arguments: LocaleKeys.welcome_back);
                    },
                    child: TextMenu(menuText: LocaleKeys.logout.tr(),)),
              ],
            ),
          ),
        ),
        _renderContent()
      ],
    );
  }
}
