// ignore_for_file: public_member_api_docs

import 'dart:convert';

import 'package:i_detect/models/efotainer.dart';
import 'package:i_detect/utils/clients/graph_ql_operation_handler.dart';

abstract interface class DatabaseService {
  Future<Efotainer> get data;

  Future<List<Efotainer>> get history;
}

final class AmazonDynamoDBService
    with GraphQLOperationHandler
    implements DatabaseService {
  @override
  Future<Efotainer> get data =>
      handleGraphQLOperation<Efotainer, Map<String, dynamic>>(
        graphQLDocument: '',
        actualDataResidenceKey: '',
        handler: Efotainer.fromJson,
      );

  @override
  Future<List<Efotainer>> get history =>
      handleGraphQLOperation<List<Efotainer>, List<dynamic>>(
        graphQLDocument: '',
        actualDataResidenceKey: '',
        handler: (jsonList) => jsonList
            .map(
              (json) => Efotainer.fromJson(
                json as Map<String, dynamic>,
              ),
            )
            .toList(),
      );
}
