import 'package:flutter/material.dart';

ShowSnacbar({
  required BuildContext context,
  required String mensagen,
  bool isError = true,
}) {
  SnackBar snackBar = SnackBar(
    content: Text(mensagen),
    backgroundColor: isError ? Colors.red : Colors.lightGreen,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    duration: Duration(seconds: 3),
    
    elevation: 1,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
