import 'package:intl/intl.dart';

import '../utils/time_ago.dart';

class TimeFormatter{
  utcToLocalReviewsDate(var date) {
    DateTime dateTime = DateFormat("yyyy-MM-dd hh:mm:ss").parse(date, true).toLocal();
    var df = DateFormat('dd MMMM yyyy').format(dateTime);
    return df;
  }

  utcToLocalReviewsDateTime(var date) {
    DateTime dateTime = DateFormat("yyyy-MM-dd hh:mm:ss").parse(date, true).toLocal();
    var df = DateFormat('dd MMMM yyyy hh:mm:ss a').format(dateTime);
    return df;
  }

  utcToLocalLatestNewsDate(var date) {
    DateTime dateTime = DateFormat("yyyy-MM-dd hh:mm:ss").parse(date, true).toLocal();
    var df = DateFormat('dd MMM yyyy').format(dateTime);
    return df;
  }

  utCtoGMT(var dates) {
    var date = DateFormat("yyyy-MM-dd").format(DateTime.parse(dates).toUtc());
    return date;
  }

  timeNow(var date) {
    DateTime dateTime = DateFormat("yyyy-MM-dd hh:mm:ss").parse(date, true).toLocal();
    var df = TimeAgo.timeAgoSinceDate(dateTime.toString());
    return df;
  }



convertTimeToLocal({dateString, dateFormat}) {
  if (dateString != null && dateString != "") {
    var strToDateTime = DateTime.parse('${dateString}Z');
    final convertLocal = strToDateTime.toLocal();
    DateFormat newFormat = DateFormat(dateFormat ?? "MM.dd.yyyy");
    return newFormat.format(convertLocal);
  }
}

 formatTime(Duration duration) {
   twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));

  return [
    if (duration.inHours > 0) hours,
    minutes,
    seconds,
  ].join(':');
}

}