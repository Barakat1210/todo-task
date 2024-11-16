import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/colors_manager.dart';
import 'package:todo_app/core/my_text_styles.dart';
import 'package:todo_app/core/strings_manager.dart';
import 'package:todo_app/database_manager/model/todo_dm.dart';
import 'package:todo_app/database_manager/model/userdm.dart';
import 'package:todo_app/presentation/screens/home/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class EditScreen extends StatefulWidget {
  EditScreen(
      {super.key,
        required this.taskId,
        required this.title,
        required this.description,
        required this.date});

  String taskId;
  String description;
  String title;
  DateTime date;

  @override
  State<EditScreen> createState() => EditScreenState();

  static Future show(
      BuildContext context,
      String taskId,
      String newTitle,
      String newDescription,
      DateTime newDate,
      ) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: EditScreen(
          taskId: taskId,
          title: newTitle,
          description: newDescription,
          date: newDate,
        ),
      ),
    );
  }
}

class EditScreenState extends State<EditScreen> {
  bool isSaving = false;
  late TextEditingController titleController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  DateTime userSelectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    userSelectedDate = widget.date;
    titleController.text = widget.title;
    descriptionController.text = widget.description;
  }

  void showTaskDatePicker() async {
    userSelectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))) ??
        userSelectedDate;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.to_do_list,
          style: AppLightStyles.AppBarTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            color: ColorsManager.whiteColor,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.all(14),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppLocalizations.of(context)!.edit_Task,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return 'Please edit the task title';
                      }
                      return null;
                    },
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText:  AppLocalizations.of(context)!.enter_task_title,
                      hintStyle: AppLightStyles.AppBarTextStyle?.copyWith(
                        color: ColorsManager.editItem,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return 'Please edit the task description';
                      }
                      return null;
                    },
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText:  AppLocalizations.of(context)!.enter_task_description,
                      hintStyle: AppLightStyles.AppBarTextStyle?.copyWith(
                        color: ColorsManager.editItem,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.select_date,
                    style: AppLightStyles.AppBarTextStyle?.copyWith(
                      color: ColorsManager.editItem,
                    ),
                  ),
                  SizedBox(height: 15),
                  InkWell(
                    onTap: () {
                      showTaskDatePicker();
                    },
                    child: Text(
                      userSelectedDate.toLocal().toString().split(' ')[0],
                      textAlign: TextAlign.center,
                      style: AppLightStyles.AppBarTextStyle?.copyWith(
                        color: ColorsManager.editItem,
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        await editTask(
                          titleController.text,
                          descriptionController.text,
                          userSelectedDate,
                        );
                      }
                    },style:ElevatedButton.styleFrom(backgroundColor: ColorsManager.blueColor) ,
                    child: isSaving
                        ? CircularProgressIndicator()
                        : Text(
                      AppLocalizations.of(context)!.save_changes,
                      style: AppLightStyles.AppBarTextStyle?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> editTask(
      String newTitle, String newDescription, DateTime newDate) async {
    setState(() {
      isSaving = true; // Show loading indicator
    });

    try {
      var tasksCollection = FirebaseFirestore.instance
          .collection(UserDM.collectionName)
          .doc(UserDM.userDM!.id)
          .collection(TodoDM.collectionName);

      // Update the task document in Firestore
      await tasksCollection.doc(widget.taskId).update({
        'title': newTitle,
        'description': newDescription,
        'date': Timestamp.fromDate(newDate),
      });
      if (mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen())); // Close the screen with success
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to edit task: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false; // Hide loading indicator
        });
      }
    }
  }
}
