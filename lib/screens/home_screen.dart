import 'package:flutter/material.dart';
import 'package:new_project/screens/exercice_hub.dart';
import 'package:http/http.dart' as http; // to load data from http
import'dart:convert';

import 'package:new_project/screens/exercice_start_screen.dart';//to decode data

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String apiURL ="https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json" ;
  ExerciceHub exerciceHub ;

  @override
  void initState(){
   
      getExercices();
   
    super.initState();
  }

  void getExercices() async{

    var response = await http.get(apiURL);
    var body=response.body;
    var decodedJson= jsonDecode(body);
   // print(decodedJson);
    exerciceHub= ExerciceHub.fromJson(decodedJson); //json to object
    setState(() {
      
    });
    
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Exercices : "),),
      
      body:Container(
        child: exerciceHub != null 
              ?ListView(
                children: exerciceHub.exercises.map((e) { //e : element de la liste
                      return InkWell(
                        onTap:() {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context)=>ExerciceStartScreen(exercises: e,)));
                        },
                        child: Hero(
                          tag: e.id, // identifiant
                          child: Container( 
                            //  child:Text("hello"),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),),
                              child:Stack(
                                children: <Widget>[
                                  
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child :FadeInImage(
                                      image: NetworkImage(e.thumbnail),   
                                    //image: NetworkImage(exerciceHub.exercises[index].thumbnail),
                                      placeholder: AssetImage("assets/placeholder.jpg"),
                                      width: MediaQuery.of(context).size.width,
                                      height: 250,
                                      fit: BoxFit.cover,
                                  )                    
                                  ),

                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 250,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors:[Color(0xFF000000),Color(0x00000000)] ,
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.center
                                          )
                                        )
                                    ),
                                  ),
                                  Container(
                                    height:250,
                                    padding: EdgeInsets.only(left :10, bottom:10,),
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      e.title,
                                      style: TextStyle(
                                        fontSize:18,
                                        color:Colors.white,
                                      ) ,
                                    ),

                                  )
                                ],
                              )
                                  
                          ),
                        ),
                      );
                }).toList(),
                //itemCount: exerciceHub.exercises.length,
                )
              : LinearProgressIndicator(),
      ),
      
      
    );
  }
}