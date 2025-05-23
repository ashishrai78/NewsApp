import 'package:newsapp/model/category_news_model.dart';
import 'package:newsapp/model/news_headlines_model.dart';
import 'package:newsapp/repository/news_repository.dart';


class NewsViewModel{
  final _rep = NewsRepository();

  Future <NewsHeadlinesModel?> fetchNewsHeadlinesApi(channelsNews)async{
    final response = await _rep.fetchNewsHeadlinesApi(channelsNews);
    return response;
  }

  Future <CategoriesNewsModel?> fetchCategoryNewsApi(categoryName)async{
    final response = await _rep.fetchCategoryNewsApi(categoryName);
    return response;
  }


}