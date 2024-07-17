
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http_example/localDB.dart';
import 'package:http_example/pages/favScreen.dart';
import 'package:http_example/pages/login.dart';
import 'package:http_example/pages/postScreen.dart';
import 'package:http_example/services/api_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Localdb.prefs.setStringList("likes", ["1", "2"]);
        print(Localdb.prefs.getStringList("likes"));
      }),
      appBar: AppBar(
        title: Text("Hello ${Localdb.prefs.getString("name")}"),
        actions: [IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => FavPage(),));
        }, icon: Icon(Icons.favorite, color: Colors.red, size: 50,),),
        SizedBox(width: 10,),
        IconButton(onPressed: () async{
          Localdb.prefs.setBool("logedIn", false);
          Localdb.prefs.remove("name");
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen(),));
        }, icon: Icon(Icons.logout)),
        SizedBox(width: 20,)],
        ),
      body: Padding(padding: EdgeInsets.all(20), 
      child: FutureBuilder(
        future: ApiServices.getAllPosts(), 
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator(),);
          else if(snapshot.connectionState == ConnectionState.none) return Center(child: Text("Conection state is none"),);
          else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Postscreen(post: snapshot.data![index],fromFav: false,),));
                  },
                  child: Container(
                    margin: EdgeInsets.all(20),
                    color: Colors.amber,
                    child: ListTile(
                      leading: Text(snapshot.data![index].id.toString(), style: TextStyle(fontSize: 40),),
                      title: Text(snapshot.data![index].title, style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text(snapshot.data![index].body),
                      trailing: Text(snapshot.data![index].userId.toString(), style: TextStyle(fontSize: 20),),
                    ),
                  ),
                );
              },
              );
          }
        },
        ),
        ),
    );
  }
}