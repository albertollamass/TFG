import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  Map<String, int> pagos = {
    "enero": -20,
    "ingreso": 40,
    "diciembre": -10,
  };

  @override
  Widget build(BuildContext context) {
    List<Widget> pagosW = [];

    for (int i = 0; i < pagos.length; i++) {
      if (pagos.values.elementAt(i) > 0){
        pagosW.add(
          Row(
            children: [
              Icon(Icons.payments, color: Colors.green[900], size: 40,),
              const SizedBox(width: 20,),
              SizedBox(width:110, child: Text(pagos.keys.elementAt(i).toUpperCase(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
              const SizedBox(width: 70,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,                
                children: [
                  Text("+ ${pagos.values.elementAt(i).toString()} €", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 5,),
                  Container(                    
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Color(0xff0AD905),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:const Center(child:  Text("DEPÓSITO", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                  )
                ],
              )
            ],
          )
        );
      } else {
        pagosW.add(
          Row(
            children: [
              Icon(Icons.payments, color: Colors.redAccent[700], size: 40,),
              const SizedBox(width: 20,),
              SizedBox(width:110, child: Text(pagos.keys.elementAt(i).toUpperCase(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
              const SizedBox(width: 70,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,                
                children: [
                  Text("${pagos.values.elementAt(i).toString()} €", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 5,),
                  Container(                    
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Color(0xffC10707),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:const Center(child:  Text("PAGO", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                  )
                ],
              )
            ],
          )
        );
      }
      pagosW.add(const SizedBox(height: 20,));
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text(
              "HISTORIAL DE PAGOS",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            centerTitle: true,
            elevation: 0,
      ),
      backgroundColor: const Color(0xff2B4EA1),
      body: Center(
        child: Container(
          height: 780,
          width: 370,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffffffff),
          ),
          child: ListView(
            children: pagosW,
          ),
        )
      )
    );
  }
}