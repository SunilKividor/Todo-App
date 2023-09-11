import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
   const ToDoTile(
      {super.key,
      required this.tileTitle,
      required this.tileIsChecked,
      required this.changeIsChecked,
      required this.deleteToDo
      });

  final String tileTitle;
  final bool tileIsChecked;
  final Function(bool? value) changeIsChecked;
  final void Function(BuildContext)? deleteToDo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
      child: Slidable(
        
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: deleteToDo,
            icon: Icons.delete,
            backgroundColor: const Color.fromARGB(255, 243, 90, 79),
            borderRadius: BorderRadius.circular(10),
          ),
        ]),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.yellow, borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(25),
          child: Row(
            children: [
              Transform.scale(
                scale: 1.5,
                child: Checkbox(
                    value: tileIsChecked,
                    onChanged: (val) {
                      changeIsChecked(val);
                    }),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                tileTitle,
                style: GoogleFonts.lato(
                    fontSize: 18,
                    decoration: tileIsChecked
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
