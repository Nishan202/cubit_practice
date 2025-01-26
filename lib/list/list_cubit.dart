import 'package:cubit_practice/list/list_state_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListCubit extends Cubit<ListStateCubit>{
  ListCubit() : super(ListStateCubit(data: []));

  static final String NOTE_TITLE = 'note_title';
  static final String NOTE_DESC = 'note_description';
  
  // List<Map<String, dynamic>> _mData = [];

  void addNote({required String noteTitle, required String noteDescription}){
    var currentStateValue = state.data;
    currentStateValue.add({
      NOTE_TITLE : noteTitle,
      NOTE_DESC : noteDescription
    });
    emit(ListStateCubit(data: currentStateValue));
  }

  void updateNote({required String updatedTitle, required String updatedDescription, required int index}){
    var currentStateValue = state.data;
    currentStateValue[index] = {
      NOTE_TITLE : updatedTitle,
      NOTE_DESC : updatedDescription
    };
    emit(ListStateCubit(data: currentStateValue));
  }

  void removeNote({required int index}){
    var currentStateValue = state.data;
    currentStateValue.removeAt(index);
    emit(ListStateCubit(data: currentStateValue));
  }
}