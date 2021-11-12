import 'package:digital_trons_demo/constants.dart';
import 'package:digital_trons_demo/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:digital_trons_demo/widgets/list_tile.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  List<Widget> listTiles = [];

  late DashboardBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _bloc = BlocProvider.of<DashboardBloc>(context);
    _bloc.add(LoadDashboardEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Digital Trons"),
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if(state is DashboardLoadingState){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(state is DashboardLoadedState){
            print(state.dayData.slots.length);
            return Column(
              children: [
                Container(
                  height: 20,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  margin: EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Start Time", style: kListViewHeadingTextStyle,),
                      Text("End Time", style: kListViewHeadingTextStyle,),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: [9,10,11,12,13,14,15,16].map((e) {
                      return SlotListTile(
                        startTime: "${e}:00",
                        endTime: "${e+1}:00",
                        booked: state.dayData.slots["$e:00"] != null,
                        slot: state.dayData.slots["$e:00"]
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          }
          else{
            return Container(
              color: Colors.orange,
            );
          }
        }
      ),
    );
  }
}
