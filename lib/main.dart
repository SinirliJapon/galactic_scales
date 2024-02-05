import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:galactic_scales/provider/quiz_provider.dart';
import 'package:galactic_scales/provider/space_object_provider.dart';
import 'package:galactic_scales/routes/app_router.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => QuizProvider()),
          ChangeNotifierProvider(create: (_) => SpaceObjectProvider()),
        ],
        child: const MyApp(),
      ),
    );
  });
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppRouter appRouter = AppRouter();
    return MaterialApp.router(
        routerConfig: appRouter.config(),
        debugShowCheckedModeBanner: false,
    );
  }
}
