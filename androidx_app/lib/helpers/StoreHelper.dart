import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StoreHelper {
    final FlutterSecureStorage _store = new FlutterSecureStorage();

    Future<String> getToken() async { // Return a saved token
        return await this._store.read(key: "token");
    }

    Future<void> setToken(String token) async { // Save a token
        await this._store.write(key: "token", value: token);
    }

    Future<void> cleanStore() async { // Clean the store
        await this._store.deleteAll();
    }
}

StoreHelper store = new StoreHelper();