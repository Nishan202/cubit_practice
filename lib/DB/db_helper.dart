import 'package:cubit_practice/DB/data_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {

  // glbal static variable for table and columns
  static final String NOTE_TABLE = 'note';
  static final String COLUMN_NOTE_ID = 'note_id';
  static final String COLUMN_NOTE_TITLE = 'note_title';
  static final String COLUMN_NOTE_DESC = 'note_description';

// to privatize the constructor
  DBHelper._();

// Singleton Object
  static DBHelper getInstense() => DBHelper._();

  Database? mDB;

  Future<Database> getDB () async {
    // if(mDB != null){
    //   return mDB!;
    // } else {
    //   mDB = await openDB();
    //   return mDB!;
    // }
    // ? : Else -> This is more sorter version than previous
    // return mDB!= null ? mDB! : await openDB();
    // we can make it one line -> This is most sorter version
    return mDB ??= await openDB();
  }
  // Step 1 -> Open DB if created ?? then open, if Not then first create DB then open
  Future<Database> openDB()async{
    var appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "mainDB.db");
    return await openDatabase(dbPath,version: 1, onCreate: (db , version){
      db.execute(
        'CREATE TABLE $NOTE_TABLE ($COLUMN_NOTE_ID INTEGER PRIMARY KEY AUTOINCREMENT, $COLUMN_NOTE_TITLE TEXT, $COLUMN_NOTE_DESC TEXT)'
      );
    });
  }

// Add data in Database
  Future<bool> addNote ({required DataModel newNote}) async {
    var db = await getDB();

    int rowsEffected = await db.insert(NOTE_TABLE, newNote.toMap());
    return rowsEffected > 0;
  }

// Update data in Database
  Future<bool> updateNote ({required DataModel updateNote}) async {
    var db = await getDB();

    int rowsEffected = await db.update(NOTE_TABLE, updateNote.toMap(), where: "$COLUMN_NOTE_ID = ${updateNote.id}");
    return rowsEffected > 0;
  }

  // Delete data from Database
  Future<bool> deleteNote ({required int id}) async {
    var db = await getDB();

    int rowsEffected = await db.delete(NOTE_TABLE , where: "$COLUMN_NOTE_ID = $id");
    return rowsEffected > 0;
  }

// Fetch data from Database
  Future<List<DataModel>> fetchAllData() async {
    var db = await getDB();
    List<Map<String, dynamic>> mData = await db.query(NOTE_TABLE);
    List<DataModel> mNotes = [];
    for(int i=0; i<mData.length; i++){
      DataModel dataModel = DataModel.fromMap(mData[i]);
      mNotes.add(dataModel);
    }

    return mNotes;
  }
}