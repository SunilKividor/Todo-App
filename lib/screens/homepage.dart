import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/screens/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool chechBoxStatus = false;
  void chechBoxChange(bool value) {
    setState(() {
      chechBoxStatus = value;
    });
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ToDoList()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 280,
            ),
            Text(
              "Hello, Welcome",
              style: GoogleFonts.aBeeZee(
                fontSize: 40,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.scale(
                    scale: 1.7,
                    child: Checkbox(
                        value: chechBoxStatus,
                        onChanged: (val) {
                          chechBoxChange(val!);
                        })),
                const SizedBox(
                  width: 18,
                ),
                const Text(
                  "My ToDo's",
                  style: TextStyle(fontSize: 25),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
