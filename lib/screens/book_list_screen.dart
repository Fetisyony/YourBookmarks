import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/api_service.dart';
import 'book_detail_screen.dart';

class BookListScreen extends StatefulWidget {
  final String listNameEncoded;
  final String listDisplayName;

  const BookListScreen({super.key, required this.listNameEncoded, required this.listDisplayName});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  late Future<List<Book>> _booksFuture;

  @override
  void initState() {
    super.initState();
    _booksFuture = ApiService.getBooksForList(widget.listNameEncoded);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.listDisplayName)),
      body: FutureBuilder<List<Book>>(
        future: _booksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final book = snapshot.data![index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading:
                      Hero(
                          tag: book.bookImage ?? defaultImageUrl,
                          child: book.bookImage != null
                            ? Image.network(book.bookImage!, width: 60)
                            : const Icon(Icons.book)
                      ),
                  title: Text(book.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('by ${book.author}'),
                      Text(book.publisher),
                      const SizedBox(height: 4),
                      Text(
                        book.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  trailing: Text('#${book.rank}'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetailScreen(book: book),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
