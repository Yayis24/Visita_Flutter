import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Datavisit {
  static Future<Database> openDB() async {
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      onCreate: (db, version) {
        db.execute('''CREATE TABLE visit (
              id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
              name TEXT,
              date DATE,
              amount INTEGER,
              user_id INTEGER,
              status TEXT DEFAULT 'pendiente' -- Agregar el campo de estado y establecerlo en 'pendiente' por defecto
            )
          ''');

        db.execute(
            'CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, username TEXT, password TEXT, role TEXT)');

        // Insertar el administrador por defecto
        db.insert('users', {
          'username': 'admin',
          'password':
              '12345', // Asegúrate de encriptar la contraseña antes de guardarla
          'role': 'admin',
        });
      },
      version: 5,
    );
    return database;
  }

  // Agrega esta función para eliminar una visita por su ID
  static Future<void> deleteVisit(int id) async {
    Database database = await openDB();
    await database.delete('visit', where: 'id = ?', whereArgs: [id]);
    database.close();
  }

  //FUNCION DE REGISTROS DE USUARIOS
  static Future<void> insertUser(
      String username, String password, String role) async {
    Database database = await openDB();
    await database.insert('users', {
      'username': username,
      'password': password,
      'role': role,
    });
    database.close();
  }

  // FUNCION VALIDACION DE CREDENCIALES

  static Future<Map<String, dynamic>?> getUserByUsernameAndPassword(
      String username, String password) async {
    Database database = await openDB();
    List<Map<String, dynamic>> users = await database.query('users',
        where: 'username = ? AND password = ?',
        whereArgs: [username, password]);
    database.close();

    if (users.isNotEmpty) {
      return users.first;
    } else {
      return null;
    }
  }
}
