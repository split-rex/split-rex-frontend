import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:timezone/timezone.dart' as tz;
import '../common/const.dart';
import '../common/logger.dart';
import '../providers/auth.dart';
import '../providers/error.dart';
import '../providers/group_list.dart';
import 'notification.dart';

class ScheduledNotificationServices {
  String endpoint = getUrl();

  Future<void> getScheduledNotification(String token) async {
    Response resp = await get(
    Uri.parse("$endpoint/getNotif"),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    var data = jsonDecode(resp.body);
    logger.d(data);
    logger.d(data["data"]);
    if (data["message"] == "SUCCESS") {
      var notifications = data["data"]["notifications"];
      if (notifications != null) {
        try {
          for (var i = 0; i < notifications.length; i++) {
            var currNotif = notifications[i];
            var intervalSeconds = 0;
            var curTime = DateTime.now();
            var destinedTime = DateTime.parse(currNotif["date"]);

            if (curTime.isAfter(destinedTime)) {
              intervalSeconds = 1;
            } else {
              intervalSeconds = destinedTime.difference(curTime).inSeconds;
            }

            await flutterLocalNotificationsPlugin.zonedSchedule(
              currNotif["amount"].round(),
              "Let's settle up!",
              "Don't forget to pay Rp.${currNotif["amount"].toString()} to ${currNotif["name"]} in group '${currNotif["group_name"]}'",
              tz.TZDateTime.now(tz.local).add(Duration(seconds: intervalSeconds)),
              NotificationDetails(
                android: AndroidNotificationDetails(
                  "${currNotif["notif_id"]}", 
                  "Friend-ly Reminder",
                  color: const Color(0xFF5CC6BF),
                )
              ),
              uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
            );
          }
          await resolveScheduledNotification(token);
        } catch (error) {
          logger.d(error);
        }
      }
    } else {
    }
  }

  Future<void> resolveScheduledNotification(String token) async {
    await post(Uri.parse("$endpoint/deleteNotif"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    ).then((Response resp) {
      var data = jsonDecode(resp.body);
      logger.d(data);
    });
  }

  Future<void> insertScheduledNotifation(
    BuildContext context,
    WidgetRef ref,
    String userId,
    int amount,
    DateTime date,
  ) async {
    String groupId = ref.watch(groupListProvider).currGroup.groupId;
    String groupName = ref.watch(groupListProvider).currGroup.name;
    String name = ref.watch(authProvider).userData.name;

    Duration offset = date.timeZoneOffset;
    String dateTime = "${date.toIso8601String()}000";
    String utcHourOffset = (offset.isNegative ? '-' : '+') +
      offset.inHours.abs().toString().padLeft(2, '0');
    String utcMinuteOffset = (offset.inMinutes - offset.inHours * 60)
      .toString().padLeft(2, '0');
    String dateTimeWithOffset = '$dateTime$utcHourOffset:$utcMinuteOffset';
    
    logger.d(dateTimeWithOffset);

    var payload = {
      "user_id": userId,
      "group_id": groupId,
      "group_name": groupName,
      "amount": amount,
      "name": name,
      "date": dateTimeWithOffset
    };

    await post(Uri.parse("$endpoint/insertNotif"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ref.watch(authProvider).jwtToken}'
      },
      body: jsonEncode(payload)
    ).then((Response resp) {
      var data = jsonDecode(resp.body);
      logger.d(data);
      if (data["message"] == "SUCCESS") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Container(
            padding: const EdgeInsets.all(16),
            height: 70,
            decoration: const BoxDecoration(
                color: Color(0xFF6DC7BD),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Reminder set!",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Container(
            padding: const EdgeInsets.all(16),
            height: 70,
            decoration: const BoxDecoration(
                color: Color(0xFFF44336),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Unable to set reminder!",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ));
        ref.read(errorProvider).changeError(data["message"]);
      }
    });
  }
}