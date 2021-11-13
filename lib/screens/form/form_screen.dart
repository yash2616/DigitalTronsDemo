import 'package:digital_trons_demo/constants.dart';
import 'package:digital_trons_demo/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:digital_trons_demo/screens/dashboard/data/day_data.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/form_bloc.dart';

class FormScreen extends StatelessWidget {
  FormScreen({Key? key, required this.startTime, required this.endTime, this.slot}) : super(key: key);

  final String startTime;
  final String endTime;

  final _firestore = FirebaseFirestore.instance;

  FormBloc _bloc = FormBloc();

  String? firstName = "";
  String? lastName = "";
  String? mobile = "";
  Slot? slot;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    firstNameController.text = slot?.firstName ?? "";
    lastNameController.text = slot?.lastName ?? "";
    mobileController.text = slot?.mobile ?? "";
    print(slot?.firstName ?? "null");
    print(slot?.lastName ?? "null");
    print(slot?.mobile ?? "null");
    return Scaffold(
      appBar: AppBar(
        title: Text("Digital Trons"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
          height: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Time Slot : $startTime - $endTime",
                  style: kFormHeadingTextStyle,
                )
              ),
              const SizedBox(height: 40,),
              const Text("First Name"),
              SizedBox(height:10),
              Container(
                height: 45,
                child: TextField(
                  controller: firstNameController,
                  // onChanged: (newValue){
                  //   firstName = newValue;
                  // },
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blueAccent, width: 0.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text("Last Name"),
              SizedBox(height:10),
              Container(
                height: 45,
                child: TextField(
                  controller: lastNameController,
                  // onChanged: (newValue){
                  //   lastName = newValue;
                  // },
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blueAccent, width: 0.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text("Mobile Number"),
              SizedBox(height:10),
              Container(
                height: 45,
                child: TextField(
                  controller: mobileController,
                  // onChanged: (newValue){
                  //   mobile = newValue;
                  // },
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blueAccent, width: 0.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              BlocConsumer<FormBloc, EditFormState>(
                bloc: _bloc,
                listener: (context, state){
                  if(state is FormErrorState){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Something went wrong"),
                      duration: Duration(seconds: 2),
                    ));
                  }
                  else if(state is FormSuccessState){
                    // print("success...");
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Success"),
                      duration: Duration(seconds: 2),
                    ));
                    BlocProvider.of<DashboardBloc>(context).add(RefreshDashboardEvent(
                      Slot(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          mobile: mobileController.text,
                          booked: true
                      ),
                      startTime,
                    ));
                    // print("pop pop");
                    // _bloc.reset();
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  if(state is FormSuccessState){
                    print("Initial...");
                  }
                  else if(state is FormLoadingState){
                    print("Mic testing...");
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Row(
                    children: [
                      RaisedButton(
                        onPressed: (){
                          if(slot!=null){
                            _bloc.add(EditFormEvent(
                                slot: Slot(
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    mobile: mobileController.text,
                                    booked: true
                                ),
                                startTime: startTime
                            )
                            );
                          }
                          // bookSlot();
                          else{
                            _bloc.add(SubmitFormEvent(
                                slot: Slot(
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    mobile: mobileController.text,
                                    booked: true
                                ),
                                startTime: startTime)
                            );
                          }
                          // Navigator.pop(context);
                        },
                        elevation: 5.0,
                        child: Text("Submit", style: TextStyle(color: Colors.white)),
                        color: Colors.blueAccent,
                      ),
                      SizedBox(width: 20),
                      RaisedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        elevation: 5.0,
                        child: Text("Cancel", style: TextStyle(color: Colors.white)),
                        color: Colors.redAccent,
                      ),
                    ],
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
