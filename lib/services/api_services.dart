import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_example/models/post_model.dart';

class ApiServices {
  static const baseUrl = "https://jsonplaceholder.typicode.com/posts/";

  static Future<Post> getPostFromId({required String postId}) async {
    final URL = baseUrl + postId;
    final URI = Uri.parse(URL);
    final response = await http.get(URI);
    final data = jsonDecode(response.body);
    print(data);
    if(response.statusCode == 200)
    {
      print(data);
      return Post.fromJson(data);
    } else {
      throw Exception("${response.statusCode}, ${response.body}");
    }
  }

  static Future<List<Post>> getAllPosts() async {
    final URI = Uri.parse("https://jsonplaceholder.typicode.com/posts/");
    final response = await http.get(URI);
    final data = jsonDecode(response.body);
    if(response.statusCode != 200){
      print("${response.statusCode}");
      return [];
    }
    List<Map<String, dynamic>> mapList = [];
    for(int i=0 ; i < data.length; i++)
    {
      mapList.add({
        "userId": data[i]['userId'],
        "title": data[i]['title'],
        "body": data[i]['body'],
        "id": data[i]['id']
      });
    }
    List<Post> postList = mapList.map((e) => Post(id: e['id'] , title: e['title'], body: e['body'], userId: e['userId'])).toList();
    return postList;
  }

  static Future<List<Post>> getFavourite({required List<String> likes}) async{
    if(likes.length == 0) return [];
    else {
      List<Post> posts = [];
      for(int i=0; i<likes.length; i++)
      {
        final URL = "https://jsonplaceholder.typicode.com/posts/" + likes[i];
        final URI = Uri.parse(URL);
        final response = await http.get(URI);
        if(response.statusCode != 200){
          print("failed to load post ${likes[i]}");
        }
        final data = jsonDecode(response.body);
        final Post likedPost = Post.fromJson(data);
        posts.add(likedPost);
      }
      return posts;
    }
    
  }
 }