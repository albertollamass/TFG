import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:football_club_app/model/partido.dart';
import 'package:football_club_app/view/highlights_partido.dart';
import 'package:football_club_app/view/resumen_partido.dart';

class InfoPartido extends StatefulWidget {
  Partido partido;
  final bool esAdmin;

  InfoPartido(
      {Key? key,
      required this.partido,
      this.esAdmin = false})
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
            length: 1,
            child: Scaffold(
                // floatingActionButton: SizedBox(
                //   width: 70,
                //   height: 70,
                //   child: FittedBox(
                //     child: FloatingActionButton(
                //       backgroundColor: const Color(0xaa2B4EA1),
                //       onPressed: (() {
                //         Navigator.pop(context);
                //       }),
                //       child: const Icon(
                //         Icons.home,
                //         size: 40,
                //       ),
                //     ),
                //   ),
                // ),
                // floatingActionButtonLocation:
                //     FloatingActionButtonLocation.centerDocked,
                appBar: AppBar(
                  automaticallyImplyLeading: true,                  
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
                        // Tab(
                        //     child: Text(
                        //   "HIGHLIGHTS",
                        //   style: tabBarStyle,
                        // )),
                      ]),
                  title: widget.esAdmin
                      ? const Text("EDITAR RESULTADO",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25))
                      : const Text("RESULTADO",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25)),
                ),
                // bottomNavigationBar: BottomAppBar(
                //   color: const Color(0xff2B4EA1),
                //   notchMargin: 5.0,
                //   shape: const CircularNotchedRectangle(),
                //   child: Container(height: 30),
                // ),
                backgroundColor: const Color(0xffd2d2d2),
                body: TabBarView(
                  children: [
                    ResumenPartido(                      
                      esAdmin: widget.esAdmin,
                      partido: widget.partido,
                    ),
                    //HighlightsPartido(resultado: widget.resultado,),
                  ],
                )))
      ],
    );
  }
}
