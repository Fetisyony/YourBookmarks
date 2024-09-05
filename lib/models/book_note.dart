import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'book_note.g.dart';

@HiveType(typeId: 0)
class BookNote {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String author;

  @HiveField(2)
  final String note;

  @HiveField(3)
  final DateTime date;

  BookNote({
    required this.title,
    required this.author,
    required this.note,
    required this.date,
  });

  String get formattedDate => DateFormat('MMM dd, yyyy').format(date);
}
