import 'package:Turistas/graphql/Types.dart';
import 'package:Turistas/helpers/Auth.dart';
import 'package:Turistas/helpers/StoreHelper.dart';
import 'package:Turistas/helpers/Toast.dart';
import 'package:Turistas/helpers/Validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SignUp extends StatefulWidget {
    @override
    SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp>{
    final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();
    final GlobalKey<FormFieldState> _passwordConfKey = GlobalKey<FormFieldState>();
    GraphQLClient _client;
    bool _obscureText = true;
    SignUpData _signUpData = new SignUpData();
    
    void _initGraphQLClient(BuildContext context){
        _client = GraphQLProvider.of(context).value;
    }

    Widget build(BuildContext context){
        WidgetsBinding.instance.addPostFrameCallback((_) => this._initGraphQLClient(context));

        return Scaffold(
            backgroundColor: Color.fromARGB(255, 228, 71, 120),
            body: this._rootWidget(),
        );
    }

    Widget _rootWidget(){
        return Builder(
            builder: (BuildContext rootContext){
                return Stack(
                    children: <Widget>[
                        Align(
                            alignment: Alignment.center,
                            child: Container(
                                /* padding: EdgeInsets.fromLTRB(30,30,30,80), */
                                /* height: MediaQuery.of(context).size.height / 1.2, */
                                margin: EdgeInsets.fromLTRB(30, 24, 30, 50),
                                child: this._signUpForm()
                            ),
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: MaterialButton(
                                child: Text(
                                    "CONTINUAR",
                                    style: TextStyle(fontSize: 18)
                                ),
                                minWidth: MediaQuery.of(context).size.width,
                                    height: 50,
                                    color: Color.fromARGB(255, 226, 51, 100),
                                    textColor: Colors.white,
                                    onPressed: (){
                                        this._signUpKey.currentState.save();
                                        this._signUp(rootContext);
                                    }
                            ),
                        )
                    ]
                );
            },
        );
    }

    Widget _signUpForm(){
        return Form(
            key: this._signUpKey,
            child: ListView(
                children: <Widget>[
                    Text(
                        "App",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 50,
                            fontFamily: "DancingScript",
                            color: Colors.white
                        ),
                    ),
                    Divider(color: Color.fromARGB(0,0,0,0)),
                    TextFormField(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            border: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            errorBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            errorStyle: TextStyle(color: Colors.white),
                            labelText: "Nombre",
                            labelStyle: TextStyle(
                                color: Colors.white, fontSize: 18
                            )
                        ),
                        validator: ValidatorsHelper.notEmpty,
                        onSaved: (String value){
                            this._signUpData.name = value;
                        },
                    ),
                    Divider(color: Color.fromARGB(0,0,0,0)),
                    TextFormField(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            border: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            errorBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            errorStyle: TextStyle(color: Colors.white),
                            labelText: "Apellidos",
                            labelStyle: TextStyle(
                                color: Colors.white, fontSize: 18
                            )
                        ),
                        validator: ValidatorsHelper.notEmpty,
                        onSaved: (String value){
                            this._signUpData.lastName = value;
                        },
                    ),
                    Divider(color: Color.fromARGB(0,0,0,0)),
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            border: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            errorBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            errorStyle: TextStyle(color: Colors.white),
                            labelText: "Email",
                            labelStyle: TextStyle(
                                color: Colors.white, fontSize: 18
                            )
                        ),
                        validator: ValidatorsHelper.validateEmail,
                        onSaved: (String value){
                            this._signUpData.email = value;
                        },
                    ),
                    Divider(color: Color.fromARGB(0,0,0,0)),
                    TextFormField(
                        textAlign: TextAlign.center,
                        obscureText: this._obscureText,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            border: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            errorBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            errorStyle: TextStyle(color: Colors.white),
                            labelText: "Contraseña",
                            labelStyle: TextStyle(
                                color: Colors.white, fontSize: 18
                            ),
                            suffixIcon: IconButton(
                                icon: this._obscureText ? 
                                    Icon(Icons.remove_red_eye, color: Colors.white) :
                                    Icon(Icons.visibility_off, color: Colors.white),
                                onPressed: (){
                                    setState(() {
                                        this._obscureText = !this._obscureText;
                                    });
                                },
                            )
                        ),
                        validator: (String value){
                            String passwordMessage = ValidatorsHelper.validatePassword(value);
                            String errorMessage = passwordMessage == null ? 
                            ValidatorsHelper.comparePassword(value, this._passwordConfKey.currentState.value) : 
                            passwordMessage;

                            return errorMessage;
                        },
                        onSaved: (String value){
                            this._signUpData.password = value;
                        },
                    ),
                    Divider(color: Color.fromARGB(0,0,0,0)),
                    TextFormField(
                        key: this._passwordConfKey,
                        textAlign: TextAlign.center,
                        obscureText: this._obscureText, // show / hide password
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            border: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            errorBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            errorStyle: TextStyle(color: Colors.white),
                            labelText: "Confirma tu contraseña",
                            labelStyle: TextStyle(
                                color: Colors.white, fontSize: 18
                            ),
                            suffixIcon: IconButton(
                                icon: this._obscureText ? 
                                    Icon(Icons.remove_red_eye, color: Colors.white) :
                                    Icon(Icons.visibility_off, color: Colors.white),
                                onPressed: (){
                                    setState(() {
                                        this._obscureText = !this._obscureText;
                                    });
                                },
                            )
                        ),
                        validator: ValidatorsHelper.validatePassword,
                    ),
                    Divider(color: Color.fromARGB(0,0,0,0)),
                    Column(
                        children: <Widget>[
                            SignInButton(
                                Buttons.Facebook,
                                text: "Registro con Facebook",
                                onPressed: (){},
                            ),
                            SignInButton(
                                Buttons.Google,
                                text: "Registro con Google",
                                onPressed: (){},
                            ),
                            Container(
                                padding: EdgeInsets.fromLTRB(0, 16, 0, 15),
                                child: FlatButton(
                                    child: Text(
                                        "¿Ya tienes una cuenta? Inicia sesión",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18
                                        ),
                                    ),
                                    onPressed: (){
                                        Navigator.pop(context);
                                    },
                                ),
                            )
                        ],
                    )
                ]
            ),
        );
    }

    void _signUp(BuildContext context) async {
        if(this._signUpKey.currentState.validate()){
            QueryResult result = await this._client.mutate(AuthHelper.signUpOptions(this._signUpData));
            if(result.data["User"]["isSuccess"]){
                // save token and go to favorite places
                String token = result.data["User"]["token"];
                await store.setToken(token); // Save token
                Navigator.pushReplacementNamed(context, "dashboard"); // Go to main view
            }
            else {
                ToastHelper.showToast(context, result.data["User"]["message"]);
            }
        }
    }
}