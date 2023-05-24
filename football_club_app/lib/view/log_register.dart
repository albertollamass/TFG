import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'log_in.dart';

class LogRegister extends StatefulWidget{

  @override
  _LogRegisterState createState() => _LogRegisterState();

}

class _LogRegisterState extends State<LogRegister> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle styleSignIn =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold), backgroundColor: Color(0xff7950F2), padding: EdgeInsets.fromLTRB(50.0,16.0,50.0,16.0));
    final ButtonStyle styleRegister =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold), backgroundColor: Color(0xffFFFFFF), padding: EdgeInsets.all(16.0));

		return  Scaffold(
      backgroundColor: const Color(0xff2B4EA1),
      body: Container(
        height: 500,
        margin: EdgeInsets.fromLTRB(0, 170, 0, 0),
        alignment: Alignment.center,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 100,
                width: 100,                
                child: Image.asset("assets/icon/icon.png")
                ),
              ElevatedButton(
                onPressed: (() => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogIn()),
                  )
                }), 
                child: Text("Iniciar sesión"),
                style: styleSignIn,
                
                ),
                Row(
                  children: <Widget>[
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                            child: const Divider(
                              color: Color(0xffFFFFFF),
                              height: 10,
                              thickness: 1.1                              
                            )
                        ),
                      ),       

                      Text(style: TextStyle(color: Color(0xffFFFFFF), fontSize: 20, fontWeight: FontWeight.bold, ), "¿Todavía no tienes una cuenta?"),        

                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: const Divider(
                              color: Color(0xffFFFFFF),
                              height: 10,
                              thickness: 1.1
                            )
                        ),
                      ),
                  ]
                ),

                ElevatedButton(
                onPressed: (() => {
                  LogRegister()
                }), 
                child: Text("Solicitar inscripción", style: TextStyle(color: Color(0xff000000))),
                style: styleRegister,
                
                ),
            ],
          ),
      ),
    ),
    );
	}
}
