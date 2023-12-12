import 'package:lesson_21_news_api/model/source_model.dart';

class NewsModel {
  final SourceModel source;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String? content;

  NewsModel({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

      /// Це фабричний конструктор класу NewsModel, який використовується
      /// для створення екземпляру NewsModel з JSON
  factory NewsModel.fromJson(Map<String, dynamic> json) {
      /// factory NewsModel.fromJson(Map<String, dynamic> json) {: Це оголошення
      /// фабричного конструктора. Фабричні конструктори в Dart використовуються
      /// для імплементації конструкторів, які не обов'язково створюють новий
      /// екземпляр їх класу. В цьому випадку, fromJson є назвою конструктора,
      /// а Map<String, dynamic> json – це параметр, який приймає JSON-об'єкт
      /// у вигляді мапи.

    return NewsModel(
      source: SourceModel.fromJson(json['source']),
      author: json['author'] ?? '',
      title: json['title'],
      description: json['description'] ?? '',
      url: json['url'],
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      content: json['content'] ?? '',

      /// return NewsModel(: Тут створюється новий екземпляр NewsModel з
      /// допомогою його конструктора.

    );
  }
}
