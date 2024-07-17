import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ln_hrms/models/model.menulists.dart';
import 'package:ln_hrms/router/pages.dart';
import 'package:ln_hrms/views/view.dahboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor:
              Colors.transparent, // Set to transparent for gradient
          elevation: 5, // Remove shadow if needed
        ),
      ),
      initialRoute: '/',
      getPages: appPages,
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var selectedPageTitle = "Home";
  Widget _selectedView = DashboardView();

  void _onItemTapped(MenuItem _menuitem) {
    setState(() {
      selectedPageTitle = _menuitem.title;
      _selectedView = _menuitem.view;
    });
    // Navigate to the selected page without changing AppBar and BottomNavigationBar
    selectedPageTitle = _menuitem.title;
    _selectedView = _menuitem.view;
  }

  void _onTabItemTapped(int index) {
    setState(() {
      selectedPageTitle = tabMenuItems[index].title;
      _selectedView = tabMenuItems[index].view;
    });
    // Navigate to the selected page without changing AppBar and BottomNavigationBar
    selectedPageTitle = tabMenuItems[index].title;
    _selectedView = tabMenuItems[index].view;
  }

  void _onSubMenuItemTapped(MenuItem subMenuItem) {
    setState(() {
      selectedPageTitle = subMenuItem.title;
      _selectedView = subMenuItem.view;
    });
    Navigator.pop(context); // Close the drawer
    // Navigate to the selected page without changing AppBar and BottomNavigationBar
    selectedPageTitle = subMenuItem.title;
    _selectedView = subMenuItem.view;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            selectedPageTitle.toString().toUpperCase(),
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
          ]),
      drawer: Drawer(
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
                              _onSubMenuItemTapped(subMenuItem);
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
      ),
      body: _selectedView,
      // bottomNavigationBar: BottomNavigationBar(
      //   items: tabMenuItems.map((tabMenuitem) {
      //     return BottomNavigationBarItem(
      //       icon: Icon(tabMenuitem.icon),
      //       label: tabMenuitem.title,
      //     );
      //   }).toList(),
      //   currentIndex: _selecteTabdIndex,
      //   selectedItemColor: Colors.amber[800],
      //   unselectedItemColor: Colors.grey,
      //   onTap: _onTabItemTapped,
      // ),
    );
  }
}
