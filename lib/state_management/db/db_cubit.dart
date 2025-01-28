import 'package:cubit_practice/DB/data_model.dart';
import 'package:cubit_practice/DB/db_helper.dart';
import 'package:cubit_practice/state_management/db/db_state_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DbCubit extends Cubit<DbStateCubit>{
  DBHelper dbHelper;
  DbCubit({required this.dbHelper}) : super(DbStateCubit(dataModel: []));

  // List<DataModel> _mData = [];
  
  // fetch initial data
  fetchInitialData() async {
    var currentStateValue = state.dataModel;
    currentStateValue = await dbHelper.fetchAllData();
    emit(DbStateCubit(dataModel: currentStateValue));
  }

  // Add data in Databse
  addData({required DataModel aData}) async {
    bool check = await dbHelper.addNote(newNote: aData);
    var currentStateValue = state.dataModel;
    if(check){
      currentStateValue = await dbHelper.fetchAllData();
      emit(DbStateCubit(dataModel: currentStateValue));
    }
  }

  // Update data in Database
  updateData({required DataModel uData}) async {
    bool check = await dbHelper.updateNote(updateNote: uData);
    var currentStateValue = state.dataModel;
    if(check){
      currentStateValue = await dbHelper.fetchAllData();
      emit(DbStateCubit(dataModel: currentStateValue));
    }
  }

  // Delete data from database
  deleteData({required int noteId}) async {
    bool check = await dbHelper.deleteNote(id: noteId);
    var currentStateValue = state.dataModel;
    if(check){
      currentStateValue = await dbHelper.fetchAllData();
      emit(DbStateCubit(dataModel: currentStateValue));
    }
  }

}