

import 'package:flutter/material.dart';
import 'package:mvvm_theme_switching/utils/routes/routes_name.dart';
import 'package:mvvm_theme_switching/view/screens/demo_screen.dart';
import 'package:mvvm_theme_switching/view/screens/login_screen.dart';

class  Routes{
  static Route<dynamic>
  generateRoute(RouteSettings settings){

    switch(settings.name){
      case RoutesName.demo:
        return MaterialPageRoute(builder: (context) => const DemoScreen(),);
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => const LoginView(),);
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text("No route Defined"),
            ),
          );
        },);
    }
  }
}


