class WebtoonModel {
  final String id;
  final String title;
  final String thumbnail;

  final String? about;
  final String? genre;
  final String? author;

  // named constructor
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        thumbnail = json['thumb'],
        about = json['about'],
        genre = json['genre'],
        author = json['author'];
}
