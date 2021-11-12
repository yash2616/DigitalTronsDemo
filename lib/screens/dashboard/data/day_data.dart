class DayData{
  DateTime? timestamp;
  Map<String, Slot> slots = {};
  bool status = true;

  DayData.withError(){
    status = false;
  }

  DayData.fromJson(Map<String, dynamic> json){
    if(json["timestamp"]!=null){
      timestamp = DateTime.parse(json["timestamp"].toDate().toString());
    }
    else{
      timestamp = DateTime.now();
    }

    json.forEach((key, value) {
      if(key!="timestamp"){
        slots[key] = Slot.fromJson(json[key]);
      }
    });
  }

}

class Slot{
  String? firstName;
  String? lastName;
  String? mobile;
  bool booked = false;

  Slot({this.firstName, this.lastName, this.mobile, required this.booked});

  Slot.fromJson(Map json){
    firstName = json["firstName"];
    lastName = json["lastName"];
    mobile = json["mobile"];
    booked = json["booked"];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> json = {};
    json["firstName"] = firstName ?? "";
    json["lastName"] = lastName ?? "";
    json["mobile"] = mobile ?? "";
    json["booked"] = booked;

    return json;
  }

}