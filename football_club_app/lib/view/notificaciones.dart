import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:football_club_app/view/notificacion_lectura.dart';
import '../controller/controlador.dart';

import '../custom_widgets/multi_select.dart';
import '../model/notificacion.dart';
import '../model/socio.dart';

class Notificaciones extends StatefulWidget {
  final bool esAdmin;
  Notificaciones(
      {Key? key,
      required this.esAdmin,
      required this.selectedItems,
      required this.emailSocios})
      : super(key: key);
  List<String> selectedItems = [], emailSocios = [];

  @override
  State<Notificaciones> createState() => _NotificacionesState();
}

class _NotificacionesState extends State<Notificaciones> {
  List<Socio> sociosOut = [];

  TextEditingController asuntoController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();

  Future showMultiSelect() async {
    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StreamBuilder<List<Socio>>(
          stream: leerSocios(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final socios = snapshot.data;
              List<String> nombreSocios = [];
              for (int i = 0; i < socios!.length; i++) {
                sociosOut.add(socios[i]);
                nombreSocios.add(socios[i].nombre.toString());
                // emailSocios.add(socios[i].email.toString());
              }

              return MultiSelect(items: nombreSocios);
            } else {
              return const CircularProgressIndicator();
            }
          },
        );
      },
    );

    if (results != null) {
      setState(() {
        widget.selectedItems = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final usuarioActivo = FirebaseAuth.instance.currentUser;

    Widget buildNotificacion(Notificacion notificacion) {
      return InkWell(
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
                "${notificacion.asunto}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                weekdayToString(notificacion.fechaEnvio?.weekday) +
                    " " +
                    notificacion.fechaEnvio?.day.toString() +
                    " " +
                    monthToString(notificacion.fechaEnvio?.month),
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ]),
            const SizedBox(
              width: 20,
            ),
            notificacion.leida
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
          var idNoti = ((notificacion.fechaEnvio?.microsecondsSinceEpoch)! / 1000).truncate();
          FirebaseFirestore.instance
              .collection('notificaciones')
              .doc(idNoti.toString()).update({
                'leida' : true
          });

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LecturaNotificacion(notificacion: notificacion)),
          );
        },
      );
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
                  content: const Text(
                      "¿Estás seguro de que quieres borrar todas las notificaciones?"),
                  actions: [
                    TextButton(
                      child: const Text(
                        "Borrar notificaciones",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        var si = FirebaseFirestore.instance
                          .collection('notificaciones')
                          .where("receptor", isEqualTo: usuarioActivo?.email.toString()).snapshots();

                        si.forEach((element) {
                          element.docs.forEach((element) {
                            FirebaseFirestore.instance
                          .collection('notificaciones').doc(element.id).delete();
                          });
                        });

                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Notificaciones(
                                    esAdmin: widget.esAdmin,
                                    emailSocios: [],
                                    selectedItems: [],
                                  )),
                        );
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
          child: StreamBuilder<List<Notificacion>>(
            stream: leerNotificacionesSocio(usuarioActivo!.email.toString()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final notificaciones = snapshot.data;
                return ListView(
                  children: notificaciones!.map(buildNotificacion).toList(),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error" + snapshot.hasError.toString()),
                );
              } else {
                return const Center(
                  child: Text("NO HAY NOTIFICACIONES"),
                );
              }
            },
          ),
        )),
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
                                children: widget.selectedItems
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
                                controller: asuntoController,
                                maxLines: 1,
                              ),
                              const Divider(
                                height: 20,
                              ),
                              const Text(
                                  "Escribe el mensaje de la notificacion:"),
                              TextFormField(
                                controller: descripcionController,
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
                            onPressed: () {
                              //selectedItems, asuntoController, descripcionController
                              widget.emailSocios.clear();
                              print(widget.selectedItems.toString() +
                                  "esta aqui " +
                                  widget.emailSocios.toString());
                              for (int i = 0; i < sociosOut.length; i++) {
                                for (int j = 0;
                                    j < widget.selectedItems.length;
                                    j++) {
                                  if (sociosOut[i].nombre ==
                                      widget.selectedItems[j]) {
                                    print("${sociosOut[i].nombre}\n");
                                    widget.emailSocios
                                        .add(sociosOut[i].email.toString());
                                  }
                                }
                              }
                              sociosOut.clear();
                              print(
                                  "${sociosOut.length} length socios pre env");
                              enviarNotificacion(
                                  asuntoController.text.trim(),
                                  descripcionController.text.trim(),
                                  widget.emailSocios);
                              setState(() {
                                widget.emailSocios = [];
                                widget.selectedItems = [];
                                asuntoController.text = "";
                                descripcionController.text = "";
                                sociosOut.clear();
                              });
                              Navigator.pop(context);
                            },
                          ),
                          TextButton(
                            child: const Text("Cancelar"),
                            onPressed: () => {
                              setState(() {
                                widget.emailSocios = [];
                                widget.selectedItems = [];
                                asuntoController.text = "";
                                descripcionController.text = "";
                                sociosOut.clear();
                              }),
                              print(widget.selectedItems.length),
                              Navigator.pop(context)
                            },
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
