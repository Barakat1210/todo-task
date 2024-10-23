import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../colors_manager.dart';
import '../my_text_styles.dart';
import '../strings_manager.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).indicatorColor,
      ),
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              autoClose: true,
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {},
              backgroundColor: Color(0xFFFE4A49),
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
              flex: 1,
              onPressed: (context) {},
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Theme.of(context).primaryColor,
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
                SizedBox(
                  width: 25,
                ),
                Column(
                  children: [
                    Text(StringsManager.taskTitle,
                        style: AppLightStyles.cardTitleTextStyle),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.punch_clock,
                        ),
                        Text('10:30',
                            style: AppLightStyles.DateStyle,
                        ),],
                    ),
                  ],
                ),
                Spacer(),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.check,
                      color: ColorsManager.whiteColor,
                      size: 28,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
