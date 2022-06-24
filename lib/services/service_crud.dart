import 'dart:collection';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/service_entity.dart';

class ServiceCRUD extends MyService{



  Future<String> createDoc(String ruta, Map<String, dynamic> json)async{
    CollectionReference collectionReference = FirebaseFirestore.instance.collection(ruta);
    return collectionReference.add(json).then((value){
     return value.id;
    }).catchError((onError){
      return '';
    });
  }


  Future<String> createSubDoc(String ruta,String ruta2,String id,Map<String,dynamic> json){
    CollectionReference collectionReference = FirebaseFirestore.instance.collection(ruta);
    return collectionReference.doc(id).collection(ruta2).add(json).then((value) => value.id).catchError((onError)=>'');
  }
  Future<Map<String, dynamic>> readDoc(String ruta,String id){

   return FirebaseFirestore.instance
        .collection(ruta)
        .doc(id)
        .get()
        .then((  value){
          if(value.exists){
            return  Future.value(value.data());
          }else{
            return Future.value({});
          }
   });
  }
  Future<String> updateDoc(String ruta, Map<String, dynamic> json, String? id)async{

    CollectionReference users = FirebaseFirestore.instance.collection(ruta);
    return users.doc(id).set(json,SetOptions(merge: true)).then((value) => 'Actualizacion exitosa').catchError((onError)=> 'A ocurrido un error');

  }

  Future<String> deleteDoc(String ruta,String id){
    CollectionReference users = FirebaseFirestore.instance.collection(ruta);
    return users
        .doc(id)
        .delete()
        .then((value) => "User Deleted")
        .catchError((error) => "Failed to delete user: $error");

  }
}

