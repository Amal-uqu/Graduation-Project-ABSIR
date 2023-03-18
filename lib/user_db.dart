import 'package:sqflite/sqflite.dart';
import 'package:ABSIR/user_model.dart';
import 'database.dart';

class UserDB{
  String colId = 'id';
  String colEmail = 'email';
  String colName = 'name';
  String colPassword = 'password';
  String userTable = 'userTable';
  
  Future<List<Map<String, dynamic>>> getUserMapList() async {
    Database? db =await DatabaseHelper.instance.db;
    final List<Map<String, dynamic>> result =await db!.query(userTable);  
    return result;
  }

  Future<List<User>> getUserList() async {
    final List<Map<String,dynamic>> userMapList = await getUserMapList();
    final List<User> userList =[];
    for (var userMap in userMapList) {
      userList.add(User.fromJson(userMap));
    }
    return userList;
  }


  Future<Map<String, dynamic>?> getUserMap(String email) async {
    Database? db =await DatabaseHelper.instance.db;
    final List<Map<String, dynamic>> result =await db!.query(userTable, where:'email = ?',whereArgs: [email],);
    if(result != null && result.isNotEmpty){
      return result[0];
    }
    return null;
  }

  Future<Map<String,dynamic>?> getUser(String email) async {
    final Map<String,dynamic>? userMap = await getUserMap(email);
    print(userMap );

    return userMap;
  }

  Future<int?>insertUser(User user) async{
    print('hellos');
    Database? db = await DatabaseHelper.instance.db;
    if (db==null)return null;
    final int result = await db.insert(userTable, user.toJson()); 
    return result;
  }

  Future<int> updateUser(User user) async {
    Database? db = await DatabaseHelper.instance.db;
    final int result = await db!.update(
      userTable,
      user.toJson(),
      where:'$colId = ?',
      whereArgs: [user.id],
    );
    return result;
  }

  Future<int> deleteUser(int id) async {
    Database? db = await DatabaseHelper.instance.db;
    final int result = await db!.delete(
      userTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
    return result;
  }

}