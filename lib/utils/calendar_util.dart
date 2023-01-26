import 'package:intl/intl.dart';

String getDateTime(DateTime date){
  return DateFormat.yMMMd('ko-KR').format(date);
}