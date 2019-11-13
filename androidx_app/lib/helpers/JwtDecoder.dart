import 'dart:convert';

class JwtHelper {
    static Map<dynamic, dynamic> decodeToken(String token){
        try {
            final String payload = token.split(".")[1]; // Payload is where the data is
            String result = utf8.decode(base64Decode(payload)); // Parse payload to string
            Map<dynamic, dynamic> decodedToken = jsonDecode(result); // Parse payload to a Json like object (Map)
            return decodedToken; // return the decoded payload
        }
        catch(error){
            return null; // If there's an error return null.
        }
    }

    static bool isExpired(String token){
        try {
            final Map<dynamic, dynamic> decodedToken = decodeToken(token); // Decode token
            // Get expiration date of the token 
            final DateTime expirationDate = new DateTime.fromMillisecondsSinceEpoch(0).add(new Duration(seconds: decodedToken["exp"]));
            // If the current date is after the expiration date then the token is expired
            return new DateTime.now().isAfter(expirationDate);
        }
        catch(error){
            return true; // If there's an error return true (Expired).
        }
    }
}