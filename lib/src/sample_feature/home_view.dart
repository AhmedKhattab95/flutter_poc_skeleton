import 'package:flutter/material.dart';
import 'package:my_app/src/cart_feature/product_page.dart';
import 'package:my_app/src/models/user_data.dart';
import 'package:my_app/src/sample_feature/stagged_grid_design.dart';

import '../settings/settings_view.dart';
import 'facebook_login_page.dart';
import 'gmail_login_page.dart';
import 'sample_item.dart';
import 'sample_item_details_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_app/core/services/service_lib.dart';
import 'package:my_app/src/managers/managers_lib.dart';

/// Displays a list of SampleItems.
class HomeView extends StatefulWidget {
  HomeView({
    Key? key,
  }) : super(key: key);

  static const routeName = '/homepage';

  @override
  State<HomeView> createState() => _HomeViewState();

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    HomeDesing(),
    StaggedGridDesign(),
    ProductPage(),
    GmailLoginPage(),
    FacebookLoginPage(),
  ];
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.sampeItems),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
          ElevatedButton(
            child: Text('Logout'),
            onPressed: () {
              DI<UserSessionManager>().logout();
            },
          ),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: HomeView._widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        items: [Icons.home, Icons.people, Icons.shopping_cart_rounded, Icons.person_pin, Icons.notifications_outlined]
            .map((e) => BottomNavigationBarItem(
                  icon: getIcon(e),
                  title: getSelectedDesign(), /*backgroundColor: Colors.white*/
                ))
            .toList(),
        currentIndex: _selectedIndex,
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        selectedIconTheme: IconThemeData(color: Colors.green),
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool isSelected(int index) {
    return (index == _selectedIndex);
  }

  Widget getIcon(IconData icon) {
    return Icon(
      icon,
      size: 35,
    );
  }

  Widget getSelectedDesign() {
    return Container(
      height: 4,
      color: Colors.green,
      margin: EdgeInsets.symmetric(horizontal: 20),
    );
  }
}

///////////////////////////////

class HomeDesing extends StatelessWidget {
  final List<SampleItem> items;

  HomeDesing({
    this.items = const [SampleItem(1), SampleItem(2), SampleItem(3)],
  });

  @override
  Widget build(BuildContext context) {
    var _cacheManager = DI<CacheManager>();
    return FutureBuilder<UserData?>(
        future: _cacheManager.getUserData(),
        builder: (BuildContext context, AsyncSnapshot<UserData?> snapshot) {
          if (snapshot.hasData) {
            var userData = snapshot.data;
            return ListView.builder(
              // Providing a restorationId allows the ListView to restore the
              // scroll position when a user leaves and returns to the app after it
              // has been killed while running in the background.
              restorationId: 'sampleItemListView',
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = items[index];
                if (index == 0)
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(userData?.photoUrl ?? ''),
                    ),
                    title: Text((userData?.name ?? '') + "\nLogged in from: " + (userData?.loginMethod?.toString() ?? '') + '\n'),
                    subtitle: Text(userData?.email ?? ''),
                  );

                return ListTile(
                    title: Text('SampleItem ${item.id}'),
                    leading: const CircleAvatar(
                      // Display the Flutter Logo image asset.
                      foregroundImage: AssetImage('assets/images/flutter_logo.png'),
                    ),
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has been killed while running in the
                      // background, the navigation stack is restored.
                      Navigator.restorablePushNamed(
                        context,
                        SampleItemDetailsView.routeName,
                      );
                    });
              },
            );
          }
          return Container();
        });
  }
}
