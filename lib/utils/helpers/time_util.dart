// ignore_for_file: public_member_api_docs

import 'package:i_detect/resources/strings.dart';
import 'package:intl/intl.dart';

final class TimeUtil {
  static String computeDayMonthYear(
    num timestamp,
  ) =>
      DateFormat(dateFormatPattern).format(
        DateTime.fromMillisecondsSinceEpoch(
          timestamp.toInt(),
        ),
      );
}
