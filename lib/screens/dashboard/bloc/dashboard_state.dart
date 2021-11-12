part of 'dashboard_bloc.dart';

abstract class DashboardState{
  const DashboardState();
}

class DashboardLoadingState extends DashboardState{

}

class DashboardLoadedState extends DashboardState{

  DashboardLoadedState(this.dayData);

  final DayData dayData;
}

class DashboardErrorState extends DashboardState{

}