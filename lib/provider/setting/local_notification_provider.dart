import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:resto_app/services/local_notification_service.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationService flutterNotificationService;

  LocalNotificationProvider(this.flutterNotificationService);

  int _notificationId = 0;
  bool? _permission = false;
  bool? get permission => _permission;

  List<PendingNotificationRequest> pendingNotificationRequests = [];

  bool _toggleDailyReminderStatus = false;
  bool get toggleDailyReminderStatus => _toggleDailyReminderStatus;

  Future<void> requestPermissions() async {
    _permission = await flutterNotificationService.requestPermissions();
    notifyListeners();
  }

  void showNotification() {
    _notificationId += 1;
    flutterNotificationService.showNotification(
      id: _notificationId,
      title: "New Notification",
      body: "This is a new notification with id $_notificationId",
      payload: "This is a payload from notification with id $_notificationId",
    );
  }

  // todo-02-provider-02: create a schedule notification
  void scheduleDailyTenAMNotification() {
    _notificationId += 1;
    flutterNotificationService.scheduleDailyTenAMNotification(
      id: _notificationId,
    );
  }

  // todo-02-provider-03: show a list of pending notification
  Future<void> checkPendingNotificationRequests(BuildContext context) async {
    pendingNotificationRequests =
    await flutterNotificationService.pendingNotificationRequests();
    notifyListeners();
  }

  // todo-02-provider-04: cancel a notification
  Future<void> cancelNotification(int id) async {
    await flutterNotificationService.cancelNotification(id);
  }

  void toggleDailyNotification(bool isEnabled) {
    _toggleDailyReminderStatus = isEnabled;
    if (isEnabled) {
      scheduleDailyTenAMNotification();
    } else {
      cancelNotification(1); // Assuming ID 1 is used for the scheduled notification
    }
    debugPrint("TEST: $_toggleDailyReminderStatus");
    notifyListeners();
  }

}
