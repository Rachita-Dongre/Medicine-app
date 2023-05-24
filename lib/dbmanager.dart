import 'dart:async';
import 'package:medicine_app/medicine.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBmanager {
  late Database _database;

  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(
        join(await getDatabasesPath(), 'medicine.db'),
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
            'CREATE TABLE Employee(id INTEGER PRIMARY KEY autoincrement, medicineName TEXT, Frequency TEXT, dosageAmount TEXT, medicineType TEXT, instructions TEXT)',
          );
        },
      );
    }
  }

  //function to insert medicine in the database
  Future<int> insertMedicine(Medicine medicine) async {
    await openDb();
    return await _database.insert('Medicine', medicine.toMap());
  }

  //function to get information of medicine from database
  Future<List<Medicine>> getMedicineList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('Medicine');
    return List.generate(
      maps.length,
      (i) {
        return Medicine(
          id: maps[i]['id'],
          medicineName: maps[i]['Medicine name'],
          frequency: maps[i]['Frequency'],
          dosageAmount: maps[i]['Dosage Amount'],
          medicineType: maps[i]['Medicine Type'],
          instructions: maps[i]['Instructions'],
        );
      },
    );
  }

  //function to update the information of medicine in the database
  Future<int> updateMedicine(Medicine medicine) async {
    await openDb();
    return await _database.update('Medicine', medicine.toMap(),
        where: "id = ?", whereArgs: [medicine.id]);
  }

  //function to delete medicine from database
  Future<void> deleteMedicine(int id) async {
    await openDb();
    await _database.delete('Medicine', where: "id = ?", whereArgs: [id]);
  }
}
