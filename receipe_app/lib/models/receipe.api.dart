import 'dart:convert';
import './receipe.dart';
import 'package:http/http.dart' as http;

class ReceipeApi {
  static Future<List<Recipe>> getReceipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/auto-complete',
        {"limit": "24", "start": "0"});

    final response = await http.get(uri, headers: {
      "X-RapidAPI-Key": "1a8d6f01b7msh6d2e92cc814c877p1e8a38jsndcd5dfef03e6",
      "X-RapidAPI-Host": "yummly2.p.rapidapi.com",
      "useQueryString": "true"
    });

    Map data = jsonDecode(response.body);
    List _temp = [];
    for (var i in data['feed']) {
      _temp.add(i['content']['details']);
    }

    return Recipe.recipesFromSnapshot(_temp);
  }
}
