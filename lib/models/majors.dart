
import 'package:flutter/material.dart';

List<String> majors = [
  'Computer Science',
  'Computer Science and Software Engineering',
  'Software, Data and Technology',
  'Electrical and Computer Engineering',
  'Robotics and intelligent Systems',
  'Global Economics and Management',
  'Industrial Engineering and Management',
  'Integrated Social and Cognitive Psychology',
  'International Business Administration',
  'International Relations: Politics and History',
  'Management, Decision and Data Analytics',
  'Society, Media and Politics',
  'Matematics',
  'Matematics, Modeling and Data Analytics',
  'Physics',
  'Physics and Data Science',
  'Medicinal Chemistry and Chemical Biology',
  'Biochemistry and Cell Biology',
  'Chemistry and Biotechnology',
  'Earth and Environmental Sciences',
  'Earth Sciences and Sustainable Management of Environmental Resources'

];
List<Text> majors1 = [
  const Text('Computer Science'),
  const Text('Computer Science and Software Engineering'),
  const Text('Software, Data and Technolog'),
  const Text('Electrical and Computer Engineering'),
  const Text('Robotics and intelligent Systems'),
  const Text('Global Economics and Management'),
  const Text('Industrial Engineering and Management'),
  const Text('Integrated Social and Cognitive Psychology'),
  const Text('International Business Administration'),
  const Text('International Relations: Politics and History'),
  const Text('Management, Decision and Data Analytics'),
  const Text('Society, Media and Politics'),
  const Text('Matematics'),
  const Text('Matematics, Modeling and Data Analytics'),
  const Text('Physics'),
  const Text('Physics and Data Science'),
  const Text('Medicinal Chemistry and Chemical Biology'),
  const Text('Biochemistry and Cell Biology'),
  const Text('Chemistry and Biotechnology'),
  const Text('Earth and Environmental Sciences'),
  const Text('Earth Sciences and Sustainable Management of Environmental Resources'),
];

class SelectedMajor{
  late final String name;
  getName(){
    return name;
  }
}