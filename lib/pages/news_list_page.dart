import 'package:flutter/material.dart';
import 'package:lesson_21_news_api/data_source/news_data_source.dart';
import 'package:lesson_21_news_api/model/news_model.dart';
import 'package:lesson_21_news_api/pages/detail_news_page.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  final NewsDataSource newsDataSource = NewsDataSource();

  /// Тут створюється екземпляр класу NewsDataSource.

  late Future<List<NewsModel>> futureNews;

  /// Це оголошення змінної futureNews, яка буде містити об'єкт Future,
  /// що повертає список новин (List<NewsModel>). Ключове слово late вказує,
  /// що ініціалізація цієї змінної відбудеться пізніше, а не в момент
  /// створення екземпляра класу.

  @override
  void initState() {
    super.initState();
    futureNews = newsDataSource.fetchNews();

    /// Тут futureNews ініціалізується результатом виклику fetchNews() від
    /// об'єкта newsDataSource. Це означає, що в futureNews буде зберігатися
    /// Future, який в результаті поверне список новин (List<NewsModel>),
    /// коли операція завантаження завершиться.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: FutureBuilder(
        /// FutureBuilder будує віджет в залежності від результату Future.
        future: futureNews,
        builder: (context, snapshot) {
          /// builder: (context, snapshot) -  функція, яка будує віджет на основі поточного стану Future.
          /// Вона приймає два параметри: context (контекст віджета) та snapshot
          /// (знімок поточного стану Future).

          if (snapshot.connectionState == ConnectionState.waiting) {
            /// Тут ми перевіряємо стан з'єднання знімка (snapshot). Якщо connectionState
            /// дорівнює ConnectionState.waiting, це означає, що Future ще не завершений
            /// і ми чекаємо його результату.

            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error, sorry!'),
            );
          } else if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('List is Empty'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final NewsModel news = snapshot.data![index];
                return InkWell(
                  splashColor: Colors.yellow,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailNewsPage(news: news),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.transparent,
                    margin: const EdgeInsets.all(10),
                    elevation: 7,
                    child: Column(
                      children: [
                        Image.network(
                          news.urlToImage!,
                          errorBuilder:
                              (BuildContext context, Object exception, StackTrace? stackTrace) {
                            return const SizedBox.shrink();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            news.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        if (news.description != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(news.description!),
                          )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
