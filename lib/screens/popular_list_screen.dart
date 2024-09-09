import 'package:flutter/material.dart';
import '../models/book_list.dart';
import '../services/api_service.dart';
import 'book_list_screen.dart';

class PopularListsScreen extends StatefulWidget {
  const PopularListsScreen({super.key});

  @override
  State<PopularListsScreen> createState() => _PopularListsScreenState();
}

class _PopularListsScreenState extends State<PopularListsScreen> {
  late Future<List<BookList>> _listsFuture;

  @override
  void initState() {
    super.initState();
    _listsFuture = ApiService.getPopularLists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popular Lists')),
      body: FutureBuilder<List<BookList>>(
        future: _listsFuture,
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
              final list = snapshot.data![index];
              return ListTile(
                title: Text(list.displayName),
                subtitle: Text(list.listName),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookListScreen(
                      listNameEncoded: list.listNameEncoded,
                      listDisplayName: list.displayName,
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
