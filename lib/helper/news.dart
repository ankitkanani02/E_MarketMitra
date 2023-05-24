import 'dart:convert';
import 'package:emmitra/models/artical_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = <ArticleModel>[];

  Future getNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=b0f3fcdbc9354b88a9f43b1834fbb455";

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
              author: (element["author"] == null) ? " " : element['author'],
              title: element["title"],
              description: element["description"],
              publshedAt: DateTime.parse(element['publishedAt']),
              url: element["url"],
              urlToImage: element["urlToImage"],
              content: (element["content"] == null) ? " " : element['content']);

          news.add(articleModel);
        }
      });
    }
  }
}

class NewsForCategorie {
  List<ArticleModel> newsCat = [];

  Future<void> getNewsForCategory(String category) async {
    /*String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";*/
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=b0f3fcdbc9354b88a9f43b1834fbb455";

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel article = ArticleModel(
            title: element['title'],
            author: (element["author"] == null) ? " " : element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: (element["content"] == null) ? " " : element['content'],
            url: element["url"],
          );
          newsCat.add(article);
        }
      });
    }
  }
}
