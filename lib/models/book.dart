class Book {
  final String title;
  final String author;
  final String description;
  final String? bookImage;
  final String publisher;
  final int rank;
  final String amazonUrl;
  final String contributor;
  final String primaryIsbn13;

  Book({
    required this.title,
    required this.author,
    required this.description,
    this.bookImage,
    required this.publisher,
    required this.rank,
    required this.amazonUrl,
    required this.contributor,
    required this.primaryIsbn13,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    title: json['title'],
    author: json['author'],
    description: json['description'] ?? 'No description available',
    bookImage: json['book_image'],
    publisher: json['publisher'],
    rank: json['rank'],
    amazonUrl: (json['buy_links'] as List)
        .firstWhere((link) => link['name'] == 'Amazon')['url'],
    contributor: json['contributor'] ?? 'Unknown contributor',
    primaryIsbn13: json['primary_isbn13'] ?? '',
  );
}
