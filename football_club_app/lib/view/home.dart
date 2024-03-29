import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:football_club_app/view/estadisticas.dart';
import 'package:football_club_app/view/partidos.dart';
import 'package:football_club_app/view/perfil.dart';
import 'package:football_club_app/view/resumen.dart';
import 'package:football_club_app/view/saldo.dart';

import '../model/socio.dart';

class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
int previousIndex = -1;

class _HomeState extends State<Home> {
  int currentIndex = 0;
  bool hide = false;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    Socio socio = Socio(
      nombre: "Pablo",
      apellidos: "Perez",
      email: "pabloperez@gmail.com",
      telefono: 611611611,
      password: "pablo0_",
      saldo: 50,
      alias: "Pablito",
      esAdmin: true);    
    const tabBarStyle = TextStyle(fontSize: 20);
    return Stack(
      children: [
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
        DefaultTabController(
            length: 3,
            child: Scaffold(
              body: currentPage(currentIndex, previousIndex, socio), 
              appBar: !hide ? AppBar( 
                centerTitle: true,               
                bottom: const TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.white,
                  indicatorWeight: 5,
                  tabs: [
                    Tab(child: Text("RESUMEN", style:tabBarStyle,)),
                    Tab(child: Text("PARTIDOS", style: tabBarStyle,)),
                    Tab(child: Text("ESTADISTICAS", style: tabBarStyle,))
                  ]
                ),
                title: const Text(
                  "PEÑA LOS PAJARITOS",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                automaticallyImplyLeading: false,
              ): null,
              backgroundColor: Colors.transparent,
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: const Color(0xff2B4EA1),
                currentIndex: currentIndex,
                unselectedItemColor: const Color.fromARGB(140, 255, 255, 255),
                showUnselectedLabels: true,
                showSelectedLabels: true,
                onTap: (int index) {
                  setState(() {
                    currentIndex = index;
                    if (currentIndex > 0){
                      hide = true;
                    } else {
                      hide = false;
                    }
                  });
                },
                iconSize: 40,
                selectedItemColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                    activeIcon: Icon(Icons.home, color: Colors.white),
                    icon: Icon(Icons.home,
                        color: Color.fromARGB(140, 255, 255, 255)),
                    label: 'Home',
                    backgroundColor:  Color(0xff2B4EA1),
                  ),
                  BottomNavigationBarItem(
                    activeIcon: Icon(Icons.euro_rounded, color: Colors.white),
                    icon: Icon(Icons.euro_rounded,
                        color: Color.fromARGB(140, 255, 255, 255)),
                    label: 'Saldo',
                    backgroundColor:  Color(0xff2B4EA1),
                  ),
                  BottomNavigationBarItem(
                      activeIcon: Icon(Icons.person, color: Colors.white),
                      icon: Icon(Icons.person,
                          color: Color.fromARGB(140, 255, 255, 255)),
                      label: 'Perfil',
                      backgroundColor:  Color(0xff2B4EA1)),
                ],
              ),
            )
          )
      ],
    );
  }
}

currentPage(int index, int pIndex, Socio socio) {
  final screens = [null, const Saldo(), Perfil(socio: socio,)];
  if (index.compareTo(0) == 0){
    return const TabBarView(children: [
        Resumen(),
        Partidos(),
        EstadisticasW(),
      ],);
  } else {
    
    return screens[index];
  
  }
}
