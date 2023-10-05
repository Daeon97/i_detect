// ignore_for_file: public_member_api_docs

import 'package:i_detect/models/efotainer.dart';
import 'package:i_detect/resources/strings.dart';
import 'package:i_detect/utils/clients/graph_ql_operation_handler.dart';
import 'package:i_detect/utils/enums.dart' as enums;
import 'package:i_detect/utils/helpers/graph_ql_document_util.dart';

abstract interface class DatabaseService {
  Future<Efotainer> getData({
    List<enums.Field>? fields,
  });

  Future<List<Efotainer>> getHistory({
    List<enums.Field>? fields,
  });
}

final class AmazonDynamoDBService
    with GraphQLOperationHandler
    implements DatabaseService {
  @override
  Future<Efotainer> getData({
    List<enums.Field>? fields,
  }) =>
      handleGraphQLOperation<Efotainer, Map<String, dynamic>>(
        graphQLDocument: GraphQLDocumentUtil.getDataQueryDocument(
          fields: fields,
        ),
        actualDataResidenceKey: getDataKey,
        handler: Efotainer.fromJson,
      );

  @override
  Future<List<Efotainer>> getHistory({
    List<enums.Field>? fields,
  }) =>
      handleGraphQLOperation<List<Efotainer>, List<dynamic>>(
        graphQLDocument: GraphQLDocumentUtil.getHistoryQueryDocument(
          fields: fields,
        ),
        actualDataResidenceKey: getHistoryKey,
        handler: (jsonList) => jsonList
            .map(
              (json) => Efotainer.fromJson(
                json as Map<String, dynamic>,
              ),
            )
            .toList(),
      );
}
