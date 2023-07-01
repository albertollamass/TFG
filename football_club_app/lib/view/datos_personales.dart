import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:football_club_app/controller/controlador.dart';
import 'package:football_club_app/view/home.dart';
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
    final nameController = TextEditingController(text: widget.socio.nombre);
    final surnameController =
        TextEditingController(text: widget.socio.apellidos);
    final emailController = TextEditingController(text: widget.socio.email);
    final phoneController =
        TextEditingController(text: widget.socio.telefono.toString());
    final passwdController = TextEditingController();
    final cpasswdController = TextEditingController();
    final aliasController = TextEditingController(
        text: widget.socio.alias != "" ? widget.socio.alias : '');
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
                    controller: nameController,
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
                    controller: surnameController,
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
                  controller: aliasController,
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
                    enabled: false,
                    // controller: emailController,
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
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    controller: phoneController,
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
                    obscureText: true,
                    controller: passwdController,
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
                    controller: cpasswdController,
                    obscureText: true,
                    decoration:
                        const InputDecoration(icon: Icon(Icons.password))),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final docSocio = FirebaseFirestore.instance
                        .collection('socios')
                        .doc(widget.socio.email);
                    docSocio.update({
                      'alias': aliasController.text.trim(),
                      'apellidos': surnameController.text.trim(),
                      'nombre': nameController.text.trim(),
                      'telefono': int.parse(phoneController.text.trim()),
                    });
                    final currentUser = FirebaseAuth.instance.currentUser;
                    try {
                      if (passwdController.text.trim() != "") {
                        if (comprobarPass(widget.socio.password.toString(),
                            passwdController.text.trim())) {
                          final credential = EmailAuthProvider.credential(
                              email: currentUser!.email.toString(),
                              password: passwdController.text.trim());
                          currentUser.reauthenticateWithCredential(credential);
                          currentUser
                              .updatePassword(cpasswdController.text.trim());
                          docSocio.update(
                              {'password': cpasswdController.text.trim()});
                        } else {
                          const snackBar = SnackBar(
                            content:
                                Text('ERROR! Contraseña antigua incorrecta'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    } on FirebaseException catch (e) {
                      print(e);
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                    const snackBar = SnackBar(
                      content: Text('Datos actualizados correctamente'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
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
