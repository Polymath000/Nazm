import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do/Features/onboarding/presentation/views/onboarding_view.dart';
import 'package:to_do/firebase_options.dart';

import 'Features/home/presentation/views/tasks_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MainApp(
    savedThemeMode: savedThemeMode,
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.savedThemeMode});
  final AdaptiveThemeMode? savedThemeMode;

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      debugShowFloatingThemeButton: true,
      light: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.blue,
      ),
      dark: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
      ),
      builder: (theme, darkTheme) => MaterialApp(
        
        theme: theme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        // home: TasksView(),
        home: const onboarding(),
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
    );
  }
}
