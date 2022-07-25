import 'dart:collection';

import 'package:crud/services/service_crud.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {

  //crearSala();
    //crearUsuario();
     //addUsuarioSala();
    //readSalas();
    //createPartida();
    //crearRonda();
    //crearRespuesta();
    //leerUsuarioSala();
    //leerPartidas();
    //leerRonda();
    //leerRespuesta();
    return Scaffold(
        appBar: AppBar(
          title: const Text('CRUD'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Username',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            )
          ],
        ));
  }

  crearSala(){
    Map<String, dynamic> json={
    'nMaximoPersonas':5,
      'nRounda':5,
      'estado':false
    };
    ServiceCRUD().createRoom(json).then((value) {
      print(value.toString());
    });
  }
  crearUsuario(){
    Map<String, dynamic> json={
      'username':'mateo',
      'nPartidasGanadas':5,
      'nPartidasJugadas':5,
    };

    ServiceCRUD().createUser(json);
  }
  addUsuarioSala(){
    Map<String, dynamic> json={
      'id':'adsadasfdasdasf'
    };

    ServiceCRUD().addUser('UOcOlL1eOapIJ93Fgfka', json);
  }

  leerUsuarioSala(){
    ServiceCRUD().readUser('UOcOlL1eOapIJ93Fgfka').then((value) => print(value));
  }

  readSalas(){
    ServiceCRUD().readRoom().then((value) {
      print(value);
    });
  }

  createPartida(){
    Map<String, dynamic> json={
      'idSala':'UOcOlL1eOapIJ93Fgfka',
      'letras':['A','B','C'],
    };
    ServiceCRUD().createGame('UOcOlL1eOapIJ93Fgfka', json).then((value) {
      print(value);
    });
  }

  leerPartidas(){
    ServiceCRUD().readGame().then((value) => print(value));
  }

  crearRonda(){
    Map<String, dynamic> json={
      'letra':'A',
    };
    ServiceCRUD().addCircle('OoAwtaOyRbG4G6h6GuKe','1', json).then((value) {
      print(value);
    });
  }

  leerRonda(){
    ServiceCRUD().readCircle('OoAwtaOyRbG4G6h6GuKe').then((value) => print(value));
  }

  crearRespuesta(){
    Map<String, dynamic> json={
      'idUsuario':'123456789',
      'palabra':'Andres',
      'puntaje':0,
      'valida':false
    };
    ServiceCRUD().addResponse('OoAwtaOyRbG4G6h6GuKe', '1', json);
  }

  leerRespuesta(){
    ServiceCRUD().readResponse('OoAwtaOyRbG4G6h6GuKe', '1').then((value) => print(value));
  }
}
