import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app/services/firebase_service.dart';
import 'app/utils/localization.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:country_codes/country_codes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CountryCodes.init(); // Optionally, you may provide a `Locale` to get countrie's localizadName
  CountryDetails details = CountryCodes.detailsForLocale();
  Locale locale = CountryCodes.getDeviceLocale()!;
  print(details.alpha2Code);
  print(locale.languageCode);
  print("XXXXXXXXXXXXXXXXXXXXXXXXXXxxx");
  await dotenv.load();
  await Firebase.initializeApp();
  FirebaseChatCore.instance
      .setConfig(const FirebaseChatCoreConfig(null, 'Rooms', 'Users'));
  await GetStorage.init();
  //NotificationService().initNotification();
  bool isUserLogin = await FirebaseService().checkUserAlreadyLogin();
  initializeDateFormatting(locale.languageCode, details.alpha2Code);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Application",
        initialRoute: isUserLogin ? AppPages.dashboard : AppPages.login,
        getPages: AppPages.routes,
        builder: EasyLoading.init(),
        localizationsDelegates: [
          FormBuilderLocalizations.delegate,
        ],
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            elevation: 2,
            color: Colors.white,
            iconTheme: IconThemeData(
                color: Colors
                    .black), // set backbutton color here which will reflect in all screens.
          ),
        ),
        locale: LocalizationService.locale,
        translations: LocalizationService()),
  );
}
