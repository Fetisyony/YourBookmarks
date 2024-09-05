class Book {
  final String title;
  final String author;
  final String description;
  final String? bookImage;
  final String publisher;
  final int rank;
  final String amazonUrl;

  Book({
    required this.title,
    required this.author,
    required this.description,
    this.bookImage,
    required this.publisher,
    required this.rank,
    required this.amazonUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    title: json['title'],
    author: json['author'],
    description: json['description'],
    bookImage: json['book_image'],
    publisher: json['publisher'],
    rank: json['rank'],
    amazonUrl: (json['buy_links'] as List)
        .firstWhere((link) => link['name'] == 'Amazon')['url'],
  );
}