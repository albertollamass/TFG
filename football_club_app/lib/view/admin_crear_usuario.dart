import 'package:flutter/material.dart';

class CrearUsuario extends StatefulWidget {
  const CrearUsuario({super.key});

  @override
  State<CrearUsuario> createState() => _CrearUsuarioState();
}

class _CrearUsuarioState extends State<CrearUsuario> {  
  @override
  Widget build(BuildContext context) {
    final ButtonStyle styleInic =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), backgroundColor: const Color(0xff3C3577), padding: const EdgeInsets.fromLTRB(0.0,16.0,0.0,16.0));
    return Scaffold(      
      backgroundColor: const Color(0xff2B4EA1),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white, size: 35,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),"CREAR SOCIO"),
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
                decoration: const InputDecoration(icon: Icon(Icons.person),hintText: 'Nombre'),
              ),
            const SizedBox(height: 10,),
            TextFormField(
                decoration: const InputDecoration(icon: Icon(Icons.person),hintText: 'Apellidos'),
              ),
            const SizedBox(height: 10,),
            TextFormField(                  
                  decoration: const InputDecoration(
                      icon: Icon(Icons.person)),
            ),
            const SizedBox(height: 10,),
            TextFormField(
                decoration: const InputDecoration(icon: Icon(Icons.email),hintText: 'Correo electrónico'),
              ),
            const SizedBox(height: 10,),
            TextFormField(
                decoration: const InputDecoration(icon: Icon(Icons.phone),hintText: 'Telefono'),
              ),
            const SizedBox(height: 10,),
            TextFormField(
                decoration: const InputDecoration(icon: Icon(Icons.password),hintText: 'Contraseña'),
              ),
            const SizedBox(height: 10,),
            TextFormField(
                decoration: const InputDecoration(icon: Icon(Icons.password),hintText: 'Confirmar contraseña'),
              ),
            const SizedBox(height: 30,),                                       
              ElevatedButton(
                onPressed: (() async => {                                    
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CrearUsuario()),                    
                  )                  
                }),
                style: styleInic, 
                child: const Center(child: Text("CREAR SOCIO", style: TextStyle(fontSize: 16),)),
                
              ),
          ]),
        ),
      )
    );
  }
}