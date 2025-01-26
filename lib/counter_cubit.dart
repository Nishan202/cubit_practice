import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0); // initial state -> state means value

  //events
  void increamentCount(){
    // var currentStateValue = state;
    emit(state+1);
  }

  void decrementCount(){
    if(state > 0){
      emit(state-1);
    }
  }
}