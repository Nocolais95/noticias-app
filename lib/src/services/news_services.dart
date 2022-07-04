import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

import '../models/category_model.dart';

final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY = '4515eca48677477eb1f0649df295f5cf';

class NewsServices with ChangeNotifier {
  List<Article> headLines = [];

  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsServices() {
    this.getTopHeadLines();

    // Con esto inicializamos el mapeo de arriba
    categories.forEach((item) {
      this.categoryArticles[item.name] = [];
    });
  }

  String get selectedCategory => this._selectedCategory;
  set selectedCategory(String valor) {
    this._selectedCategory = valor;

    this.getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article> get getArticleCategorySelected =>
      categoryArticles[selectedCategory]!;

  getTopHeadLines() async {
    final url =
        Uri.parse('$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ar');

    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    this.headLines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.length > 0) {
      return categoryArticles[category];
    }
    final url = Uri.parse(
        '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ar&category=$category');

    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    categoryArticles[category]!.addAll(newsResponse.articles);
    notifyListeners();
  }
}
