class LoginData {
    String email;
    String password;
}

class _User {
    String name;
    String lastName;
    String email;
    String password;
}

class SignUpData extends _User {
    Map<String, String> getData(){
        return <String, String>{
            "name": this.name,
            "lastName": this.lastName,
            "email": this.email,
            "password": this.password
        };
    }
}

class UserData extends _User {
    String _id;
    String picture;
}