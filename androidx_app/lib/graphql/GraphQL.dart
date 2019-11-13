import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CustomGraphQLClient {
    ValueNotifier<GraphQLClient> client;
    
    startClient(){
        final HttpLink httpLink = HttpLink(
            // uri: "http://192.168.1.118:7000/graphql"
            uri: "https://tourists-app.herokuapp.com/graphql" // Heroku url
        );

        final AuthLink authLink = AuthLink( // jwt token
            getToken: () async => ""
        );

        final Link link = authLink.concat(httpLink);

        this.client = ValueNotifier(
            GraphQLClient(
                cache: InMemoryCache(),
                link: link
            )
        );
    }
}