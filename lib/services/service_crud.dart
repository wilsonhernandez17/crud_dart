import 'dart:collection';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/service_entity.dart';

class ServiceCRUD extends MyService{



  Future<String> createDoc(String ruta,String ruta2,String id, Map<String, dynamic> json,bool isDelete)async{

      CollectionReference collectionReference = FirebaseFirestore.instance.collection(ruta);
      return collectionReference.doc(id).collection(ruta2).add(json).then((value) => value.id).catchError((onError)=>'');

   /* return collectionReference.add(json).then((value){
      return value.id;
    }).catchError((onError){
      return '';
    });*/
  }


  Future<String> createSubDoc(String ruta,String ruta2,String id,Map<String,dynamic> json){
    CollectionReference collectionReference = FirebaseFirestore.instance.collection(ruta);
    return collectionReference.doc(id).collection(ruta2).add(json).then((value) => value.id).catchError((onError)=>'');
  }
  Future<List<Map<String, dynamic>>> readDoc(String ruta,String ruta2,String id){

   return FirebaseFirestore.instance
        .collection(ruta)
        .doc(id)
        .collection(ruta2)
        .get()
        .then((  value){
          if(value.size!=0){
            return  Future.value(value.docs.map((e) => e.data()).toList());
          }else{
            return Future.value();
          }
   });
  }
  Future<String> updateDoc(String ruta, Map<String, dynamic> json, String? id)async{
    CollectionReference collectionReference = FirebaseFirestore.instance.collection(ruta);
    return collectionReference.doc(id).set(json,SetOptions(merge: true)).then((value) => 'Actualizacion exitosa').catchError((onError)=> 'A ocurrido un error');

  }

   deleteDoc(String ruta,String ruta2,String id) {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection(ruta);
    WriteBatch batch = FirebaseFirestore.instance.batch();

     collectionReference
        .doc(id)
        .collection(ruta2)
        .get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        batch.delete(element.reference);
      });
      batch.commit();

    });
  }
}

