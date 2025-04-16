import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/setting/local_notification_provider.dart';
import 'package:resto_app/provider/setting/shared_preferences_provider.dart';
import 'package:resto_app/services/local_notification_service.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {



  @override
  void dispose() {
    selectNotificationStream.close();
    super.dispose();
  }

  Future<void> _scheduleDailyTenAMNotification() async {
    context.read<LocalNotificationProvider>().scheduleDailyTenAMNotification();
  }

  Future<void> _toggleDailyNotification() async {
    context.read<LocalNotificationProvider>().toggleDailyNotification(
      context.read<LocalNotificationProvider>().toggleDailyReminderStatus,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<SharedPreferencesProvider>(context);
    final localNotificationProvider = Provider.of<LocalNotificationProvider>(context);

    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Resto App.',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    )
                ),
                const SizedBox(height: 8),
                Text("Settings",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12,),
                SwitchListTile(
                  title: const Text("Dark Mode"),
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme();
                  },
                ),
                SwitchListTile(
                  title: const Text("Lunch Reminder at 11:00 AM"),
                  value: localNotificationProvider.toggleDailyReminderStatus,
                  onChanged: (value) async {
                    if (value) {
                      await _toggleDailyNotification();
                    }
                  },
                ),

                ElevatedButton(
                  onPressed: () async {
                    await _requestPermission();
                  },
                  child: Consumer<LocalNotificationProvider>(
                    builder: (context, value, child) {
                      return Text(
                        "Request permission! (${value.permission})",
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _showNotification();
                  },
                  child: const Text(
                    "Show notification with payload and custom sound",
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _scheduleDailyTenAMNotification();
                  },
                  child: const Text(
                    "Schedule daily 10:00:00 am notification",
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _checkPendingNotificationRequests();
                  },
                  child: const Text(
                    "Check pending notifications",
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }

  Future<void> _requestPermission() async {
    context.read<LocalNotificationProvider>().requestPermissions();
  }

  Future<void> _showNotification() async {
    context.read<LocalNotificationProvider>().showNotification();
  }

  Future<void> _checkPendingNotificationRequests() async {
    // todo-03-action-02: check a pending notification
    final localNotificationProvider = context.read<LocalNotificationProvider>();
    await localNotificationProvider.checkPendingNotificationRequests(context);

    // todo-03-action-03: show a dialog to show a pending notification
    if (!mounted) {
      return;
    }

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // todo-03-action-04: show alert dialog with empty listview builder
        final pendingData = context.select(
                (LocalNotificationProvider provider) =>
            provider.pendingNotificationRequests);
        return AlertDialog(
          title: Text(
            '${pendingData.length} pending notification requests',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          content: SizedBox(
            height: 300,
            width: 300,
            child: ListView.builder(
              itemCount: pendingData.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                // todo-03-action-05: iterate a listtile
                final item = pendingData[index];
                return ListTile(
                  title: Text(
                    item.title ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    item.body ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  contentPadding: EdgeInsets.zero,
                  trailing: IconButton(
                    onPressed: () {
                      localNotificationProvider
                        ..cancelNotification(item.id)
                        ..checkPendingNotificationRequests(context);
                    },
                    icon: const Icon(Icons.delete_outline),
                  ),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }


}
