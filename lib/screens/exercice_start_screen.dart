import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:new_project/screens/exercice_hub.dart';
import 'package:new_project/screens/exercice_screen.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class ExerciceStartScreen extends StatefulWidget {

  final Exercises exercises;
  //constructor
  ExerciceStartScreen ({this.exercises});



  @override
  _ExerciceStartScreenState createState() => _ExerciceStartScreenState();
}

class _ExerciceStartScreenState extends State<ExerciceStartScreen> {

  int seconds=10;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
              child: Stack(
                children: <Widget>[
                  CachedNetworkImage(
            imageUrl: widget.exercises.thumbnail,
            placeholder: (context,url)=>Image(
            image: NetworkImage(widget.exercises.thumbnail),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,),
          errorWidget:(context,url,error)=>Icon(Icons.error),
          fit:BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,),
           

        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient:LinearGradient(
              colors:[Color (0xff000000),Color(0x00000000),],
              begin:Alignment.bottomCenter,
              end: Alignment.center,
            ),
          ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Container(
              height: 200,
              width: 200,
              child: SleekCircularSlider(
                appearance: CircularSliderAppearance(),
                onChange:(double value){
                  seconds=value.toInt();
                  //print(value);
                },
                initialValue:30,
                min:10,
                max:60,
                innerWidget:(v){
                  return Container (
                    alignment: Alignment.center,
                    child: Text(
                      "${v.toInt()} S",
                      style: TextStyle(
                        color:Colors.white,
                        fontSize:20,
                      ),),
                  );
                }
              ),
            ),),
            Container(
              alignment:Alignment.center,
              child:RaisedButton(
                 onPressed:(){
                   Navigator.push(
                     context, 
                     MaterialPageRoute(builder: (context)=>ExerciseScreen(
                       exercises: widget.exercises,
                       seconds: seconds,
                     )));
                 },
                 child: Text("Start Exercices",style: TextStyle(fontSize:20,),),
                 color: Color(0xffe83350),
                 textColor: Colors.white,
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                 splashColor:Colors.black,
                 ),
                 
            )   

                ],
          
        ),
      ),
      
    );
    
  }
}