import 'package:flutter/material.dart';

import 'package:twix/Widgets/task/task_card.dart';
import 'package:twix/Widgets/task/task_edit_card.dart';

class Task extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool edit = true;
  final TextEditingController textEditingController = TextEditingController();

  void doneEdit() {
    setState(() {
      edit = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return edit ? TaskEditCard(
      textEditingController: textEditingController,
      callBack: doneEdit
    )
        : TaskCard(title: textEditingController.text);
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
