// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Todo {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  bool status;
  @HiveField(3)
  String dateOfCreation;
  Todo({
    required this.title,
    required this.description,
    required this.status,
    required this.dateOfCreation,
  });
}
