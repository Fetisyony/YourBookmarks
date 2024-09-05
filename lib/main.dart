import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bookmarks_app/models/book_note.dart';
import 'package:bookmarks_app/home_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BookNoteAdapter());
  await Hive.openBox<BookNote>('bookNotes');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}
