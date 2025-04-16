import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/setting/SharedPreferecesProvider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

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
              ],
            ),
          )
      ),
    );
  }
}
