import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/providers/new_todoprovider.dart';
import 'package:todoapp/widgets/showDialog.dart';
import 'package:todoapp/widgets/todo_tile.dart';

class ToDoList extends ConsumerStatefulWidget {
  const ToDoList({super.key});

  @override
  ConsumerState<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends ConsumerState<ToDoList> {
  final titleController = TextEditingController();
  bool filterNotComplete = false;
  bool filterComplete = false;

  void onSave() {
    if (titleController.text.isEmpty) {
      Navigator.of(context).pop();
    } else {
      ref.read(todoListProvider.notifier).onSave(
            ToDo(title: titleController.text),
          );
      titleController.clear();
      Navigator.of(context).pop();
    }
  }

  void addToDo() {
    showDialog(
        context: context,
        builder: (ctx) => AddNewToDo(
              titleController: titleController,
              onSave: onSave,
              onCancel: () => Navigator.of(context).pop(),
            ));
  }

  void filterNotCompletePressed(bool filter) {
    setState(() {
      filterNotComplete = filter;
      filterComplete = false;
    });
  }

  void filterCompletePressed(bool filter) {
    setState(() {
      filterComplete = filter;
      filterNotComplete = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<ToDo> todos = ref.watch(todoListProvider);
    if (filterNotComplete) {
      todos = ref.watch(filerNotCompleteProvider);
      if(todos.isEmpty){
        todos = ref.watch(todoListProvider);
      }
    } else if (filterComplete) {
      todos = ref.watch(filerCompleteProvider);
      if(todos.isEmpty){
        todos = ref.watch(todoListProvider);
      }
    }

    Widget activeScreen = Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            child: Card(
              color: const Color.fromARGB(255, 212, 227, 7),
              child: Column(
                children: [
                  ListTile(
                    leading: const Text(
                      'Not completed',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Switch(
                        value: filterNotComplete,
                        onChanged: filterNotCompletePressed),
                  ),
                  ListTile(
                    leading: const Text(
                      'Completed',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Switch(
                        value: filterComplete,
                        onChanged: filterCompletePressed),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) => ToDoTile(
              tileTitle: todos[index].title,
              tileIsChecked: todos[index].isChecked,
              changeIsChecked: (value) => ref
                  .read(todoListProvider.notifier)
                  .changeIsChecked(value, index),
              deleteToDo: (context) =>
                  ref.read(todoListProvider.notifier).deleteToDo(index),
            ),
          ),
        ),
      ],
    );
    if (todos.isEmpty) {
      activeScreen = Center(
          child: Text(
        "Add ToDo",
        style: GoogleFonts.aBeeZee(fontSize: 18, fontWeight: FontWeight.w400),
      ));
    }
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text("To Do"),
          backgroundColor: Colors.yellow,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addToDo,
          backgroundColor: Colors.yellow,
          child: const Icon(Icons.add),
        ),
        body: activeScreen);
  }
}
