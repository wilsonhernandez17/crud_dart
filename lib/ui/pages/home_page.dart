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
     //crearUsuario();
    leerUsuario();
    //updateUsuario();
    //deleteUsuario();
    //crearSubColeccion();

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

  crearUsuario(){
    Map<String, dynamic> json={
    "nombre":"prueba",
    "apellido":"prueba2",
    "edad":20
    };
    ServiceCRUD().createDoc("usuarios", json).then((value) {
      print(value.toString());
    });
  }

  leerUsuario(){
    ServiceCRUD().readDoc("usuarios","5vEAOpe41utvhCuTJnaB").then((  value) {
      print(value);
    });
  }

  updateUsuario(){
    Map<String, dynamic> json={
      "nombre":"actualizacion",
      "apellido":"actualizacion",
      "edad":20
    };
    ServiceCRUD().updateDoc("usuarios",json,"5vEAOpe41utvhCuTJnaB").then((value) => {
      print(value)
    });
  }

  deleteUsuario(){
    ServiceCRUD().deleteDoc("usuarios", "5vEAOpe41utvhCuTJnaB").then((value) => print(value));
  }

  crearSubColeccion(){

    Map<String, dynamic> json={
      "nombre":"sala1"
    };

    ServiceCRUD().createSubDoc("usuarios", "salas", '8mZ7t7nDJTHnRa8EPXu4', json);
  }
}
