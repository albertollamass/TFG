import 'package:flutter/material.dart';

class Resumen extends StatefulWidget {
  const Resumen({super.key});

  @override
  State<Resumen> createState() => _ResumenState();
}

class _ResumenState extends State<Resumen> {
  final hoy = DateTime.now();
  var resultado = {"negro": 1, "blanco": 0};
  var jugadores = ["Rafa", "Jose", "Juanjo", "Nene", "Sam", "Joseles", "Antonio", "Joaquin", "M.Pardo", "Sergio", "Francis", "Victor"];  
  @override
  Widget build(BuildContext context) {
     List<Widget> mywidgets = [];
     mywidgets.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text("Pos", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
          Text("Jugador", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
          Text("PJ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
          Text("PG", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
          Text("PE", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
          Text("PP", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),              
        ])
     );
    for(int x = 0; x<jugadores.length;x++){
        mywidgets.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,            
            children: [
              Text((x+1).toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                  Text(jugadores[x], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),                  
                  Text(3.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                  Text(3.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                  Text(3.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                  Text(3.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),), 
            ],)
        );
    }
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        //ULTIMO PARTIDO
        Container(
          width: 380,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(10),
          child: Text(
            _weekdayToString(hoy.weekday) +
                " " +
                hoy.day.toString() +
                " " +
                _monthToString(hoy.month),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          decoration: const BoxDecoration(
            color: Color(0xffC1C2C6),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
        ),
        Container(
          width: 380,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Color(0xffE0DEE4),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            Container(
                margin: EdgeInsets.fromLTRB(40, 10, 20, 10),
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 2, color: Colors.white))),
            
            Text(resultado["negro"].toString(), style: TextStyle(fontSize: 35),),
            const Text(" - ", style: TextStyle(fontSize: 35)),
            Text(resultado["blanco"].toString(), style: TextStyle(fontSize: 35)),

            Container(
                margin: EdgeInsets.fromLTRB(20, 10, 40, 10),
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 1, color: Colors.black))),
          
          ]),
        ),
        SizedBox(height: 40,),
        //CLASIFICACION
        Container(
          width: 380,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Color(0xffC1C2C6),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          child: const Text(
            "CLASIFICACION",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
        ),
        Container(
          width: 380,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Color(0xffE0DEE4),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          child: Column(
             children: mywidgets
             //[
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: const [
          //         Text("Pos", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
          //         Text("Jugador", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
          //         Text("PJ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
          //         Text("PG", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
          //         Text("PE", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
          //         Text("PP", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),              
          //       ]),                                
          // ]
          )

          )
      ],
    );
  }
}

_weekdayToString(int weekday) {
  if (weekday == 1) {
    return "Lunes";
  } else if (weekday == 2) {
    return "Martes";
  } else if (weekday == 3) {
    return "Miércoles";
  } else if (weekday == 4) {
    return "Jueves";
  } else if (weekday == 5) {
    return "Viernes";
  } else if (weekday == 6) {
    return "Sábado";
  } else {
    return "Domingo";
  }
}

_monthToString(int month) {
  if (month == 1) {
    return "Enero";
  } else if (month == 2) {
    return "Febrero";
  } else if (month == 3) {
    return "Marzo";
  } else if (month == 4) {
    return "Abril";
  } else if (month == 5) {
    return "Mayo";
  } else if (month == 6) {
    return "Junio";
  } else if (month == 7) {
    return "Julio";
  } else if (month == 8) {
    return "Agosto";
  } else if (month == 9) {
    return "Septiembre";
  } else if (month == 10) {
    return "Octubre";
  } else if (month == 11) {
    return "Noviembre";
  } else {
    return "Diciembre";
  }
}
