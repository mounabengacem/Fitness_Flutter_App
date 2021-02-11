import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:new_project/screens/exercice_hub.dart';

import 'dart:async';

class ExerciseScreen extends StatefulWidget {

  final Exercises exercises ;
  final int seconds;
  ExerciseScreen ({this.exercises,this.seconds});

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {

  bool _isCompleted = false;
  int _elapsedseconds =0;
  AudioPlayer audioPlayer=AudioPlayer();
  AudioCache audioCache=AudioCache();

  Timer timer;
  @override
  void initState(){
    timer=Timer.periodic(
         Duration(seconds: 1), 
        (t){
           if (t.tick==widget.seconds) {
             t.cancel();
             setState(() {
             _isCompleted=true;
             });
              playAudio();}
           setState(() {
           _elapsedseconds=t.tick;
         });
      });
    super.initState();  
  }

 void playAudio(){
   audioCache.play("cheering.wav");
 }


  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          Center(
            child: CachedNetworkImage(
                imageUrl: widget.exercises.gif,
                placeholder: (context,url)=>Image(
                image: NetworkImage(widget.exercises.thumbnail),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,),
              errorWidget:(context,url,error)=>Icon(Icons.error),
              fit:BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              ),),

          _isCompleted !=true 
          ?SafeArea(child: Container(
            alignment: Alignment.topCenter,
            child: Text("$_elapsedseconds/${widget.seconds} S"),
          ),)  
          :Container() ,

          SafeArea(
            child: IconButton (
              icon: Icon(Icons.close),
              onPressed: (){
                Navigator.of(context).pop();
              },))
        ],
      )

      
    );
  }
}