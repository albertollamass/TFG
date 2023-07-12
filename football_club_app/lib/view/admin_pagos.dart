import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:football_club_app/controller/controlador.dart';
import 'package:football_club_app/custom_widgets/multi_select.dart';
import 'package:football_club_app/model/gestion_monedero.dart';

import '../model/socio.dart';

class AdminPagos extends StatefulWidget {
  const AdminPagos({super.key});

  @override
  State<AdminPagos> createState() => _AdminPagosState();
}

class _AdminPagosState extends State<AdminPagos> {
  List<String> selectedItems = [], emailSocios = [];
  List<Socio> sociosOut = [];
  @override
  Widget build(BuildContext context) {
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

                // Map<List<String>, List<String>> items = {nombreSocios: emailSocios};

                return MultiSelect(items: nombreSocios);
              } else {
                print("nodata");
                return const Text("e");
              }
            },
          );
        },
      );

      if (results != null) {
        setState(() {
          selectedItems = results;
        });
      }
    }

    Widget buildGestion(GestionMonedero operacion) {
      return FutureBuilder<Socio?>(
          future: leerSocio(operacion.email),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final socio = snapshot.data;
              if (socio == null) {
                return const Center(
                  child: Text("nono"),
                );
              } else {
                return Row(
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
                        "${socio.nombre} ${socio.apellidos}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    operacion.cantidad > 0
                        ? Container(
                            decoration: BoxDecoration(
                              color: const Color(0xff0AD905),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            height: 40,
                            width: 60,
                            child: Text(
                              "${operacion.cantidad} €",
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
                              "${operacion.cantidad} €",
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )
                  ],
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          });
    }

    final cantidadIngreso = TextEditingController();
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
                heroTag: "btnAdd",
                backgroundColor: Colors.blueAccent,
                onPressed: () {
                  AlertDialog alert = AlertDialog(
                    title: const Text("Añadir operacion"),
                    content: Container(
                      height: 250,
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
                          const Text("Escribe la cantidad a ingresar:"),
                          TextFormField(
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[\d+\-\.]'))
                            ],
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            controller: cantidadIngreso,
                          )
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text(
                          "Añadir operacion",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                        onPressed: () {
                          //print(emailSocios.toString());
                          try {
                            for (int i = 0; i < sociosOut.length; i++) {
                              for (int j = 0; j < selectedItems.length; j++) {
                                if (sociosOut[i].nombre == selectedItems[j]) {
                                  emailSocios
                                      .add(sociosOut[i].email.toString());                                  
                                  //print(sociosOut[i].email.toString() + "onpress");
                                }
                              }
                            }

                            addOperacion(int.parse(cantidadIngreso.text.trim()),
                                emailSocios);
                            
                            sociosOut.clear();
                            emailSocios.clear();
                            selectedItems.clear();
                            setState(() {
                              selectedItems = [];
                              emailSocios = [];
                              cantidadIngreso.clear();
                            });
                            const snackBar = SnackBar(
                              content: Text('Operacion añadida correctamente'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.pop(context);
                          } on FirebaseException catch (e) {
                            const snackBar = SnackBar(
                              content: Text('Error añadiendo operacion'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                      ),
                      TextButton(
                        child: const Text("Cancelar"),
                        onPressed: () => {
                          cantidadIngreso.clear(),
                          Navigator.pop(context),
                          selectedItems = [],
                          emailSocios = []
                        },
                      )
                    ],
                  );
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      });
                },
                child: const Icon(
                  Icons.payment,
                  size: 35,
                )),
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
          child: StreamBuilder<List<GestionMonedero>>(
              stream: leerTodosPagos(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final historialSocios = snapshot.data!;
                  if (historialSocios.isEmpty) {
                    return Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                          Icon(
                            Icons.payment_outlined,
                            size: 60,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            "NO HAY TRANSACCIONES",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ]));
                  } else {
                    return ListView(
                      children: historialSocios.map(buildGestion).toList(),
                    );
                  }
                } else {
                  print(snapshot.toString());
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        )));
  }
}
