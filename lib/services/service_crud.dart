import 'dart:collection';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/utils/varibles_firebase.dart';

import '../entities/service_entity.dart';

class ServiceCRUD extends MyService {

  Future<String> createRoom(Map<String, dynamic> jsonRoom) async {
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection(COLECCION_SALAS);
    return collectionReference
        .add(jsonRoom)
        .then((value) => value.id)
        .catchError((onError) => '');
  }

  Future<List<Map<String, dynamic>>> readRoom() {
    return FirebaseFirestore.instance.collection(COLECCION_SALAS).where('estado',isEqualTo: true).get().then((
        value) {
      if (value.size != 0) {

        return Future.value(value.docs.map((e) => {'key':e.id,'data':e.data()}).toList());
      }
      return Future.value([]);

    });
  }

   addUser(String idRoom, Map<String, dynamic> jsonUser) async {
    CollectionReference collectionReference =
      FirebaseFirestore.instance.collection(COLECCION_SALAS);
      collectionReference.doc(idRoom).collection(COLECCION_USUARIO).add(jsonUser);
  }

  Future<String>  createUser( Map<String, dynamic> jsonUser) async {
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection(COLECCION_USUARIO);
    return collectionReference.add(jsonUser).then((value) => Future.value(value.id)).catchError((onError)=>Future.value(''));
  }


  Future<List<Map<String,dynamic>>> readUser(String idRoom ){
    return FirebaseFirestore.instance.collection(COLECCION_SALAS).doc(idRoom).collection(COLECCION_USUARIO).get().then((value) {
      return Future.value(value.docs.map((e) => {'key':e.id,'data':e.data()}).toList());
    });
  }
  Future<String> createGame(String idRoom,Map<String, dynamic> jsonGame) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(COLECCION_PARTIDA);
    return collectionReference
        .add(jsonGame)
        .then((value) => value.id)
        .catchError((onError) => '');
  }

  Future<List<Map<String,dynamic>>> readGame()async{
    return FirebaseFirestore.instance.collection(COLECCION_PARTIDA).get().then((value) {
      if(value.size!=0){
        return Future.value(value.docs.map((e) => {'key':e.id,'data':e.data()}).toList());
      }
      return Future.value([]);
    });
  }

  Future<String> addCircle(
      String idGame,String idCircle, Map<String, dynamic> jsonCircle) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(COLECCION_PARTIDA);
     return collectionReference
        .doc(idGame)
        .collection(COLECCION_RONDA)
    .doc(idCircle)
        .set(jsonCircle)
        .then((value) => 'ok')
        .catchError((onError) => '');
  }

  Future<List<Map<String,dynamic>>> readCircle(String idGame) async{
    return FirebaseFirestore.instance.collection(COLECCION_PARTIDA).doc(idGame).collection(COLECCION_RONDA).get().then((value){
      if(value.size!=0){
        return Future.value(value.docs.map((e) => {'key':e.id,'data':e.data()}).toList());
      }
      return Future.value([]);
    });
  }

  Future<String> addResponse(
      String idGame, String idCircle, Map<String, dynamic> jsonResponse) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(COLECCION_PARTIDA);
    return collectionReference
        .doc(idGame)
        .collection(COLECCION_RONDA)
        .doc(idCircle)
        .collection(COLECCION_RESPUESTA)
        .add(jsonResponse)
        .then((value) => value.id)
        .catchError((onError) => '');
  }

  Future<List<Map<String,dynamic>>> readResponse(String idGame, String idCircle){
    return FirebaseFirestore.instance.collection(COLECCION_PARTIDA).doc(idGame).collection(COLECCION_RONDA).doc(idCircle).collection(COLECCION_RESPUESTA).get().then((value) {
      if(value.size!=0){
        return Future.value(value.docs.map((e) => {'key':e.id,'data':e.data()}).toList());
      }
      return Future.value([]);
    });
  }

  Future<String> createDoc(String ruta, String ruta2, String id,
      Map<String, dynamic> json, bool isDelete) async {
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection(ruta);
    return collectionReference
        .doc(id)
        .collection(ruta2)
        .add(json)
        .then((value) => value.id)
        .catchError((onError) => '');
  }

  Future<String> createSubDoc(
      String ruta, String ruta2, String id, Map<String, dynamic> json) {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(ruta);
    return collectionReference
        .doc(id)
        .collection(ruta2)
        .add(json)
        .then((value) => value.id)
        .catchError((onError) => '');
  }

  Future<List<Map<String, dynamic>>> readDoc(
      String ruta, String ruta2, String id) {
    return FirebaseFirestore.instance
        .collection(ruta)
        .doc(id)
        .collection(ruta2)
        .get()
        .then((value) {
      if (value.size != 0) {
        return Future.value(value.docs.map((e) => e.data()).toList());
      } else {
        return Future.value();
      }
    });
  }

  Future<String> updateDoc(String ruta, String ruta2, Map<String, dynamic> json,
      String idUser, String id) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(ruta);
    return collectionReference
        .doc(idUser)
        .collection(ruta2)
        .doc(id)
        .set(json, SetOptions(merge: true))
        .then((value) => 'Actualizacion exitosa')
        .catchError((onError) => 'A ocurrido un error');
  }

  deleteDoc(String ruta, String ruta2, String id) {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(ruta);
    WriteBatch batch = FirebaseFirestore.instance.batch();

    collectionReference.doc(id).collection(ruta2).get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        batch.delete(element.reference);
      });
      batch.commit();
    });
  }
}
