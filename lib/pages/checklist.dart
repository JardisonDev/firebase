import 'package:flutter/material.dart';
import 'package:inspector_ro/repositories/forklift.dart';

class ChecklistForklift extends StatefulWidget {
  final Forklift empilhadeira;
  const ChecklistForklift({super.key, required this.empilhadeira});

  @override
  State<ChecklistForklift> createState() => _ChecklistForkliftState();
}

class _ChecklistForkliftState extends State<ChecklistForklift> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold());
  }
}
