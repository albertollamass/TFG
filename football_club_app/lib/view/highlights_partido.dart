import 'dart:ui';

import 'package:flutter/material.dart';

class HighlightsPartido extends StatefulWidget {
  final Map<String, int> resultado;
  const HighlightsPartido({Key? key, required this.resultado}) : super(key: key);

  @override
  State<HighlightsPartido> createState() => _HighlightsPartidoState();
}

class _HighlightsPartidoState extends State<HighlightsPartido> {

  List goles = [
    // {1: {"negro": "Juanjo"}}
  ];
  

  @override
  Widget build(BuildContext context) { 

    List<Widget> golesW = [];
    if (goles.isNotEmpty){
      for (int i = 0; i < goles.length; i++) {
        
        golesW.add(const Text("data"));
      }

    } else {
      golesW.add(
        Center(          
          child: Column(            
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,            
            children: [
              const SizedBox(height: 150,),
              const Icon(Icons.sports_soccer, size: 100,),
              const SizedBox(height: 10,),
              Text("No ha habido goles en este partido!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.purple[900]),)
          ]) ,
        )
      );
    }

    return ListView(

      children: golesW,
    );
  }
}