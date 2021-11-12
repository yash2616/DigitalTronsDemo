import 'package:digital_trons_demo/screens/dashboard/data/day_data.dart';
import 'package:digital_trons_demo/services/database_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'form_event.dart';
part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, EditFormState>{
  FormBloc() : super(FormInitialState());

  DatabaseService databaseService = DatabaseService();

  @override
  Stream<EditFormState> mapEventToState(FormEvent event) async* {
    // TODO: implement mapEventToState
    if(event is SubmitFormEvent){
      yield FormLoadingState();
      var result = await databaseService.bookSlot(event.slot, event.startTime);
      if(result){
        yield FormSuccessState();
      }
      else{
        yield FormErrorState();
      }
    }
    else if(event is EditFormEvent){
      yield* edit(event);
    }
  }

  void reset(){
    emit(FormInitialState());
  }

  Stream<EditFormState> edit(EditFormEvent event) async*{

    yield FormLoadingState();
    await Future.delayed(Duration(seconds: 2));
    var result = await databaseService.editSlot(event.slot, event.startTime);
    if(result){
      emit(FormSuccessState());
    }
    else{
      yield FormErrorState();
    }
  }

}