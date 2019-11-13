import 'package:Turistas/graphql/Types.dart';
import 'package:Turistas/helpers/Auth.dart';
import 'package:Turistas/helpers/JwtDecoder.dart';
import 'package:Turistas/helpers/StoreHelper.dart';
import 'package:Turistas/helpers/Toast.dart';
import 'package:Turistas/helpers/Validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SignIn extends StatefulWidget {
    @override
    SignInState createState() => SignInState();
}

class SignInState extends State<SignIn>{
    final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    final FacebookLogin _facebookLogin = new FacebookLogin(); // Login handler
    GraphQLClient client;
    LoginData _loginData = new LoginData();
    bool _obscureText = true;
    bool _isTokenExpired = true;
    String _token = "";

    @override
    initState(){
        super.initState();
        this._verifyToken();
    }
    
    Widget build(BuildContext context){
        WidgetsBinding.instance.addPostFrameCallback((_) => initGraphQLClient(context));
        
        return Scaffold(
            backgroundColor: Color.fromARGB(255, 228, 71, 120),
            body: this._rootWidget(),
            key: this._scaffoldKey,
        );
    }

    Widget _rootWidget(){
        return Builder(
            builder: (scaffoldContext){
                return Stack(
                    children: <Widget>[
                        Align(
                            alignment: Alignment.center,
                            child: Container(
                                /* color: Colors.black, */
                                /* padding: EdgeInsets.all(30), */
                                margin: EdgeInsets.fromLTRB(30, 24, 30, 50),
                                height: MediaQuery.of(context).size.height / 1.2,
                                child: this._signInForm()
                            ),
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: MaterialButton(
                                child: Text(
                                    "INICIAR SESIÓN", 
                                    style: TextStyle(
                                        fontSize: 18
                                    )
                                ),
                                minWidth: MediaQuery.of(context).size.width,
                                height: 50,
                                color: Color.fromARGB(255, 226, 51, 100),
                                textColor: Colors.white,
                                onPressed: (){
                                    this._signIn(scaffoldContext);
                                    // this.showToast(scaffoldContext);
                                    // Scaffold.of(scaffoldContext).showSnackBar();
                                }
                            ),
                        )
                    ],
                );
            },
        );
    }

    Widget _signInForm(){
        return Form(
            key: _loginKey,
            child: ListView(
                children: <Widget>[
                    Text(
                        "App", 
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontFamily: "DancingScript"
                        ),
                        textAlign: TextAlign.center,
                    ),
                    Divider(color: Color.fromARGB(0,0,0,0), height: 32),
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white
                        ),
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            enabledBorder: const OutlineInputBorder(
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
                                color: Colors.white
                            ),
                        ),
                        validator: ValidatorsHelper.validateEmail,
                        onSaved: (String value) => this._loginData.email = value,
                        /* validator: ValidatorsHelper.validateEmail("ksalk"), */
                        // validator: Validate.isEmail("input"),
                    ),
                    Divider(color: Color.fromARGB(0,0,0,0)),
                    TextFormField(
                        autocorrect: false,
                        textAlign: TextAlign.center,
                        obscureText: this._obscureText,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            errorBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            errorStyle: TextStyle(color: Colors.white),
                            labelText: "Password",
                            labelStyle: TextStyle(
                                color: Colors.white
                            ),
                            suffixIcon: IconButton(
                                icon: this._obscureText ? 
                                    Icon(Icons.remove_red_eye,color: Colors.white) : 
                                    Icon(Icons.visibility_off, color: Colors.white),
                                onPressed: (){
                                    setState(() {
                                        this._obscureText = !this._obscureText;
                                    });
                                },
                            )
                        ),
                        validator: ValidatorsHelper.validatePassword,
                        onSaved: (String value) => this._loginData.password = value
                    ),
                    Divider(color: Color.fromARGB(0,0,0,0)),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                            SignInButton(
                                Buttons.Facebook,
                                text: "Inicia sesión con Facebook",
                                onPressed: () async {
                                    var user = await this._facebookLogin.logIn(["email"]);
                                    print(user.accessToken.token);
                                },
                            ),
                            SignInButton(
                                Buttons.Google,
                                text: "Inicia sesión con Google",
                                onPressed: () => {},
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                                child: FlatButton(
                                    child: Text(
                                        "¿No tienes una cuenta? Registro",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18
                                        ),
                                    ),
                                    onPressed: (){
                                        Navigator.pushNamed(context, "signUp");
                                    },
                                ),
                            )
                        ],
                    )
                ],
            ),
        );
    }

    void initGraphQLClient(BuildContext context){
        client = GraphQLProvider.of(context).value;
    }

    void _verifyToken() async {
        this._token = await store.getToken(); // Get token from store
        this._isTokenExpired = JwtHelper.isExpired(this._token); // Verify the session. Is a valid token?

        if(!this._isTokenExpired){
            Navigator.pushReplacementNamed(this._scaffoldKey.currentContext, "dashboard");
        }
    }

    void _signIn(BuildContext context) async {
        if(this._loginKey.currentState.validate()){
            this._loginKey.currentState.save();
            // Make a query 
            QueryResult result = await this.client.query(AuthHelper.signInOptions(this._loginData));

            // If the email and password are valid then the token has to be saved
            if(result.data["Login"]["isSuccess"]){
                ToastHelper.showToast(context, "Inicio de sesión con exito");
                String token = result.data["Login"]["message"];
                await store.setToken(token); // Save token
                Navigator.pushReplacementNamed(context, "dashboard"); // Go to main view
            }
            else { // If either email or password are invalid then show a message
                ToastHelper.showToast(context, result.data["Login"]["message"]);
            }
        }
    }
}