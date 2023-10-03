// ignore_for_file: public_member_api_docs

import 'package:i_detect/resources/strings.dart';
import 'package:i_detect/utils/enums.dart' as enums;

final class GraphQLDocumentUtil {
  static String listEfotainerDataQueryDocument({
    List<enums.Field>? fields,
  }) =>
      '''
        query ListEfotainerDataQuery {
          listEfotainerData {
            id
            ${fields == null || fields.contains(enums.Field.name) ? name : emptyString}
            ${fields == null || fields.contains(enums.Field.timestamp) ? timestamp : emptyString}
            ${fields == null || fields.contains(enums.Field.battery) ? battery : emptyString}
            ${fields == null || fields.contains(enums.Field.hash) || fields.contains(enums.Field.position) ? coordinates + whiteSpace + openingCurlyBrace : emptyString}
            ${fields == null || fields.contains(enums.Field.hash) ? tabSpace + hash : emptyString}
            ${fields == null || fields.contains(enums.Field.position) ? tabSpace + position : emptyString}
            ${fields == null || fields.contains(enums.Field.hash) || fields.contains(enums.Field.position) ? coordinates + whiteSpace + closingCurlyBrace : emptyString}
            ${fields == null || fields.contains(enums.Field.humidity) ? humidity : emptyString}
            ${fields == null || fields.contains(enums.Field.temperature) ? temperature : emptyString}
          }
        }
      ''';
}
