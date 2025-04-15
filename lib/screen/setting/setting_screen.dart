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

  // void _configureSelectNotificationSubject() {
  //   selectNotificationStream.stream.listen((String? payload) {
  //     context.read<PayloadProvider>().payload = payload;
  //     Navigator.pushNamed(context, MyRoute.detail.name, arguments: payload);
  //   });
  // }

  Future<void> _scheduleDailyTenAMNotification() async {
    context.read<LocalNotificationProvider>().scheduleDailyTenAMNotification();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<SharedPreferencesProvider>(context);

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
                ElevatedButton(
                  onPressed: () async {
                    await _scheduleDailyTenAMNotification();
                  },
                  child: const Text(
                    "Schedule daily 10:00:00 am notification",
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
