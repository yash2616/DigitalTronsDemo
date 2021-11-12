import 'package:digital_trons_demo/screens/dashboard/data/day_data.dart';
import 'package:digital_trons_demo/services/database_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState>{

  DashboardBloc(this.databaseService) : super(DashboardLoadingState());

  final DatabaseService databaseService;

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async*{
    // TODO: implement mapEventToState
    if(event is LoadDashboardEvent){
      var data = await databaseService.loadData();
      if(data.status){
        yield DashboardLoadedState(data);
      }
      else{
        yield DashboardErrorState();
      }
      // await Future.delayed(Duration(seconds: 2));
    }
    else if(event is RefreshDashboardEvent){
      yield DashboardLoadedState((state as DashboardLoadedState).dayData..slots[event.startTime] = event.slot);
    }

  }
}