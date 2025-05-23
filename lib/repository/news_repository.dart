import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/model/category_news_model.dart';
import 'package:newsapp/model/news_headlines_model.dart';



class NewsRepository{
  Future <NewsHeadlinesModel?> fetchNewsHeadlinesApi(channelsName)async{
    String url = 'https://newsapi.org/v2/top-headlines?sources=${channelsName}&apiKey=e0a9e382ea2e441d94ab8bc327e14e66';

    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return NewsHeadlinesModel.fromJson(body);
    }
    throw Exception('error');
  }

  Future <CategoriesNewsModel?> fetchCategoryNewsApi(categoryName)async{
    String url = 'https://newsapi.org/v2/everything?q=${categoryName}&apiKey=e0a9e382ea2e441d94ab8bc327e14e66';

    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception('error');
  }


}