import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_trons_demo/screens/dashboard/data/day_data.dart';

class DatabaseService{

  static FirebaseFirestore? db;


  Future<DayData> loadData() async{

    try{
      db ??= FirebaseFirestore.instance;

      DateTime today = DateTime.now();
      DateTime today2 = DateTime(today.year, today.month, today.day);

      var timeSlots = await db!.collection('timeSlots').where(
        "timestamp",
        isLessThan: today2.add(Duration(hours: 24)),
      ).where(
        "timestamp",
        isGreaterThan: today2,
      ).get();

      // print(timeSlots.docs[0].data());

      if(timeSlots.docs.isNotEmpty){
        return DayData.fromJson(timeSlots.docs[0].data());
      }
      else{
        return DayData.fromJson({});
      }
    }
    catch(e,st){
      print(e);
      print(st);
      return DayData.withError();
    }

  }

  Future<bool> bookSlot(Slot slot, String startTime) async{

    try{
      db ??= FirebaseFirestore.instance;
      DateTime today = DateTime.now();
      DateTime today2 = DateTime(today.year, today.month, today.day);
      var timeSlots = await db!.collection('timeSlots').where(
        "timestamp",
        isLessThan: today2.add(Duration(hours: 24)),
      ).where(
        "timestamp",
        isGreaterThan: today2,
      ).get();
      if(timeSlots.docs.isNotEmpty){
        timeSlots.docs[0].reference.update({
          '$startTime': slot.toJson(),
        });
      }
      else{
        await db!.collection("timeSlots").add({
          "timestamp": today,
          '$startTime': slot.toJson(),
        });
      }

      print("Data added...");
      return true;
    }
    catch(e){
      print(e);
      return false;
    }

  }

  Future<bool> editSlot(Slot slot, String startTime) async {
    try {
      db ??= FirebaseFirestore.instance;

      DateTime today = DateTime.now();
      DateTime today2 = DateTime(today.year, today.month, today.day);
      var timeSlots = await db!.collection('timeSlots').where(
        "timestamp",
        isLessThan: today2.add(Duration(hours: 24)),
      ).where(
        "timestamp",
        isGreaterThan: today2,
      ).get();
      if (timeSlots.docs.isNotEmpty) {
        await timeSlots.docs[0].reference.update({
          '$startTime': slot.toJson()
        });
      }
      print("Data editted");
      return true;
    }
    catch (e) {
      print(e);
      return false;
    }
  }

}