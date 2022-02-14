import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yolo/front/widgets/Blog.dart';

class RecipeApi {
  static Future<List<Blog>> getRecipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "18", "start": "0", "tag": "list.Blog.popular"});

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": "YOUR API KEY FROM YUMMLY API",
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "useQueryString": "true"
    });

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['feed']) {
      _temp.add(i['content']['details']);
    }

    return Blog.recipesFromSnapshot(_temp);
  }
}