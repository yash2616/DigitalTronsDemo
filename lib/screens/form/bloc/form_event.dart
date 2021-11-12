part of "form_bloc.dart";

abstract class FormEvent{
  const FormEvent();
}

class SubmitFormEvent extends FormEvent{

  SubmitFormEvent({required this.slot, required this.startTime});

  final Slot slot;
  final String startTime;
}

class EditFormEvent extends FormEvent{

  EditFormEvent({required this.slot, required this.startTime});

  final Slot slot;
  final String startTime;

}