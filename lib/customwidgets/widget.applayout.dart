import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ln_hrms/models/model.menulists.dart';
import 'package:ln_hrms/router/pages.dart';
import 'package:ln_hrms/helpers/helper.config.dart';

class AppBarView extends StatelessWidget implements PreferredSizeWidget {
  final Config config = Config();

  AppBarView();

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          config.pageTitle.value.toString().toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFeaafc8),
                Color(0xFF654ea3),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            color: Colors.white,
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
        ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class DrawerView extends StatelessWidget {
  DrawerView();
  void _onItemTapped(MenuItem _menuitem) {
    Config().setPageTitle(_menuitem.title);
    Get.to(_menuitem.view);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("lib/assets/png/mountains.png"),
                    fit: BoxFit.fill)),
            child: null,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ...drawerMenuItems.map((menuItem) {
                  if (menuItem.subMenuItems == null ||
                      menuItem.subMenuItems!.isEmpty) {
                    return ListTile(
                      leading: Icon(menuItem.icon),
                      title: Text(menuItem.title),
                      // subtitle: Text(menuItem.description),
                      onTap: () {
                        Navigator.pop(context); // Close the drawer
                        _onItemTapped(menuItem);
                      },
                    );
                  } else {
                    return ExpansionTile(
                      leading: Icon(menuItem.icon),
                      title: Text(menuItem.title),
                      children: menuItem.subMenuItems!.map((subMenuItem) {
                        return ListTile(
                          leading: Icon(
                            subMenuItem.icon,
                            size: 16,
                          ),
                          title: Text(subMenuItem.title),
                          // subtitle: Text(subMenuItem.description),
                          onTap: () {
                            _onItemTapped(subMenuItem);
                          },
                        );
                      }).toList(),
                    );
                  }
                }).toList(),
              ],
            ),
          ),
          const ListTile(
            leading: Icon(Icons.info),
            title: Text('v0.0.1'),
          ),
        ],
      ),
    );
  }
}
