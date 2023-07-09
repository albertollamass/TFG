import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:football_club_app/controller/controlador.dart';
import 'package:football_club_app/model/gestion_monedero.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  

  @override
  Widget build(BuildContext context) {
   
    Widget buildOperacion(GestionMonedero operacion){
      if (operacion.cantidad > 0){
        return
          Column(
            children: [
              Row(
                children: [
                  Icon(Icons.payments, color: Colors.green[900], size: 40,),
                  const SizedBox(width: 20,),
                  const SizedBox(width:110, child: Text("INGRESO", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),),
                  const SizedBox(width: 70,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,                
                    children: [
                      Text("+ ${operacion.cantidad.toString()} €", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      const SizedBox(height: 5,),
                      Container(                    
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xff0AD905),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:const Center(child:  Text("DEPÓSITO", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20,)
            ],
          );
      } else {
        String mes = monthToString(operacion.fecha.month);
        return
          Column(
            children: [
              Row(
                children: [
                  Icon(Icons.payments, color: Colors.redAccent[700], size: 40,),
                  const SizedBox(width: 20,),
                  SizedBox(width:110, child: Text(mes.toUpperCase(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),),
                  const SizedBox(width: 70,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,                
                    children: [
                      Text("${operacion.cantidad.toString()} €", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      const SizedBox(height: 5,),
                      Container(                    
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xffC10707),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:const Center(child:  Text("PAGO", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20,)
            ],
          );
      }
    }

    final usuarioActivo = FirebaseAuth.instance.currentUser?.email;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
              "HISTORIAL",
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
          child: StreamBuilder<List<GestionMonedero>>(
            stream: leerPagosSocio(usuarioActivo.toString()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final operaciones = snapshot.data!;
                if (operaciones.isNotEmpty){
                  return ListView(
                  children: operaciones.map(buildOperacion).toList(),
                );
                } else {
                  return Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                        Icon(
                          Icons.payment,
                          size: 60,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(                                                    
                          "TODAVÍA NO SE HAN REALIZADO OPERACIONES",
                          style: TextStyle(                              
                              fontSize: 20, fontWeight: FontWeight.bold, ),
                          textAlign: TextAlign.center,
                        ),
                      ]));
                }
                
              } else {
                print(snapshot.toString());
                return const Center(child: CircularProgressIndicator(),);
              }
            },
          ),
        )
      )
    );
  }
}