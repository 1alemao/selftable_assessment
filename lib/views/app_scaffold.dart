import 'package:cat_holder/views/cats_page.dart';
import 'package:cat_holder/views/profile_page.dart';
import 'package:flutter/material.dart';

/*
  This StatefulWidget is a scaffold that controls the content that is displayed to
  the user (cats list or profile page).
  It uses a custom bottom navigation bar to better represent the figma mock
*/
class CatHolderScaffold extends StatefulWidget {
  const CatHolderScaffold({Key? key}) : super(key: key);

  @override
  State<CatHolderScaffold> createState() => _CatHolderScaffoldState();
}

class _CatHolderScaffoldState extends State<CatHolderScaffold> {
  // The user selected page index
  int _selectedIndex = 0;

  // List of pages to be displayed according to the user selection
  static final List<Widget> _pages = <Widget>[
    const CatsPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The app bar is only used for constraining the content of the app
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: customNavBar(context),
    );
  }

  // This is the custom botttom navigation bar for the assessment
  Container customNavBar(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.white, Colors.orange[100]!]),
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
            // Changes color according to the selected page
            icon: _selectedIndex == 0
                ? const Icon(
                    Icons.list,
                    color: Colors.orange,
                    size: 35,
                  )
                : const Icon(
                    Icons.list,
                    color: Colors.black,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
            icon: _selectedIndex == 1
                ? const Icon(
                    Icons.account_circle,
                    color: Colors.orange,
                    size: 35,
                  )
                : const Icon(
                    Icons.account_circle,
                    color: Colors.black,
                    size: 35,
                  ),
          ),
        ],
      ),
    );
  }
}
