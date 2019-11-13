import 'package:validate/validate.dart';

class ValidatorsHelper {

    static String validateEmail(String email){
        try {
            Validate.isEmail(email); // If has no error is a valid email
            return null;
        } catch (e) {
            return "Introduce un email valido";
        }
    }

    static String validatePassword(String password){
        if(password.length < 6){
            return "La contraseña debe tener un minimo de 6 caracteres";
        }

        return null;
    }

    static String notEmpty(String value){
        try{
            Validate.notBlank(value);
            return null;
        }
        catch(error){
            return "Debes de llenar este campo";
        }
    }

    static String comparePassword(String password, String passwordConfirmation){
        if(password != passwordConfirmation){
            return "Las contraseñas no coinciden";
        }

        return null;
    }
}