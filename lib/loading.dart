// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Loading extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     return Container(
       color: Colors.white,
       child: Center(
         child: SpinKitChasingDots(
           color: Colors.lightBlueAccent[700],
           size: 50.0,
         ),
       ),
     );
  }

}

SpinKitChasingDots({Color? color, required double size}) {
}