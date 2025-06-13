import 'dart:async';

import 'package:civix_teams/constants.dart';
import 'package:civix_teams/core/helper_functions/background_not_handler.dart';
import 'package:civix_teams/core/helper_functions/on_generate_routes.dart';
import 'package:civix_teams/core/services/custom_bloc_observer.dart';
import 'package:civix_teams/core/services/firebase_notification_service.dart';
import 'package:civix_teams/core/services/get_it_service.dart';
import 'package:civix_teams/core/services/shared_prefrences_singleton.dart';
import 'package:civix_teams/core/utils/app_colors.dart';
import 'package:civix_teams/features/notifications/data/models/notification_model.dart';
import 'package:civix_teams/features/splash/presentation/views/splash_view.dart';
import 'package:civix_teams/firebase_options.dart';
import 'package:civix_teams/language/lang_cubit.dart';
import 'package:civix_teams/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseNotificationService.initialize();

  // await Hive.initFlutter();
  // if (!Hive.isAdapterRegistered(0)) {
  //   Hive.registerAdapter(NotificationModelAdapter());
  // }
  // await Hive.openBox<NotificationModel>(kNotificationsBox);
  Bloc.observer = CustomBlocObserver();
  setupGetIt();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

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
            debugShowCheckedModeBanner: false,
            locale: locale,
            title: 'Civix Teams',

            theme: AppThemes.lightTheme, // Light theme
            darkTheme: AppThemes.darkTheme, // Dark theme
            themeMode: ThemeMode.system,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            onGenerateRoute: onGenerateRoute,
            initialRoute: SplashView.routeName,
          );
        },
      ),
    );
  }
}
