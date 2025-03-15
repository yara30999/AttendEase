import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'app/di.dart';
import 'app/functions.dart';
import 'app/my_app.dart';
import 'firebase_options.dart';
import 'presentation/01_auth_screens/view_model/auth_bloc/auth_bloc.dart';
import 'presentation/02_home_screens/view_model/theme_bloc/theme_bloc.dart';
import 'presentation/resourses/language_manager.dart';
import 'simple_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getTemporaryDirectory()).path,
    ),
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Bloc.observer = SimpleObserver();
  await initAppModule();
  await Hive.initFlutter();
  hiveAdapters();
  await hiveBoxes();
  runApp(
    EasyLocalization(
      supportedLocales: [
        LocalizationUtils.englishLocal,
        LocalizationUtils.arabicLocal,
      ],
      path: 'assets/lang',
      fallbackLocale: LocalizationUtils.englishLocal,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (_) => AuthBloc(instance(), instance(), instance(), instance()),
          ),
          BlocProvider(create: (_) => ThemeBloc(instance())..add(LoadTheme())),
        ],
        child: const MyApp(),
      ),
    ),
  );
}
