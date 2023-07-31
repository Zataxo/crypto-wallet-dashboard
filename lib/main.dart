import 'package:crypto_statistics/utils/util_logic.dart';
import 'package:crypto_statistics/view/login_screen_view.dart';
import 'package:crypto_statistics/view_model/dashboard_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Dashboard());
}

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UtilLogic(),
        ),
        ChangeNotifierProvider(
          create: (_) => DashboardViewModel(),
        ),
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Crypto Dashboard',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: const Color(0xffFFFFFF),
          ),
          home: const LoginScreenView(),
        );
      }),
    );
  }
}
