import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webtoon_explorer_app/constants/global_variables.dart';
import 'package:webtoon_explorer_app/provider/ranking_provider.dart';
import 'package:webtoon_explorer_app/screens/components/nav_bar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RankingProvider>(
            create: (context) => RankingProvider("all", 8))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          colorScheme: const ColorScheme.light(
            primary: Colors.black,
          ),
          elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
              // textStyle: WidgetStatePropertyAll(
              //   TextStyle(color: Colors.black),
              // ),
              backgroundColor: WidgetStatePropertyAll(
                GlobalVariables.secondaryColor,
              ),
            ),
          ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
        ),
        home: NavBar(),
      ),
    );
  }
}
