import 'package:Turistas/graphql/Types.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AuthHelper {
    static QueryOptions signInOptions(LoginData loginData){
        return QueryOptions(
            document: r'''
                query Login($email: String!, $password: String!){
                    Login(email: $email, password: $password){
                        message isSuccess
                    }
                }
            ''',
            variables: <String, String>{
                "email": loginData.email,
                "password": loginData.password
            }, // Always has to be network only
            fetchPolicy: FetchPolicy.networkOnly
        );
    }

    static MutationOptions signUpOptions(SignUpData signUpData){
        return MutationOptions(
            document: r'''
                mutation User($user: UserInput!){
                    User(user: $user){
                        message isSuccess token
                    }
                }
            ''',
            variables: <String, dynamic>{
                "user": signUpData.getData() // Gat all data stored
            },
            fetchPolicy: FetchPolicy.networkOnly
        );
    }
}