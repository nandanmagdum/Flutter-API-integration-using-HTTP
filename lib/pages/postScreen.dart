
import 'package:flutter/material.dart';
import 'package:http_example/localDB.dart';
import 'package:http_example/models/post_model.dart';
import 'package:http_example/pages/favScreen.dart';

class Postscreen extends StatefulWidget {
  final bool fromFav;
  final Post post;
  const Postscreen({super.key, required this.post, required this.fromFav});

  @override
  State<Postscreen> createState() => _PostscreenState();
}

class _PostscreenState extends State<Postscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          widget.fromFav ? Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => FavPage(),)) : Navigator.pop(context); 
        }, icon: Icon(Icons.arrow_back)),
        title: Text("Post"),),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Title: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text(widget.post.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  SizedBox(height: 20,),
                  Text("Body: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text(widget.post.body, style: TextStyle(fontSize: 16),),
                  SizedBox(height: 20,),
                  Text("Post ID", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  Text(widget.post.id.toString(), style: TextStyle(fontSize: 30)),
                  SizedBox(height: 20,),
                  Text("User ID", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  Text(widget.post.userId.toString(), style: TextStyle(fontSize: 30),),
                  SizedBox(height: 40,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.08,
                    width: MediaQuery.of(context).size.width*0.3,
                    child: ElevatedButton(onPressed: (){
                      // check if present 
                      List<String> likes = Localdb.prefs.getStringList("likes") ?? [];
                      if(likes.indexOf(widget.post.id.toString()) == -1){
                        likes.add(widget.post.id.toString());
                        Localdb.prefs.setStringList("likes", likes);
                      } else {
                        likes.remove(widget.post.id.toString());
                        Localdb.prefs.setStringList("likes", likes);
                      }
                      setState(() {
                      });
                    }, child: Icon(Icons.favorite, color: Localdb.prefs.getStringList("likes")!.indexOf(widget.post.id.toString()) == -1 ? Colors.black : Colors.red ),),
                  )
                ],
              ),
      ),
    );
  }
}