import 'package:flutter/material.dart';
import 'package:football_club_app/view/notificacion_lectura.dart';
import 'package:football_club_app/view/resumen.dart';

import '../custom_widgets/multi_select.dart';
import '../model/notificacion.dart';
import '../model/socio.dart';

class Notificaciones extends StatefulWidget {
  final bool esAdmin;
  const Notificaciones({Key? key, required this.esAdmin}) : super(key: key);

  @override
  State<Notificaciones> createState() => _NotificacionesState();
}

class _NotificacionesState extends State<Notificaciones> {
  List<Notificacion> notificaciones = [
    Notificacion("Prueba de descripción", "Juan", DateTime.now()),
    Notificacion("Prueba de descripción", "Pepe", DateTime.now())
  ];

  List<String> selectedItems = [];

  void showMultiSelect() async {
    List<Socio> socios = [
      Socio(nombre:"Pablo",apellidos:  "Perez",email:  "pabloperez@gmail.com",telefono:  611611611, password: "pablo0_",saldo: 50, alias: "Pablito", esAdmin: true)
    ];
    List<String> nombreSocios = [];
    
    for (int i = 0; i < socios.length; i++) {
      nombreSocios.add(socios[i].nombre.toString());
    }
    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: nombreSocios);
      },
    );

    if (results != null) {
      setState(() {
        selectedItems = results;
      });
    }
  }

  // Notificacion n1 = Notificacion("Prueba de descripción", "Juan", DateTime.now());
  // Notificacion n2 = Notificacion("Prueba de descripción", "Pepe", DateTime.now());
  @override
  Widget build(BuildContext context) {
    List<Widget> notificacionesW = [];

    for (int i = 0; i < notificaciones.length; i++) {
      notificacionesW.add(InkWell(
        child: Row(
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
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "${notificaciones[i].emisor}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                weekdayToString(notificaciones[i].fechaEnvio?.weekday) +
                    " " +
                    notificaciones[i].fechaEnvio?.day.toString() +
                    " " +
                    monthToString(notificaciones[i].fechaEnvio?.month),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ]),
            const SizedBox(
              width: 20,
            ),
            notificaciones[i].leida
                ? Container(
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xff0AD905),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                        child: Text(
                      "LEIDA",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  )
                : Container(
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xffC10707),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                        child: Text(
                      "NO LEIDA",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  )
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LecturaNotificacion(notificacion: notificaciones[i])),
          );
        },
      ));
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "NOTIFICACIONES",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.delete_forever, size: 29),
              onPressed: () {
                AlertDialog alert = AlertDialog(
                  title: const Text("Borrar notificaciones"),
                  content:
                      const Text("¿Estás seguro de que quieres borrar todas las notificaciones?"),
                  actions: [
                    TextButton(
                      child: const Text(
                        "Borrar notificaciones",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  Notificaciones(esAdmin: widget.esAdmin,)),
                        )
                      },
                    ),
                    TextButton(
                      child: const Text("Cancelar"),
                      onPressed: () => {Navigator.pop(context)},
                    )
                  ],
                );
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    });
              },
            ),
          ],
        ),
        backgroundColor: const Color(0xff2B4EA1),
        body: Center(
            child: Container(
                height: 780,
                width: 370,
                padding: const EdgeInsets.fromLTRB(15, 20, 20, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffffffff),
                ),
                child: ListView(
                  children: notificacionesW,
                ))),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: widget.esAdmin
            ? SizedBox(
                width: 70,
                height: 70,
                child: FittedBox(
                  alignment: Alignment.center,
                  child: FloatingActionButton(
                    backgroundColor: const Color.fromARGB(255, 130, 167, 254),
                    onPressed: (() {
                      AlertDialog alert = AlertDialog(
                        title: const Text("Enviar notificacion"),
                        content: SizedBox(
                          height: 400,
                          child: Column(
                            children: [
                              ElevatedButton(
                                  onPressed: showMultiSelect,
                                  child: const Text("Selecciona socio")),
                              const Divider(
                                height: 30,
                              ),
                              // display selected items
                              Wrap(
                                children: selectedItems
                                    .map((e) => Chip(
                                          label: Text(e),
                                        ))
                                    .toList(),
                              ),
                              const Divider(
                                height: 30,
                              ),
                              const Text(
                                  "Escribe el asunto de la notificacion:"),
                              TextFormField(
                                maxLines: 1,
                              ),
                              const Divider(
                                height: 20,
                              ),
                              const Text(
                                  "Escribe el mensaje de la notificacion:"),
                              TextFormField(
                                maxLines: 5,
                              )
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: const Text(
                              "Enviar notificacion",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Notificaciones(
                                          esAdmin: true,
                                        )),
                              )
                            },
                          ),
                          TextButton(
                            child: const Text("Cancelar"),
                            onPressed: () => {Navigator.pop(context)},
                          )
                        ],
                      );
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          });
                    }),
                    child: const Icon(
                      Icons.add,
                      size: 40,
                    ),
                  ),
                ),
              )
            : const SizedBox());
  }
}
