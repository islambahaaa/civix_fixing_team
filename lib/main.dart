import 'package:civix_teams/core/helper_functions/on_generate_routes.dart';
import 'package:civix_teams/core/services/custom_bloc_observer.dart';
import 'package:civix_teams/core/services/get_it_service.dart';
import 'package:civix_teams/core/services/shared_prefrences_singleton.dart';
import 'package:civix_teams/core/utils/app_colors.dart';
import 'package:civix_teams/features/splash/presentation/views/splash_view.dart';
import 'package:civix_teams/language/lang_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = CustomBlocObserver();
  await Prefs.init();
  setupGetIt();
  runApp(const CivixTeamsApp());
}

class CivixTeamsApp extends StatelessWidget {
  const CivixTeamsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit()..loadSavedLanguage(),
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            locale: locale,
            title: 'Civix Teams',
            theme: ThemeData(
              fontFamily: 'Cairo',
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primaryColor,
              ),
              scaffoldBackgroundColor: Colors.white,
            ),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            onGenerateRoute: onGenerateRoute,
            initialRoute: SplashView.routeName,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
