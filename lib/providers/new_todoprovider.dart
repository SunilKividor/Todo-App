import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/models/todo.dart';

class ToDoNotifier extends StateNotifier<List<ToDo>> {
  ToDoNotifier() : super([]);

  void onSave(ToDo newTodo) {
    state = [...state, newTodo];
  }

   void changeIsChecked(bool? value, int index) {
    state[index].isChecked = !state[index].isChecked;
    state = [...state];
  }

   void deleteToDo(int index) {
    // setState(() {
    //   todoList.removeAt(index);
    // });
    state.removeAt(index);
    state = [...state];
  }
}

final filerNotCompleteProvider = Provider((ref) {
  List<ToDo> unfiltered = ref.watch(todoListProvider);
  List<ToDo> notComplete = unfiltered.where((todo) => todo.isChecked == false).toList();

  return notComplete;
});
final filerCompleteProvider = Provider((ref) {
  List<ToDo> unfiltered = ref.watch(todoListProvider);
  List<ToDo> Complete = unfiltered.where((todo) => todo.isChecked != false).toList();

  return Complete;
});

final todoListProvider =
    StateNotifierProvider<ToDoNotifier, List<ToDo>>((ref) => ToDoNotifier());
