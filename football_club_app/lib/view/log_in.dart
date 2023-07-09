// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:football_club_app/view/forgotten_password.dart';
import 'package:football_club_app/view/home.dart';
import 'package:football_club_app/view/loaderToHome.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/socio.dart';

class LogIn extends StatefulWidget {
  bool credencialesErroneas;
  LogIn({
    Key? key,
    this.credencialesErroneas = false,
  }) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  late SharedPreferences sharedPreferences;
  bool? recordarCredenciales = false;
  TextEditingController correoController = TextEditingController();
  TextEditingController passwdController = TextEditingController();
  final GlobalKey<FormState> _formKeyEm = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPas = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getCredential();
  }

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      recordarCredenciales = sharedPreferences.getBool("remember_me");
      if (recordarCredenciales != null) {
        if (recordarCredenciales!) {
          correoController.text =
              sharedPreferences.getString("email").toString();
          passwdController.text =
              sharedPreferences.getString("password").toString();
        } else {
          correoController.clear();
          passwdController.clear();
          sharedPreferences.clear();
        }
      } else {
        recordarCredenciales = false;
      }
    });
  }

  bool isLoading = false;
  bool passwordVisible = false;
  final ButtonStyle styleInic = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      backgroundColor: const Color.fromARGB(255, 67, 159, 162),
      padding: const EdgeInsets.fromLTRB(90.0, 16.0, 90.0, 16.0));

  actionRemeberMe(bool value) {
    recordarCredenciales = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('email', correoController.text);
        prefs.setString('password', passwdController.text);
      },
    );
  }

  @override
  Widget build(BuildContext context) => isLoading
      ? const loaderHome()
      : Scaffold(
          body: Center(
            child: Container(
              height: 780,
              width: 370,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffffffff),
              ),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                TextFormField(
                  key: _formKeyEm,
                  controller: correoController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Por favor introduzca un correo electrónico';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      icon: Icon(Icons.person), hintText: 'Correo electrónico'),
                ),
                TextFormField(
                  key: _formKeyPas,
                  obscureText: !passwordVisible,
                  controller: passwdController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    icon: const Icon(Icons.password_rounded),
                    hintText: 'Contraseña',
                    suffixIcon: IconButton(
                        icon: passwordVisible
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        }),
                  ),
                ),
                CheckboxListTile(
                  title: const Text("Recordar credenciales"),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: recordarCredenciales,
                  activeColor: Colors.blueGrey,
                  onChanged: (bool? value) {
                    recordarCredenciales = value;
                    SharedPreferences.getInstance().then(
                      (prefs) {
                        prefs.setBool("remember_me", value!);
                        prefs.setString('email', correoController.text);
                        prefs.setString('password', passwdController.text);
                      },
                    );
                    setState(() {
                      recordarCredenciales = value;
                    });
                  },
                ),
                widget.credencialesErroneas
                    ? const Text(
                        "Email o contraseña incorrecta",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.redAccent),
                        textAlign: TextAlign.center,
                      )
                    : const Text(""),
                widget.credencialesErroneas
                    ? const SizedBox(height: 10,)
                    : const Text(""),
                ElevatedButton(
                  onPressed: signIn,
                  style: styleInic,
                  child: const Center(child: Text("INICIA SESIÓN")),
                ),
                ElevatedButton(
                  onPressed: (() => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const forgottenPassword()),
                        )
                      }),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent),
                  child: const Text("¿Contraseña olvidada?",
                      style: TextStyle(fontSize: 15, color: Colors.grey)),
                ),
              ]),
            ),
          ),
          backgroundColor: const Color(0xff2B4EA1),
          appBar: AppBar(
            title: const Text(
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                "INICIAR SESIÓN"),
            elevation: 0,
            centerTitle: true,
          ),
        );

  Future signIn() async {
    
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
      if (correoController.text.trim() != "" && passwdController.text.trim() != "") {
        //print('Form is valid');
          try {
      
            //await FirebaseAuth.instance.setPersistence(Persistence.NONE);
              await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: correoController.text.trim(),
                  password: passwdController.text.trim());
          } on FirebaseAuthException catch (e) {
            print(e);
            //Navigator.of(context).pop();
            setState(() {
              widget.credencialesErroneas = true;
            });
          }
    
      } else {
        setState(() {
          widget.credencialesErroneas = true;
        });
      }    

    Navigator.of(context).pop();
  }
}
