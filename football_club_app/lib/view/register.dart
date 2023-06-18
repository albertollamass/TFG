import 'package:flutter/material.dart';
import 'package:football_club_app/view/log_register.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool? recordarCredenciales = false ;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle styleInic =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), backgroundColor: const Color.fromARGB(255, 67, 159, 162), padding: const EdgeInsets.fromLTRB(0.0,16.0,0.0,16.0));
    return Scaffold(
      backgroundColor: const Color(0xff2B4EA1),
      appBar: AppBar(
        title: const Text(style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),"SOLICITAR INSCRIPCIÓN"),
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
          child: ListView(      
            padding: const EdgeInsets.all(10),      
            children: [
            TextFormField(
                decoration: const InputDecoration(icon: Icon(Icons.person),hintText: 'Nombre *'),
              ),
            const SizedBox(height: 10,),
            TextFormField(
                decoration: const InputDecoration(icon: Icon(Icons.person),hintText: 'Apellidos *'),
              ),
            const SizedBox(height: 10,),
            TextFormField(
                decoration: const InputDecoration(icon: Icon(Icons.person),hintText: 'Alias'),
              ),
            const SizedBox(height: 10,),
            TextFormField(
                decoration: const InputDecoration(icon: Icon(Icons.email),hintText: 'Correo electrónico *'),
              ),
            const SizedBox(height: 10,),
            TextFormField(
                decoration: const InputDecoration(icon: Icon(Icons.phone),hintText: 'Telefono'),
              ),
            const SizedBox(height: 10,),
            TextFormField(
                decoration: const InputDecoration(icon: Icon(Icons.password),hintText: 'Contraseña *'),
              ),
            const SizedBox(height: 10,),
            TextFormField(
                decoration: const InputDecoration(icon: Icon(Icons.password),hintText: 'Confirmar contraseña *'),
              ),
            const SizedBox(height: 10,),
            Text("(*) Obligatorio", style: TextStyle(fontSize: 16, color: Colors.red[400]),),
            const SizedBox(height: 30,),
            CheckboxListTile(
                title: const Text(style: TextStyle(), textAlign: TextAlign.justify,"Para completar tu registro, debes aceptar los Términos de Uso y el procesamiento y tratamiento de tus datos personales conforme a lo dispuesto en las Políticas de Privacidad."),
                controlAffinity: ListTileControlAffinity.leading,
                value: recordarCredenciales, 
                activeColor: Colors.blueGrey,
                tristate: false,
                onChanged: (newBool) {
                  setState(() {
                    recordarCredenciales = newBool;
                  });
                },
              ),
              const SizedBox(height: 20,),
              const Text("Recuerda que para tener acceso debe aceptar la solicitud un administrador",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.center,),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: (() async => {                                    
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LogRegister()),                    
                  )                  
                }),
                style: styleInic, 
                child: const Center(child: Text("SOLICITAR INSCRIPCIÓN", style: TextStyle(fontSize: 18),)),
                
              ),
          ]),
        ),
      )
    );
  }
}