import 'package:Turistas/auth/signup.dart';
import 'package:Turistas/dashboard/dashboard.dart';
import 'package:Turistas/dashboard/permiso.dart';
import 'package:Turistas/graphql/GraphQL.dart';
import 'package:Turistas/helpers/DatabaseHelper.dart';
import 'package:Turistas/helpers/JwtDecoder.dart';
import 'package:Turistas/helpers/StoreHelper.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:permission/permission.dart';
import 'auth/signin.dart';
CustomGraphQLClient client = new CustomGraphQLClient();
bool _isExpired = true;

void main() async {
  database.setUpDatabase();
  client.startClient(); // start GraphQL
  _isExpired = JwtHelper.isExpired(await store.getToken()); // Is there a valid token ?
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client.client, // graphql client
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Dashboard()/*Permiso()*//*MapScreen()*/,
        /*SignIn(),
        routes: {
          "signIn": (context) => SignIn(),
          "signUp": (context) => SignUp(),
          "dashboard": (context) => Dashboard()
        },*/
      ),
    );
  }
}

/*
    Clasificaciones de los lugares

    Comida
        Restaurantes
        café
    Parques
    Museos
    Centros comerciales
    Hoteles
    Bares
 */