import 'package:flutter/material.dart';


class CustomButtomWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? titleSize;
  final bool disable;
  const CustomButtomWidget({super.key, required this.onPressed, required this. title,  this.disable = false,  this.titleSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disable  ? null : onPressed,
     child: Text(title, style: TextStyle(color: Colors.white),), 
     style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if(states.contains(WidgetState.disabled)) return Colors.purple;
        if(states.contains(WidgetState.pressed)) return Colors.blue;
        return Colors.black;
        
      } ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
      ), 
      textStyle: WidgetStateProperty.resolveWith((states){
        return TextStyle(fontSize:titleSize);
      }),
     ),
    );
  }
}