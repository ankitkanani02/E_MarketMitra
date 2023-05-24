import 'package:emmitra/screens/analytics_screen.dart';
import 'package:emmitra/screens/google_map.dart';
import 'package:emmitra/screens/google_map1.dart';
import 'package:emmitra/screens/news_api.dart';
import 'package:emmitra/screens/temp_invo.dart';
import 'package:emmitra/screens/user_profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';

class HomeDemo extends StatefulWidget {
  const HomeDemo({Key? key}) : super(key: key);

  @override
  State<HomeDemo> createState() => _HomeDemoState();
}

class _HomeDemoState extends State<HomeDemo> {
  var _currentIndex = 0;
  static final _pageOptions = [
    InvoProductData(),
    const NewsApi(),
    const AnalyticsPage(),
    GoogleMapPage(),
    // GoogleMapApi(),
    UserProfilePageWidget(),
    // HomeScreen(), InboxScreen(), S
    // ignInScreen()
  ];

  Widget _buildTitle() {
    return CustomNavigationBar(
      iconSize: 30.0,
      selectedColor: const Color(0xff040307),
      strokeColor: const Color(0x30040307),
      unSelectedColor: const Color(0xffacacac),
      backgroundColor: Colors.white,
      items: [
        CustomNavigationBarItem(
          icon: const Icon(Icons.inventory_2_outlined),
          title: const Text("Invenotry"),
        ),
        CustomNavigationBarItem(
          icon: const Icon(CupertinoIcons.news),
          title: const Text("News"),
        ),
        CustomNavigationBarItem(
          icon: const Icon(Icons.analytics_outlined),
          title: const Text("Explore"),
        ),
        CustomNavigationBarItem(
          icon: const Icon(Icons.search),
          title: const Text("Map"),
        ),
        CustomNavigationBarItem(
          icon: const Icon(Icons.account_circle),
          title: const Text("Me"),
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          if (index != null) _currentIndex = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildTitle(),
      body: _pageOptions[_currentIndex],
    );
  }
}




// import 'package:flutter/material.dart';

// class HomeDemo extends StatefulWidget {
//   const HomeDemo({Key? key}) : super(key: key);

//   @override
//   State<HomeDemo> createState() => _HomeDemoState();
// }

// class _HomeDemoState extends State<HomeDemo> {
//   var _selectedIndex = 0;
//   static const List<Widget> _pages = <Widget>[
//     Icon(
//       Icons.call,
//       size: 150,
//     ),
//     Icon(
//       Icons.camera,
//       size: 150,
//     ),
//     Icon(
//       Icons.chat,
//       size: 150,
//     ),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
  //       bottomNavigationBar: BottomNavigationBar(
  //         backgroundColor: Colors.black,
  //         type: BottomNavigationBarType.shifting,
  //         selectedFontSize: 20,
  //         selectedIconTheme: IconThemeData(color: Colors.amberAccent),
  //         selectedItemColor: Colors.amberAccent,
  //         selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
  //         items: const <BottomNavigationBarItem>[
  //           BottomNavigationBarItem(
  //             icon: Icon(
  //               Icons.call,
  //             ),
  //             label: 'Calls',
  //           ),
  //           BottomNavigationBarItem(
  //             icon: Icon(
  //               Icons.camera,
  //             ),
  //             label: 'Camera',
  //           ),
  //           BottomNavigationBarItem(
  //             icon: Icon(
  //               Icons.chat,
  //             ),
  //             label: 'Chats',
  //           ),
  //         ],
  //         currentIndex: _selectedIndex, //New
  //         onTap: _onItemTapped,
  //       ),
  //       appBar: AppBar(
  //         title: const Text('BottomNavigationBar Demo'),
  //       ),
  //       body: IndexedStack(
  //         index: _selectedIndex,
  //         children: _pages,
  //       ));
  // }
// }
