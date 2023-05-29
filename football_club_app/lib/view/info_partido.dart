import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InfoPartido extends StatefulWidget {
  final DateTime fecha;
  final Map<String, int> resultado;

  const InfoPartido({Key? key, required this.fecha, required this.resultado})
      : super(key: key);

  @override
  State<InfoPartido> createState() => _InfoPartidoState();
}

class _InfoPartidoState extends State<InfoPartido> {
  @override
  Widget build(BuildContext context) {
    const tabBarStyle = TextStyle(fontSize: 20);
    return Stack(
      children: [
        DefaultTabController(
            length: 2,
            child: Scaffold(
              floatingActionButton: SizedBox(                
                width: 70,
                height: 70,
                child: FittedBox(
                  child: FloatingActionButton(
                    backgroundColor: const Color(0xaa2B4EA1),
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    child: const Icon(
                      Icons.home,
                      size: 40,
                    ),
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,              
              appBar: AppBar(
                toolbarHeight: 180,
                automaticallyImplyLeading: false,
                centerTitle: true,
                bottom: const TabBar(
                    isScrollable: false,
                    indicatorColor: Colors.white,
                    indicatorWeight: 5,                    
                    tabs: [
                      Tab(
                          child: Text(
                        "RESUMEN",
                        style: tabBarStyle,
                      )),
                      Tab(
                          child: Text(
                        "HIGHLIGHTS",
                        style: tabBarStyle,
                      )),
                    ]),
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          margin: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                          padding: const EdgeInsets.all(40),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(100),
                              border:
                                  Border.all(width: 2, color: Colors.white))),
                      Text(
                        widget.resultado["negro"].toString(),
                        style: const TextStyle(fontSize: 45),
                      ),
                      const Text(" - ", style: TextStyle(fontSize: 45)),
                      Text(widget.resultado["blanco"].toString(),
                          style: const TextStyle(fontSize: 45)),
                      Container(
                          margin: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                          padding: const EdgeInsets.all(40),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border:
                                  Border.all(width: 1, color: Colors.black))),
                    ]),
              ),
              bottomNavigationBar: BottomAppBar(
                color: const Color(0xff2B4EA1),
                notchMargin: 5.0,
                shape: const CircularNotchedRectangle(),
                child: Container(height: 30),                
              ),
              backgroundColor: const Color(0xffd2d2d2),
              body: TabBarView(
                children: [
                  Center(child: Text('Que'),),
                  Center(child: Text('Que2'),),
                ],
              )
            ))
      ],
    );
  }
}

currentPage(int index, int pIndex) {

}
