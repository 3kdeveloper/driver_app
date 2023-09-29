import 'core/constants/exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  checkInternetConnection();
  initMessaging();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    platform = Theme.of(context).platform;
    return GestureDetector(
        onTap: () => _unFocusKeyboard(context),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Awii app',
          theme: ThemeData(
              fontFamily: GoogleFonts.poppins().fontFamily,
              primaryColor: buttonColor),
          initialRoute: RouteNames.loadingScreen,
          onGenerateRoute: AppRouter().generateRoute,
        ));
  }

  //On Focus keyboard on touching anywhere on the screen.
  void _unFocusKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
