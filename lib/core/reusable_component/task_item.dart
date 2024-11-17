import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/core/routes_manager.dart';
import 'package:todo_app/core/utils/dialog_utils.dart';
import 'package:todo_app/database_manager/model/todo_dm.dart';
import 'package:todo_app/database_manager/model/userdm.dart';
import '../my_text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              label: AppLocalizations.of(context)!.delete,
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
              label: AppLocalizations.of(context)!.edit,
            ),
          ],
        ),
        child: Card(
          color: Colors.transparent,
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
                          Icon(
                            Icons.punch_clock,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${widget.todo.date.hour}:${widget.todo.date.minute}:${widget.todo.date.second}',
                            style: AppLightStyles.DateStyle?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
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
      content: AppLocalizations.of(context)!
          .are_you_sure_you_want_to_delete_this_task,
      posActionTitle: AppLocalizations.of(context)!.yes,
      negActionTitle: AppLocalizations.of(context)!.no,
      posAction: () {
        deleteTask();
        widget.onDeletedTask(); // Notify parent widget that task was deleted

      },
      negAction: (){

      }
    );
  }

  Future<void> showEditDialog() async {
    DialogUtils.showMessageDialog(
      context,
      content: AppLocalizations.of(context)!.do_you_want_to_edit_this_task,
      posActionTitle: AppLocalizations.of(context)!.yes,
      negActionTitle: AppLocalizations.of(context)!.no,
      posAction: () async {
        final update = await Navigator.pushNamed(
          context,
          RoutesManager.editRoute,
          arguments: {
            'taskId': widget.todo.id,
            'title': widget.todo.title,
            'description': widget.todo.description,
            'date': widget.todo.date,
          },
        );
        if (update == true) {
          setState(() {
            Navigator.pop(
                context, true); // Close the dialog and refresh the task list
          });
        }
      },
      negAction: () {
        Navigator.pop(context); // Just close the dialog if not editing
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
