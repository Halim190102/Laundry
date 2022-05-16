import 'package:bottom_animation/bottom_animation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/Component/Theme/theme.dart';
import 'package:mini_project/View Model/db_data_manager.dart';
import 'package:mini_project/Views/Body_screen/Consumer/consumer.dart';
import 'package:mini_project/Views/Body_screen/body_1.dart';
import 'package:mini_project/Views/Bottom_sheet_screen/bottom_sheet.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectednavbar = 0;

  bool isInit = true;

  final uid = FirebaseAuth.instance.currentUser!.uid;
  final items = <BottomNavItem>[
    BottomNavItem(title: 'Beranda', widget: const Icon(Icons.home)),
    BottomNavItem(title: 'Riwayat', widget: const Icon(Icons.assignment)),
  ];

  static const List<String> _title = <String>['Selamat Datang', 'Riwayat'];
  static const List<Widget> _pages = <Widget>[
    Body1(),
    Consume(),
  ];

  void _changeSelectedNavbar(int i) {
    setState(() {
      _selectednavbar = i;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final data = Provider.of<DataManager>(context).allData;
    if (data.isEmpty) {
      if (isInit) {
        Provider.of<DataManager>(context).initialData(uid);
      }
      isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ThemesColor().primaryBar,
        centerTitle: true,
        title: Text(
          _title.elementAt(_selectednavbar),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                context: context,
                builder: (context) => const BottomSheets(),
              );
            },
            icon: const Icon(Icons.account_circle),
          ),
        ],
      ),
      body: Container(
        color: ThemesColor().primaryBody,
        child: _pages.elementAt(_selectednavbar),
      ),
      bottomNavigationBar: BottomAnimation(
        barHeight: 65,
        selectedIndex: _selectednavbar,
        items: items,
        activeIconColor: Colors.blue,
        deActiveIconColor: Colors.white,
        backgroundColor: ThemesColor().primaryBar,
        onItemSelect: _changeSelectedNavbar,
        itemHoverColor: Colors.white,
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        itemHoverBorderRadius: 25,
        itemHoverWidth: 130,
      ),
    );
  }
}
