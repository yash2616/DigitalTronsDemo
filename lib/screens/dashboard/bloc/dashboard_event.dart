part of 'dashboard_bloc.dart';

abstract class DashboardEvent{
  const DashboardEvent();
}

class LoadDashboardEvent extends DashboardEvent{

}

class RefreshDashboardEvent extends DashboardEvent{

  RefreshDashboardEvent(this.slot, this.startTime);

  final Slot slot;
  final String startTime;

}