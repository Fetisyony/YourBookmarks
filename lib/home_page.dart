import 'package:flutter/material.dart';
import 'generated/l10n/app_localizations.dart';
import 'models/book_note.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'add_note_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box<BookNote> notesBox;

  @override
  void initState() {
    super.initState();
    notesBox = Hive.box<BookNote>('bookNotes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Notes'),
      ),
      body: ValueListenableBuilder(
        valueListenable: notesBox.listenable(),
        builder: (context, Box<BookNote> box, _) {
          if (box.isEmpty) {
            return Center(
              child: Text(AppLocalizations.of(context)!.noNotesYet),
            );
          }
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final note = box.getAt(index);
              return Dismissible(
                key: Key(note!.date.toString()),
                onDismissed: (_) => box.deleteAt(index),
                background: Container(color: Colors.red),
                child: Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(note.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.authorPrefix(note.author)),
                        const SizedBox(height: 4),
                        Text(note.note),
                        const SizedBox(height: 8),
                        Text(
                          note.formattedDate,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddNoteScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
