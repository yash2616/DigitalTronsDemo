import 'package:digital_trons_demo/constants.dart';
import 'package:digital_trons_demo/screens/dashboard/data/day_data.dart';
import 'package:digital_trons_demo/screens/form/form_screen.dart';
import 'package:flutter/material.dart';

class SlotListTile extends StatelessWidget {
  SlotListTile({Key? key, required this.startTime, required this.endTime, this.booked = false, this.slot}) : super(key: key);

  final String startTime;
  final String endTime;
  bool? booked;
  Slot? slot;

  void openSlot(BuildContext context){
    Navigator.push(context, MaterialPageRoute(
        builder: (context){
          return FormScreen(
            startTime: startTime,
            endTime: endTime,
            slot: slot,
          );
        }
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        openSlot(context);
      },
      child: Container(
        height: 70,
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        margin: const EdgeInsets.only(top: 6.0, left: 8.0, right: 8.0),
        decoration: BoxDecoration(
          color: booked! ? Colors.red : Colors.lightGreen,
          boxShadow: [
            BoxShadow(
              offset: const Offset(1,3),
              blurRadius: 1.5,
              color: Colors.black.withOpacity(0.4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(startTime, style: kSlotTileTimeTextStyle,),
            Text(endTime, style: kSlotTileTimeTextStyle,),
          ],
        ),
      ),
    );
  }
}
