
import 'package:flutter/material.dart';

List<String> majors = [
  'Computer Science',
'Math',
'Physics',
];
List<Text> majors1 = [
 const Text('Computer Science'),
const Text('Math'),
const Text('Physics'),
];

class SelectedMajor{
  late final String name;
  getName(){
    return name;
  }
}