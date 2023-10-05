// ignore_for_file: public_member_api_docs

import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:i_detect/resources/strings.dart';

mixin class GraphQLOperationHandler {
  Future<T1> handleGraphQLOperation<T1, T2>({
    required String graphQLDocument,
    required String actualDataResidenceKey,
    required Function1<T2, T1> handler,
  }) async {
    final graphQLOperation = Amplify.API.query<String>(
      request: GraphQLRequest<String>(
        document: graphQLDocument,
      ),
    );

    final graphQLResponse = await graphQLOperation.response;

    final data = graphQLResponse.data;

    if (data == null) {
      throw Exception(
        noData,
      );
    }

    final json = jsonDecode(data) as Map<String, dynamic>;

    final maybeJson = json[actualDataResidenceKey] as T2;

    return handler(maybeJson);
  }
}
