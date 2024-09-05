class BookList {
  final String listName;
  final String displayName;
  final String listNameEncoded;

  BookList({
    required this.listName,
    required this.displayName,
    required this.listNameEncoded,
  });

  factory BookList.fromJson(Map<String, dynamic> json) => BookList(
    listName: json['list_name'],
    displayName: json['display_name'],
    listNameEncoded: json['list_name_encoded'],
  );
}
