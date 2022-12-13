import 'package:flutter/material.dart';
import 'package:receipe_app/models/receipe.api.dart';
import 'package:receipe_app/models/receipe.dart';
import 'package:receipe_app/views/widgets/receipe_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe> _receipe = [];
  bool isloading = true;

  @override
  void initState() {
    super.initState();
    getReceipe();
  }

  Future<void> getReceipe() async {
    _receipe = await ReceipeApi.getReceipe();
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.restaurant_menu),
            SizedBox(width: 10),
            Text('Food Receipe'),
          ]),
        ),
        body: isloading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _receipe.length,
                itemBuilder: (context, index) {
                  return RecipeCard(
                      title: _receipe[index].name,
                      cookTime: _receipe[index].totalTime,
                      rating: _receipe[index].rating.toString(),
                      thumbnailUrl: _receipe[index].images);
                },
              ));
  }
}
