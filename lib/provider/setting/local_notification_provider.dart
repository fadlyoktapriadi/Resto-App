import 'package:flutter/widgets.dart';
import 'package:resto_app/services/local_notification_service.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationService flutterNotificationService;

  LocalNotificationProvider(this.flutterNotificationService);

  final int _notificationId = 1;
  bool? _permission = false;
  bool? get permission => _permission;

  bool _toggleDailyReminderStatus = false;
  bool get toggleDailyReminderStatus => _toggleDailyReminderStatus;

  Future<void> requestPermissions() async {
    _permission = await flutterNotificationService.requestPermissions();
    notifyListeners();
  }

  Future<void> cancelNotification() async {
    await flutterNotificationService.cancelNotification(_notificationId);
  }

  void dailyLunchNotification() {
    flutterNotificationService.dailyLunchNotification(
      id: _notificationId,
    );
  }

  void toggleDailyNotification() {
    _toggleDailyReminderStatus = !_toggleDailyReminderStatus;
    if (_toggleDailyReminderStatus) {
      dailyLunchNotification();
    } else {
      cancelNotification();
    }
    notifyListeners();
  }

}
