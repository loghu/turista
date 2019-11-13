import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
    Database _database;

    void setUpDatabase(){
        this._openDatabase();
    }

    Future<void> _openDatabase() async {
        this._database = await openDatabase("tourists.db");
        await this._createSessionTable();
        // await this._cleanTable("Session");
    }

    Future<void> _createSessionTable() async {
        // Create a table Session if doesn't exists
        await this._database.execute("CREATE TABLE IF NOT EXISTS Session(id INTEGER PRIMARY KEY, token TEXT)");
    }

    // Save a token
    Future<void> setToken(String token) async {
        List queryResult = await this._database.query("Session", where: "id=1");
        
        // Ensure to always store a token in the same row 
        if(queryResult.length > 0){
            await this._database.execute('UPDATE Session SET token="$token" WHERE id=1');
        }
        else {
            await this._database.execute('INSERT INTO Session(token) VALUES("$token")');
        }
    }

    // Get a token
    Future<String> getToken() async {
        try{
            List queryResult = await this._database.query("Session", where: "id=1");
            print(queryResult);
            return queryResult[0]["token"]; // Return a token
        } catch(e){ // there's not token then return null
            print("There is no token");
            return null;
        }
    }

    // For development only, will be removed later
    Future<void> _cleanTable(String table) async {
        await this._database.execute("DELETE FROM '$table'");
    }
}

// Once the app is started the database is opened
DatabaseHelper database = new DatabaseHelper();