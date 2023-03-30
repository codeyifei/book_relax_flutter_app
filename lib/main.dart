import 'package:book_relax_flutter_app/constants/route.dart';
import 'package:book_relax_flutter_app/constants/theme.dart';
import 'package:book_relax_flutter_app/state/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initServices();

  runApp(const MyApp());
}

Future<void> initServices() async {
  await FlutterConfig.loadEnvVariables();

  await Get.putAsync(() async => await SharedPreferences.getInstance());
  Get.lazyPut(() => AuthState());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '书悠',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      initialRoute: AppPath.home.path,
      routes: AppRoute.routes(),
      builder: (context, child) {
        return AnnotatedRegion(
          value: ThemeConstant.overlayStyle,
          child: child!,
        );
      },
    );
  }
}

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
