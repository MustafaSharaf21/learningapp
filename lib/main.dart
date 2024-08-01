import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learningapp/generated/l10n.dart';
import 'package:learningapp/screen/home_screen.dart';
import 'package:learningapp/screen/login_screen.dart';
import 'package:learningapp/screen/profile/profile.dart';
import 'package:learningapp/screen/profile/profile_screen.dart';
import 'package:learningapp/screen/register1_screen.dart';
import 'package:learningapp/screen/shared/shared.dart';
import 'package:learningapp/screen/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:learningapp/screen/testMySelf/creat_questions.dart';
import 'LanguageCubit/language_cubit.dart';
import 'feuture/OnBoarding/presentation/on_boarding_view.dart';
import 'screen/category_screen.dart';
import 'screen/my_constants.dart';
import 'screen/profile/update_profile_screen.dart';
import 'screen/testMySelf/test_myself.dart';
import 'screen/welcome_screen.dart';


/*

void main() {
  runApp(const LearningApp());
}

class LearningApp extends StatefulWidget {
  const LearningApp({super.key});
  @override
  State<LearningApp> createState() => _LearningAppState();
}

class _LearningAppState extends State<LearningApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor:const  Color(0xFF399679
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        profilepage.id: (context) => profilepage(),
        RegisterPage.id: (context) => RegisterPage(),
        LoginPage.id: (context) => LoginPage(),
        HomePage.id:(context)=> HomePage(),
        SplashPage.id:(context)=> SplashPage(),
        Category.id:(context)=> Category(),
        TestMySelf.id:(context)=> TestMySelf(),
        myContents.id:(context)=> myContents(),
        welcomeScreen.id:(context)=> welcomeScreen(),

      },
      initialRoute:welcomeScreen.id,
      locale: Locale('en'),
      localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,


    );
  }
}
*/
void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await CacheNetwork.cacheInitialization();

  runApp(
    BlocProvider(
      create: (context) => LanguageCubit(),
      child: const LearningApp(),
    ),
  );
}

class LearningApp extends StatefulWidget {
  const LearningApp({super.key});

  @override
  State<LearningApp> createState() => _LearningAppState();
}

class _LearningAppState extends State<LearningApp> {
  @override
  void initState() {
    BlocProvider.of<LanguageCubit>(context).loadLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        return GetMaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF399679),
            ),
          ),
          debugShowCheckedModeBanner: false,
          routes: {
            Profile.id: (context) => const Profile(),
            profilepage.id: (context) => const profilepage(),
            RegisterPage.id: (context) => RegisterPage(),
            LoginPage.id: (context) => LoginPage(),
            HomePage.id: (context) => HomePage(),
            SplashPage.id: (context) => const SplashPage(),
            Category.id: (context) => const Category(),
            TestMySelf.id: (context) => const TestMySelf(),
            myContents.id: (context) => const myContents(),
            welcomeScreen.id: (context) => const welcomeScreen(),
            OnBoardingView.id: (context) => const OnBoardingView(),
          },
          initialRoute: welcomeScreen.id,
          locale: state is LanguageSuccess ? Locale(state.language) : null,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
        );
      },
    );
  }
}