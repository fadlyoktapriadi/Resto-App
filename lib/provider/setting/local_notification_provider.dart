import 'package:flutter/widgets.dart';
import 'package:resto_app/data/local/shared_preferences_service.dart';
import 'package:resto_app/services/local_notification_service.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationService flutterNotificationService;
  final SharedPreferencesService _sharedPreferencesService;

  LocalNotificationProvider(this.flutterNotificationService, this._sharedPreferencesService) {
    _loadLunchNotification();
  }

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

  void toggleDailyNotification() async {
    _toggleDailyReminderStatus = !_toggleDailyReminderStatus;
    if (_toggleDailyReminderStatus) {
      await _sharedPreferencesService.setThemeMode(_toggleDailyReminderStatus);
      dailyLunchNotification();
    } else {
      cancelNotification();
    }
    notifyListeners();
  }

  Future<void> _loadLunchNotification() async {
    _toggleDailyReminderStatus = await _sharedPreferencesService.getThemeMode();
    notifyListeners();
  }

  // Future<void> toggleTheme() async {
  //   _isDarkMode = !_isDarkMode;
  //
  //   notifyListeners();
  // }

}
