import 'package:flutter/material.dart';
import 'package:football_club_app/view/history.dart';

class Saldo extends StatefulWidget {
  const Saldo({super.key});

  @override
  State<Saldo> createState() => _SaldoState();
}

class _SaldoState extends State<Saldo> {
  int saldo = -10;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xff2B4EA1),
          Colors.white,
        ],
      ))),
      Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text(
              "MONEDERO",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.history, size: 29),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => History()),
            );
                },
              ),
            ],
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child: Container(

              padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // const Text("SALDO", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                  // const SizedBox(height: 30),
                  saldo >= 0 ? Text("$saldo €", style: const TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),):
                  Text("$saldo €", style: const TextStyle(color: Colors.red, fontSize: 50, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 30),
                  Container(
                    height: 221,
                    width: 370,                    
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 240, 240, 240),
                    ),
                    child: Column(
                      children:  [
                        const SizedBox(height: 10),   
                        saldo >= 0 ?                     
                        const Icon(Icons.check_circle, size: 100, color: Colors.green)
                        : const Icon(Icons.error_rounded, size: 100, color: Colors.red,),
                        const SizedBox(height: 30),
                        saldo >= 0 ?
                        const Text("TODO PAGADO", style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.w600),)
                        : const Text("DEBES DINERO", style: TextStyle(color: Colors.red, fontSize: 40, fontWeight: FontWeight.w600),)
                      ]
                    ),
                  )
                ],
              ),
            ),
          )),
    ]);
  }
}
