import 'package:flutter/material.dart';

import '../model/socio.dart';

class AdminPagos extends StatefulWidget {
  const AdminPagos({super.key});

  @override
  State<AdminPagos> createState() => _AdminPagosState();
}

class _AdminPagosState extends State<AdminPagos> {
  @override
  Widget build(BuildContext context) {
    List<Widget> pagosW = [];

    List<Socio> socios = [
      Socio("Pablo", "Perez", "pabloperez@gmail.com", 611611611, "pablo0_", 50),
      Socio("Juan", "Perez", "pabloperez@gmail.com", 611611611, "pablo0_", 10),
      Socio("Luis", "Perez", "pabloperez@gmail.com", 611611611, "pablo0_", -30),
      Socio(
          "Miguel", "Perez", "pabloperez@gmail.com", 611611611, "pablo0_", -20),
    ];

    for (int i = 0; i < socios.length; i++) {
      pagosW.add(Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 2, color: Colors.white)),
            child: const Icon(
              Icons.person_rounded,
              size: 30,
              color: Colors.white,
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 40,
            width: 190,
            child: Text(
              "${socios[i].nombre} ${socios[i].apellidos}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          socios[i].saldo! > 0
              ? Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff0AD905),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  height: 40,
                  width: 60,
                  child: Text(
                    "${socios[i].saldo} €",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffC10707),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  height: 40,
                  width: 60,
                  child: Text(
                    "${socios[i].saldo} €",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )
        ],
      ));
    }

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
                heroTag: "btnAdd",
                backgroundColor: const Color(0xff0AD905),
                onPressed: () {},
                child: const Icon(
                  Icons.payment,
                  size: 35,
                )),
            FloatingActionButton(
                heroTag: "btnDelete",
                backgroundColor: const Color(0xffC10707),
                onPressed: () {},
                child: const Icon(
                  Icons.delete,
                  size: 35,
                ))
          ],
        ),
        bottomNavigationBar: BottomAppBar(                
                color: const Color(0xffffffff),
                notchMargin: 5.0,
                shape: const CircularNotchedRectangle(),
                child: Container(height: 30),                
              ),
        appBar: AppBar(
          title: const Text(
            "GESTIONAR PAGOS",
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
        )));
  }
}
