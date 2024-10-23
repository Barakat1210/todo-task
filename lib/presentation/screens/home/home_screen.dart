import 'package:flutter/material.dart';

import '../../../core/strings_manager.dart';
import '../tabs/settings_tab/settings_tab.dart';
import '../tabs/tasks_tab/tasks_tab.dart';
import 'add_task_bottom_sheet/add_task_bottom_sheet.dart';
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

      floatingActionButton: buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: Text(StringsManager.appBarTitle),
      ),
      bottomNavigationBar: BottomAppBar(

        notchMargin: 8,
        child: buildButtomNavigationBar(),
      ),
      body: tabs[selectedIndex],
    );
  }

  Widget buildFab() {
    return FloatingActionButton(
      onPressed: () {
        AddTaskBottomSheet.show(context);
      },
      child: Icon(Icons.add),
    );
  }

  Widget buildButtomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      currentIndex: selectedIndex,
      onTap:onBottomNavBarTabClicked,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.list), label: StringsManager.listLabel),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings), label: StringsManager.listLabel),
      ],
    );
  }
  void onBottomNavBarTabClicked(int index){
    selectedIndex=index;
    setState(() {

    });
  }
}
