import 'package:flutter/material.dart';

class ViewButtons extends StatelessWidget {
  const ViewButtons({super.key});

  static ButtonStyle viewButtonStyle = ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Set the border radius here
      ),
    ),
    side: MaterialStateProperty.all<BorderSide>(
      const BorderSide(
        color: Color.fromARGB(255, 22, 93, 151), // Set the border color here
        width: 1.0, // You can adjust the border width as well
      ),
    ),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 25,
      ), // Set the padding here
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.threesixty,
              color: Color.fromARGB(255, 22, 93, 151),
            ),
            label: const Text(
              "VIEW 360\u00B0",
              style: TextStyle(color: Color.fromARGB(255, 22, 93, 151)),
            ),
            style: viewButtonStyle,
          ),
          Flexible(flex: 1, child: Container()),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.remove_red_eye_sharp,
              color: Color.fromARGB(255, 22, 93, 151),
            ),
            label: const Text(
              "VIEW IN YOUR ROOM",
              style: TextStyle(color: Color.fromARGB(255, 22, 93, 151)),
            ),
            style: viewButtonStyle,
          ),
        ],
      ),
    );
  }
}
