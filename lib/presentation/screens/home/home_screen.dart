import 'package:flutter/material.dart';

import '../../../core/strings_manager.dart';
import '../tabs/settings_tab/settings_tab.dart';
import '../tabs/tasks_tab/tasks_tab.dart';
import 'add_task_bottom_sheet/add_task_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  GlobalKey<TasksTabState> tasksTabKey = GlobalKey();
  List<Widget> tabs = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabs = [
      TasksTab(
        key: tasksTabKey,
      ),
      SettingsTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.to_do_list),
        elevation: 0,
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 4,
        child: buildBottomNavigationBar(),
      ),
      body: tabs[selectedIndex],
    );
  }
  Widget buildFab() {
    return FloatingActionButton(
      onPressed: () {
        AddTaskBottomSheet.show(context);
        tasksTabKey.currentState?.readTodosFireStore();
      },
      child: Icon(Icons.add),
    );
  }

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(

      elevation: 0,
      currentIndex: selectedIndex,
      onTap: onBottomNavBarTabClicked,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.list), label: AppLocalizations.of(context)!.tasks),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings), label: AppLocalizations.of(context)!.settings),
      ],
    );
  }

  void onBottomNavBarTabClicked(int index) {
    selectedIndex = index;
    setState(() {});
  }
}
