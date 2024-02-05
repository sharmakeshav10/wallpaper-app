import 'package:flutter/material.dart';

Widget customAppBar() {
  return Center(
    child: RichText(
      text: TextSpan(
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        children: const <TextSpan>[
          TextSpan(
              text: 'Picture', style: TextStyle(color: Colors.black)),
          TextSpan(text: 'Perfect', style: TextStyle(color: Colors.purple)),
        ],
      ),
    ),
  );
}
