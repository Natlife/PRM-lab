class BookModel {
  final int id;
  final String title;
  final String author;
  final int year;
  final String genre;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.year,
    required this.genre,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      year: json['year'] ?? 0,
      genre: json['genre'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'year': year,
      'genre': genre,
    };
  }
}
