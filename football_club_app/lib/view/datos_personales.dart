import 'package:flutter/material.dart';
import 'package:football_club_app/view/perfil.dart';

import '../model/socio.dart';

class DatosPersonales extends StatefulWidget {
  final Socio socio;
  const DatosPersonales({Key? key, required this.socio}) : super(key: key);

  @override
  State<DatosPersonales> createState() => _DatosPersonalesState();
}

class _DatosPersonalesState extends State<DatosPersonales> {
  final ButtonStyle styleInic = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      backgroundColor: const Color(0xff3C3577),
      padding: const EdgeInsets.fromLTRB(90.0, 16.0, 90.0, 16.0));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "DATOS PERSONALES",
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
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "NOMBRE",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff5C5858),
                      fontSize: 16),
                ),
                TextFormField(
                    initialValue: widget.socio.nombre,
                    decoration:
                        const InputDecoration(icon: Icon(Icons.person))),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "APELLIDOS",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff5C5858),
                      fontSize: 16),
                ),
                TextFormField(
                    initialValue: widget.socio.apellidos,
                    decoration:
                        const InputDecoration(icon: Icon(Icons.person))),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "ALIAS",
                  style: TextStyle(                      
                      fontWeight: FontWeight.bold,
                      color: Color(0xff5C5858),
                      fontSize: 16),
                ),
                TextFormField(
                  initialValue: widget.socio.alias != "" ? widget.socio.alias:'',
                  decoration: const InputDecoration(
                      icon: Icon(Icons.person), hintText: 'Alias'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "CORREO ELECTRÓNICO",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff5C5858),
                      fontSize: 16),
                ),
                TextFormField(
                    initialValue: widget.socio.email,
                    decoration: const InputDecoration(icon: Icon(Icons.email))),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "TELÉFONO",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff5C5858),
                      fontSize: 16),
                ),
                TextFormField(
                    initialValue: widget.socio.telefono?.toStringAsPrecision(9),
                    decoration: const InputDecoration(icon: Icon(Icons.phone))),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "ANTIGUA CONTRASEÑA",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff5C5858),
                      fontSize: 16),
                ),
                TextFormField(
                    decoration:
                        const InputDecoration(icon: Icon(Icons.password))),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "NUEVA CONTRASEÑA",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff5C5858),
                      fontSize: 16),
                ),
                TextFormField(
                    decoration:
                        const InputDecoration(icon: Icon(Icons.password))),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: (() async => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Perfil(
                                    socio: widget.socio,
                                  )),
                        )
                      }),
                  style: styleInic,
                  child: const Center(child: Text("Guardar cambios")),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}
