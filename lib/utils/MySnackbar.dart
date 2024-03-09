import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showSnackBar(
    {required BuildContext context,
    required String text,
    bool isError = true}) {
  SnackBar snackBar = SnackBar(
    content: Text(text),
    backgroundColor: (isError)? Colors.red :Colors.green,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
