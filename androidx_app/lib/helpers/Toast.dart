import 'package:flutter/material.dart';

class ToastHelper {
    static void showToast(BuildContext context, String message){
        Scaffold.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    message,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                    ),
                ),
                action: SnackBarAction(
                    label: "CERRAR",
                    onPressed: (){}
                )
            )
        );
    }
}