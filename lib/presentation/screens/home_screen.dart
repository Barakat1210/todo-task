import 'package:flutter/material.dart';

import '../../core/strings_manager.dart';
import 'tabs/settings_tab/settings_tab.dart';
import 'tabs/tasks_tab/tasks_tab.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  List<Widget> tabs = [
    TasksTab(),
    SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40),
        //     side: BorderSide(
        //   color: ColorsManager.whiteColor,
        //   width: 4,
        // )),
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: Text(StringsManager.appBarTitle),
      ),
      bottomNavigationBar: BottomAppBar(

        notchMargin: 8,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.list), label: StringsManager.listLabel),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: StringsManager.listLabel),
          ],
        ),
      ),
      body: tabs[selectedIndex],
    );
  }
}
