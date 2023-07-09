import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:football_club_app/controller/controlador.dart';
import 'package:football_club_app/model/socio.dart';
import 'package:football_club_app/view/log_register.dart';

class Register extends StatefulWidget {
  Register({super.key, required this.privacidad});
  late bool privacidad;
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool aceptarPoliticas = false;
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwdController = TextEditingController();
  final cpasswdController = TextEditingController();
  final aliasController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle styleInic = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        backgroundColor: const Color.fromARGB(255, 67, 159, 162),
        padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0));
    return Scaffold(
        backgroundColor: const Color(0xff2B4EA1),
        appBar: AppBar(
          title: const Text(
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              "SOLICITAR INSCRIPCIÓN"),
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
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
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
              Text(
                "(*) Obligatorio",
                style: TextStyle(fontSize: 16, color: Colors.red[400]),
              ),
              const SizedBox(
                height: 30,
              ),
              CheckboxListTile(
                title: const Text(
                    style: TextStyle(),
                    textAlign: TextAlign.justify,
                    "Para completar tu registro, debes aceptar los Términos de Uso y el procesamiento y tratamiento de tus datos personales."),
                controlAffinity: ListTileControlAffinity.leading,
                value: aceptarPoliticas,
                activeColor: Colors.blueGrey,
                tristate: false,
                onChanged: (newBool) {
                  setState(() {
                    aceptarPoliticas = newBool!;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              widget.privacidad
                  ? Text(
                      "**Debes marcar esta casilla para poder registrarte",
                      style: TextStyle(fontSize: 16, color: Colors.red[400]),
                    )
                  : const SizedBox(),
              widget.privacidad
                  ? const SizedBox(
                      height: 20,
                    )
                  : const Text(""),
              const Text(
                "Recuerda que para tener acceso debe aceptar la solicitud un administrador",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: (() async => {
                      if (aceptarPoliticas && (nameController.text.trim() != "" && surnameController.text.trim() != "" && emailController.text.trim() != "" && passwdController.text.trim() != "" && comprobarPass(passwdController.text.trim(), cpasswdController.text.trim())))
                        {
                          crearSolicitud(
                            nameController.text,
                            surnameController.text,
                            aliasController.text,
                            emailController.text.trim(),
                            passwdController.text.trim(),
                            phoneController.text,
                            false,
                          ),
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LogRegister()),
                          )
                        }
                      else if (!aceptarPoliticas)
                        {
                          // Navigator.push(
                          // context,
                          // MaterialPageRoute(builder: (context) => const Register(privacidad: true,)),
                          //
                          //)
                          setState(
                            () {
                              widget.privacidad = true;
                            },
                          )
                        } else if (!comprobarPass(passwdController.text.trim(), cpasswdController.text.trim())){

                        }
                    }),
                style: styleInic,
                child: const Center(
                    child: Text(
                  "SOLICITAR INSCRIPCIÓN",
                  style: TextStyle(fontSize: 18),
                )),
              ),
            ]),
          ),
        ));
  }
}
