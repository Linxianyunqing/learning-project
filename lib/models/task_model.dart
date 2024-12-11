// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject{
  @HiveType(typeId:  0)
  String title;

  @HiveType(typeId:  1)
  String description;

  @HiveType(typeId:  2)
  bool isCompleted;

  @HiveType(typeId:  3)
  DateTime dueDate;
  
  Task({
    required this.title,
    required this.description,
    this.isCompleted = false , 
    required this.dueDate
    });


}