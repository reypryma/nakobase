
import 'package:flutter/material.dart';
import 'package:nakobase/core/models/todo.dart';
import 'package:nakobase/utils/colors.dart';
import 'package:nakobase/utils/commons.dart';
import 'package:nakobase/utils/extra/extra_commons.dart';

import '../../utils/styles.dart';

class SingleTodoComponent extends StatefulWidget {
  final Todo todo;
  final Function()? onEditClicked;
  final Function? onDeleteClicked;
  final Function()? onTapped;

  const SingleTodoComponent({super.key, required this.todo, this.onEditClicked,  this.onDeleteClicked,  this.onTapped});

  @override
  State<SingleTodoComponent> createState() => _SingleTodoComponentState();
}

class _SingleTodoComponentState extends State<SingleTodoComponent> {
  @override
  Widget build(BuildContext context) {
    return SettingItemWidget(
        title: widget.todo.title!,
        subTitle: widget.todo.updatedAt,
        onTap: widget.onTapped,
        leading: noteCheckWidget(
          context,
          color: Theme.of(context).cardColor,
          checkIconColor: kLightThemeTextColor,
          onTap: () {
            setState(() {});
          },
        ),
        trailing: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.todo.status.taskStatusName!, style: secondaryTextStyle(size: 12)),
            const SizedBox(
              width: 8,
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: textSecondaryColorGlobal, size: 12),
          ],
        ),
    );
  }
}

Widget noteCheckWidget(BuildContext context, {Color? color, Color? checkIconColor, Function()? onTap}) {
  return Container(
    padding: const EdgeInsets.all(2),
    decoration: boxDecorationDefault(shape: BoxShape.circle, color: color),
    child: Icon(Icons.check, size: 20, color: checkIconColor),
  );
}
