import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:football_club_app/controller/controlador.dart';

class CrearUsuario extends StatefulWidget {
  const CrearUsuario({super.key});

  @override
  State<CrearUsuario> createState() => _CrearUsuarioState();
}

class _CrearUsuarioState extends State<CrearUsuario> {
  bool? esAdmin = false;

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwdController = TextEditingController();
  final cpasswdController = TextEditingController();
  final aliasController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final ButtonStyle styleInic = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        backgroundColor: const Color(0xff3C3577),
        padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0));
    return Scaffold(
        backgroundColor: const Color(0xff2B4EA1),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              "CREAR SOCIO"),
          elevation: 0,
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            height: 780,
            width: 370,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xffffffff),
            ),
            child: ListView(padding: const EdgeInsets.all(10), children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                    icon: Icon(Icons.person), hintText: 'Nombre *'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: surnameController,
                decoration: const InputDecoration(
                    icon: Icon(Icons.person), hintText: 'Apellidos *'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: aliasController,
                decoration: const InputDecoration(
                    icon: Icon(Icons.person), hintText: 'Alias'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    icon: Icon(Icons.email), hintText: 'Correo electrónico *'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                    icon: Icon(Icons.phone), hintText: 'Telefono'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: true,
                controller: passwdController,
                decoration: const InputDecoration(
                    icon: Icon(Icons.password), hintText: 'Contraseña *'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: true,
                controller: cpasswdController,
                decoration: const InputDecoration(
                    icon: Icon(Icons.password),
                    hintText: 'Confirmar contraseña *'),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 30,
              ),
              CheckboxListTile(
                title: const Text(
                    style: TextStyle(),
                    textAlign: TextAlign.justify,
                    "¿Quieres que sea administrador?"),
                controlAffinity: ListTileControlAffinity.leading,
                value: esAdmin,
                activeColor: Colors.blueGrey,
                tristate: false,
                onChanged: (newBool) {
                  setState(() {
                    esAdmin = newBool;
                  });
                },
              ),
              Text(
                "(*) Obligatorio",
                style: TextStyle(fontSize: 16, color: Colors.red[400]),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: (() {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      });
                  crearSocio(
                    nameController.text,
                    surnameController.text,
                    aliasController.text,
                    emailController.text.trim(),
                    passwdController.text.trim(),
                    phoneController.text,
                    esAdmin,
                    user?.email,
                  );
                  Navigator.of(context).pop();

                  const snackBar = SnackBar(
                    content: Text('Usuario creado correctamente'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.of(context).pop();
                }),
                style: styleInic,
                child: const Center(
                    child: Text(
                  "CREAR SOCIO",
                  style: TextStyle(fontSize: 16),
                )),
              ),
            ]),
          ),
        ));
  }
}
