import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/core/utils/dialog_utils.dart';
import 'package:todo_app/database_manager/model/todo_dm.dart';
import 'package:todo_app/database_manager/model/userdm.dart';
import 'package:todo_app/presentation/screens/home/add_task_bottom_sheet/edit_task_bottom.dart';
import '../colors_manager.dart';
import '../my_text_styles.dart';

class TaskItem extends StatefulWidget {
  final TodoDM todo;
  final Function onDeletedTask;

  TaskItem({super.key, required this.todo, required this.onDeletedTask});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Theme.of(context).indicatorColor,
      ),
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              autoClose: true,
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) => showDeleteDialog(),
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        endActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) => showEditDialog(),
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Theme.of(context).dividerColor,
                  height: 65,
                  width: 3,
                ),
                const SizedBox(width: 25),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.todo.title,
                        style: AppLightStyles.cardTitleTextStyle,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.todo.description,
                        style: AppLightStyles.cardTitleTextStyle,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.punch_clock),
                          Text(
                            '${widget.todo.date.hour}:${widget.todo.date.minute}:${widget.todo.date.second}',
                            style: AppLightStyles.DateStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showDeleteDialog() async {
    DialogUtils.showMessageDialog(
      context,
      content: 'Are you sure you want to delete this task?',
      posActionTitle: 'Yes',
      negActionTitle: 'No',
      posAction: () {
        deleteTask();
        widget.onDeletedTask();
      },
    );
  }

  Future<void> showEditDialog() async {
    DialogUtils.showMessageDialog(
      context,
      content: 'Do you want to edit this task?',
      posActionTitle: 'Yes',
      negActionTitle: 'No',
      posAction: () {
        EditTaskBottomSheet.show(
          context,
          widget.todo.id,
          widget.todo.title,
          widget.todo.description,
          widget.todo.date,
        ).then((_) {
          setState(() {}); // تحديث الحالة بعد التحرير
        });
      },
    );
  }

  Future<void> deleteTask() async {
    try {
      var tasksCollection = FirebaseFirestore.instance
          .collection(UserDM.collectionName)
          .doc(UserDM.userDM!.id)
          .collection(TodoDM.collectionName);
      await tasksCollection.doc(widget.todo.id).delete();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete task: $e')),
      );
    }
  }
}
