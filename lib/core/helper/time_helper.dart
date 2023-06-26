import 'package:cloud_firestore/cloud_firestore.dart';

class TimeHelper {

  static String formatTime(Timestamp timestamp) {
    final time = DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);

    final hour = time.hour > 12 
      ? (time.hour - 12).toString().padLeft(2, '0')
      : time.hour.toString().padLeft(2, '0');

    final minute = '${time.minute}'.padLeft(2, '0'); 
    final second = '${time.second}'.padLeft(2, '0');

    final amOrPm = time.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $amOrPm';
  }

  static String getLastSeen(Timestamp timestamp) {
   final lastSeen = timestamp.toDate(); // convert Timestamp to DateTime
    final now = DateTime.now(); // get current DateTime
    final difference = now.difference(lastSeen);

    if (difference.inMinutes < 1) {
      return ' just now';
    } else if (difference.inHours < 1) {
      return ' ${difference.inMinutes} min ago';
    } else if (difference.inDays < 1) {
      return ' ${difference.inHours} hour ago';
    } else if (difference.inDays < 30) {
      return difference.inDays > 1
          ? ' ${difference.inDays} days ago'
          : ' ${difference.inDays} day ago';
    }
    else if (difference.inDays < 365) {
      return difference.inDays > 1
          ? ' ${difference.inDays} months ago'
          : ' ${difference.inDays} month ago';
    } else {
      return difference.inDays
          .toString(); // fallback to timestamp if more than a week ago
    }
  }
}
