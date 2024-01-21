import 'package:flutter/material.dart';
import 'package:mvvm_theme_switching/res/app_theme.dart';
import 'package:mvvm_theme_switching/utils/LoggerHelpers.dart';
import 'package:mvvm_theme_switching/utils/routes/routes.dart';
import 'package:mvvm_theme_switching/utils/routes/routes_name.dart';
import 'package:mvvm_theme_switching/view/screens/demo_screen.dart';
import 'package:mvvm_theme_switching/view_model/theme_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ThemeViewModel theme = ThemeViewModel();
  await theme.getTheme();
  runApp(MyApp(theme: theme,));
}

class MyApp extends StatelessWidget {
  final ThemeViewModel theme;
  const MyApp({super.key, required this.theme});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => theme,)
      ],
      child: Consumer<ThemeViewModel>(
        builder: (context, provider, child)  {
          debugLog(provider.themeMode);
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: provider.themeMode,
              initialRoute: RoutesName.demo,
              onGenerateRoute:  Routes.generateRoute
          );
        }
      ),
    );
  }
}

