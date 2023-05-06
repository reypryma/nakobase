import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakobase/presentations/components/custom_drawer.dart';
import 'package:nakobase/presentations/pages/gallery/list_gallery_page.dart';
import 'package:nakobase/presentations/pages/profile_page.dart';
import 'package:nakobase/services/providers/menu_drawer_provider.dart';
import 'package:nakobase/translations/locale_keys.g.dart';
import 'package:nakobase/utils/extra/extra_commons.dart';
import 'package:provider/provider.dart';

import '../../data/menu_drawer.dart';
import '../../utils/colors.dart';
import '../../utils/styles.dart';
import '../components/app_bar.dart';

class DashboardScreen extends StatefulWidget {
  bool? showAppbar;

  DashboardScreen({Key? key, this.showAppbar = false}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  CustomDrawerController? _controller;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isDrawerOpen = false;
  int selectedItem = 0;

  final tabs = [
    ListGalleryPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    _controller = CustomDrawerController(
        vsync: this, duration: const Duration(milliseconds: 250))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = Provider.of<MenuDrawerProvider>(context, listen: false).selectedItem;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kTeal50,
      body: DrawerWrapper(
        controller: _controller!,
        drawerItems: Provider.of<MenuDrawerProvider>(context, listen: false).listMenus(),
        hideOnContentTap: true,
        child: Scaffold(
          appBar: AppBar(
            elevation: 4.0,
            title: Text(LocaleKeys.AppTitle.tr(), style: boldTextStyle(color: black, size: 18)),
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.menu, color: black),
              onPressed: () {
                isDrawerOpen = !isDrawerOpen;
                if (isDrawerOpen) {
                  _controller?.open();
                } else {
                  _controller?.close();
                }
                setState(() {});
              },
            ),
            actions: [
              languageSetting(context, (){setState(() { });})
            ],
          ),
          body: tabs[selectedIndex],
        ),
      ),
    );
  }
}
