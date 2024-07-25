import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';

class SettingScreen extends StatelessWidget {
  static const String routeName = "/setting_screen";

  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: primaryColor,
      ),
      body: Consumer<PreferencesProvider>(
        builder: (context, preferences, child) {
          return Material(
            child: ListTile(
              tileColor: primaryColor,
              title: const Text("Restaurant Notification"),
              subtitle: const Text("Enable notification"),
              trailing: Consumer<SchedulingProvider>(
                builder: (context, scheduled, _) {
                  return Switch.adaptive(
                    activeColor: secondaryColor,
                    value: preferences.isActiveNotification,
                    onChanged: (value) async {
                      scheduled.scheduledNews(value);
                      preferences.enabledActiveNotification(value);
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
