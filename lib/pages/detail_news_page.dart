import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lesson_21_news_api/model/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailNewsPage extends StatelessWidget {
  final NewsModel news;

  const DetailNewsPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(
              news.urlToImage!,
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 10),
            Text(
              news.title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            Text(news.content ?? ''),
            const SizedBox(height: 10),
            Text(
              DateFormat('dd-MM-yyyy').format(
                DateTime.parse(news.publishedAt),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => openUrl(news.url),
              child: Text(news.url),
            ),
          ],
        ),
      ),
    );
  }

  void openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    await launchUrl(uri);
  }
}
