import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nakobase/presentations/components/circular.dart';
import 'package:nakobase/presentations/components/custom_drawer.dart';
import 'package:nakobase/presentations/pages/profile_page.dart';
import 'package:nakobase/presentations/pages/todo/list_todo_page.dart';
import 'package:nakobase/services/providers/menu_drawer_provider.dart';
import 'package:nakobase/services/providers/profile_provider.dart';
import 'package:nakobase/services/providers/task_status_provider.dart';
import 'package:nakobase/translations/locale_keys.g.dart';
import 'package:nakobase/utils/extra/extra_commons.dart';
import 'package:provider/provider.dart';

import '../../core/models/profile.dart';
import '../../data/menu_drawer.dart';
import '../../utils/colors.dart';
import '../../utils/styles.dart';
import '../components/app_bar.dart';
import '../routes.dart';

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
  bool isLoading = true;
  ProfileProvider? profileProvider;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    _controller = CustomDrawerController(
        vsync: this, duration: const Duration(milliseconds: 250))
      ..addListener(() {
        setState(() {});
      });
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    try {
      await Provider.of<TaskStatusProvider>(context, listen: false).getStatusList();
      if (profileProvider?.profile == null) {
        await profileProvider?.getCurrentProfile().whenComplete(() => setState(() { isLoading = false;}));
      }  else{
        setState(() { isLoading = false;});
      }
    } catch (e) {
      print('Error fetch task status $e');
    }

  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = Provider.of<MenuDrawerProvider>(context, listen: false).selectedItem;
    // final Profile? profile = Provider.of<ProfileProvider>(context, listen: false).profile;

    final tabs = [const ListTodoPage(), const ProfilePage()];
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kTeal50,
      floatingActionButton: (selectedIndex == 0) ? FloatingActionButton(
        heroTag: '1',
        elevation: 5,
        onPressed: () {
          Navigator.pushNamed(context, Routes.create_todo);
        },
        child: const Icon(
          Icons.add,
          color: appPrimaryColor,
        ),
      ) : const SizedBox.shrink(),
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
          body: isLoading ? progressIndicator() : tabs[selectedIndex],
        ),
      ),
    );
  }
}
