import 'package:cubit_practice/DB/db_helper.dart';

class DataModel {
  int id;
  String title;
  String description;

  DataModel({this.id = 0, required this.title, required this.description});

  // fromMap
  factory DataModel.fromMap(Map<String, dynamic> map){
    return DataModel(id: map[DBHelper.COLUMN_NOTE_ID], title: map[DBHelper.COLUMN_NOTE_TITLE], description: map[DBHelper.COLUMN_NOTE_DESC]);
  }

  // toMap -> when we need to return data as Map
  Map<String, dynamic> toMap (){
    return {
      DBHelper.COLUMN_NOTE_TITLE : title,
      DBHelper.COLUMN_NOTE_DESC : description
    };
  }

}