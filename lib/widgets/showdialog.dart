import 'package:flutter/material.dart';

class AddNewToDo extends StatelessWidget {
  const AddNewToDo(
      {super.key,
      required this.titleController,
      required this.onSave,
      required this.onCancel,
      });

  final titleController;
  final Function() onSave;
  final Function() onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[400],
      content: SizedBox(
        height: 120,
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                  hintText: "Add new Task",
                  hintStyle: TextStyle(fontWeight: FontWeight.w100)),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: onCancel, child: const Text("Cancel")),
                ElevatedButton(
                    onPressed: onSave,
                    child: const Text(
                      "Save",
                      style: TextStyle(fontSize: 16),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
