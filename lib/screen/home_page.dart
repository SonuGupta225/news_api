import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_api/model/news_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//  data ka timeing fixed nhi hai ess liye future function use karenge

  Future<NewsModel> fetchNews() async {
    final url =
        "https://newsapi.org/v2/everything?q=tesla&from=2024-07-27&sortBy=publishedAt&apiKey=e8912ed4cd304d189b75c7b72a2084de";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return NewsModel.fromJson(result);
    } else {
      return NewsModel();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Api'),
      ),
      body: FutureBuilder(
        future: fetchNews(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data!.articles!.length,
            itemBuilder: (context, index) {
              return ListTile(
                // leading: CircleAvatar(
                //   backgroundImage: NetworkImage(
                //       "${snapshot.data!.articles![index].urlToImage}"),
                // ),
                title: Text("${snapshot.data!.articles![index].title}"),
                subtitle:
                    Text("${snapshot.data!.articles![index].description}"),
              );
            },
          );
        },
      ),
    );
  }
}
