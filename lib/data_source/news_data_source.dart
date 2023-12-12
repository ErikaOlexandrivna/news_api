import 'dart:convert';

import 'package:lesson_21_news_api/model/news_model.dart';
import 'package:http/http.dart' as http;

class NewsDataSource {
  Future<List<NewsModel>> fetchNews() async {
    print('=================================================Fetch');
    final response = await http.get(
      Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=c9602a7e3e2f4e30ad38d50c4691089f',
      ),
    );
    print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      /// Тіло відповіді, яке є у форматі JSON, декодується в об'єкт
      /// Dart за допомогою json.decode. Тепер data містить декодований

      if (data['articles'] != null) {
        return data['articles'].map<NewsModel>((e) => NewsModel.fromJson(e)).toList();

        /// - data['articles']: Це доступ до поля articles у відповіді JSON, яке міститься в
        ///змінній data. Поле articles це список, де кожен елемент - це об'єкт,
        /// який є однією статтею.

        /// - .map<NewsModel>((e) => NewsModel.fromJson(e)): Це використання методу map на цьому списку.
        /// Метод map використовується для перетворення кожного елемента списку з одного
        /// формату в інший. У цьому випадку, для кожного елемента e (який є JSON-об'єктом
        /// статті) викликається функція NewsModel.fromJson(e) - конструктор фабрики в класі
        /// NewsModel, який приймає JSON-об'єкт і створює з нього екземпляр NewsModel.
      } else {
        throw Exception('Error load news list');
      }
    } else {
      throw Exception('Error : ${response.reasonPhrase}');

      /// throw - це ключове слово в Dart, яке використовується для "кидання" або генерації
      /// винятку. Воно призначене для сигналізації про непередбачувані або проблемні
      /// ситуації у коді.

      /// Exception - це стандартний клас в Dart для винятків. Цей клас часто використовується
      /// для представлення загальних помилок.

      /// 'Error : ${response.reasonPhrase}' - це рядок повідомлення, який передається у
      /// конструктор Exception. Він описує конкретну проблему, яка сталася. У цьому випадку,
      /// повідомлення вказує на те, що завантаження статей не вдалося.
      /// ${response.reasonPhrase} - це шаблонний літерал, який вставляє причину помилки з
      /// об'єкта відповіді (response), щоб надати більше контексту про те, чому завантаження
      /// не вдалося.
    }
  }
}
