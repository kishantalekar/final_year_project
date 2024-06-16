import 'package:final_year_project/bindings/general_bindings.dart';
import 'package:final_year_project/utils/constants/colors.dart';
import 'package:final_year_project/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GeneralBindings(),
      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,

      home: const Scaffold(
          backgroundColor: TColors.primary,
          body: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          )),
      // home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
