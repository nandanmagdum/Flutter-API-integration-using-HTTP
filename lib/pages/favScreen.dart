import 'package:flutter/material.dart';
import 'package:http_example/localDB.dart';
import 'package:http_example/pages/postScreen.dart';
import 'package:http_example/services/api_services.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favourites"),),
      body: FutureBuilder(
        future: ApiServices.getFavourite(likes: Localdb.prefs.getStringList("likes") ?? []), 
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          else if(snapshot.connectionState == ConnectionState.none) return Center(child: Text("None case occured"));
          else if(snapshot.data!.isEmpty) return Text("No favs added");
          else {
            print(snapshot.data);
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Postscreen(post: snapshot.data![index], fromFav: true,),));
                  },
                  child: Container(
                    color: Colors.pink,
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.data![index].id.toString()),
                        SizedBox(height: 10,),
                        Text(snapshot.data![index].userId.toString()),
                        SizedBox(height: 10,),
                        Text(snapshot.data![index].title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Text(snapshot.data![index].body, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),),
                      ],
                    ),
                  ),
                );
              },
              );
          }
        },
        ),
    );
  }
}