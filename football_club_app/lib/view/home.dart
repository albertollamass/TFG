import 'package:flutter/material.dart';
import 'package:football_club_app/view/perfil.dart';
import 'package:football_club_app/view/saldo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
int previousIndex = -1;

class _HomeState extends State<Home> {
  int currentIndex = 0;
  bool hide = false;
  @override
  Widget build(BuildContext context) {
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
              body: currentPage(currentIndex, previousIndex), 
              appBar: !hide ? AppBar(                
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
                showUnselectedLabels: false,
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
                    activeIcon: Icon(Icons.shopping_cart, color: Colors.white),
                    icon: Icon(Icons.shopping_cart,
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
Widget buildPage(String text) => Center(
  child: Text(
    text,
    style: TextStyle (fontSize: 28),
  ),
);


currentPage(int index, int pIndex) {
  final screens = [null, Saldo(), Perfil()];
  if (index.compareTo(0) == 0){
    return TabBarView(children: [
        buildPage("Resumen"),
        buildPage("Partidos"),
        buildPage("Estadisticas")
      ],);
  } else {
    
    return screens[index];
  
  }
}
