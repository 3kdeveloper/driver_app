import 'package:awii/core/constants/exports.dart';
import 'package:http/http.dart' as http;

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

dynamic package;

class _LoadingPageState extends State<LoadingPage> {
  String dot = '.';
  bool updateAvailable = false;
  dynamic _version;
  bool _isLoading = false;

  @override
  void initState() {
    getLanguageDone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: ColorsResource.primaryColor,
        body: Stack(
          children: [
            SizedBox(
              height: context.h,
              width: context.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(context.w * 0.01),
                    width: context.w * 0.55,
                    height: context.w * 0.55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: const DecorationImage(
                            image: AssetImage(ImagesResource.splashLogo),
                            fit: BoxFit.contain)),
                  ),
                ],
              ),
            ),

            //update available

            (updateAvailable == true)
                ? Positioned(
                    top: 0,
                    child: Container(
                      height: context.h,
                      width: context.w,
                      color: Colors.transparent.withOpacity(0.6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: context.w * 0.9,
                              padding: EdgeInsets.all(context.w * 0.05),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                children: [
                                  SizedBox(
                                      width: context.w * 0.8,
                                      child: Text(
                                        'New version of this app is available in store, please update the app for continue using',
                                        style: GoogleFonts.roboto(
                                            fontSize: context.w * sixteen,
                                            fontWeight: FontWeight.w600),
                                      )),
                                  SizedBox(height: context.w * 0.05),
                                  Button(
                                      onTap: () async {
                                        if (platform ==
                                            TargetPlatform.android) {
                                          openBrowser(
                                              'https://play.google.com/store/apps/details?id=${package.packageName}');
                                        } else {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          var response = await http.get(Uri.parse(
                                              'http://itunes.apple.com/lookup?bundleId=${package.packageName}'));
                                          if (response.statusCode == 200) {
                                            openBrowser(jsonDecode(
                                                    response.body)['results'][0]
                                                ['trackViewUrl']);

                                            // printWrapped(jsonDecode(response.body)['results'][0]['trackViewUrl']);
                                          }
                                          setState(() => _isLoading = false);
                                        }
                                      },
                                      text: 'Update')
                                ],
                              ))
                        ],
                      ),
                    ))
                : const SizedBox.shrink(),

            //loader
            (_isLoading == true && internet == true)
                ? const Positioned(top: 0, child: Loading())
                : const SizedBox.shrink(),

            //no internet
            (internet == false)
                ? Positioned(
                    top: 0,
                    child: NoInternet(
                      onTap: () => setState(() {
                        internetTrue();
                        getLanguageDone();
                      }),
                    ))
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  //navigate
  navigate() {
    if (userRequestData.isNotEmpty && userRequestData['is_completed'] == 1) {
      //invoice page of ride
      Navigator.of(context)
          .pushNamedAndRemoveUntil(RouteNames.invoiceScreen, (route) => false);
    } else if (userRequestData.isNotEmpty &&
        userRequestData['is_completed'] != 1) {
      //searching ride page
      if (userRequestData['is_rental'] == true) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => BookingConfirmation(type: 1)),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BookingConfirmation()),
            (route) => false);
      }
    } else {
      //home page
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Maps()),
          (route) => false);
    }
  }

//get language json and data saved in local (bearer token , choosen language) and find users current status
  getLanguageDone() async {
    //TODO First show the permission dialogue to the user
    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    package = await PackageInfo.fromPlatform();
    if (platform == TargetPlatform.android) {
      _version = await FirebaseDatabase.instance
          .ref()
          .child('user_android_version')
          .get();
    } else {
      _version =
          await FirebaseDatabase.instance.ref().child('user_ios_version').get();
    }
    if (_version.value != null) {
      var version = _version.value.toString().split('.');
      var packages = package.version.toString().split('.');

      for (var i = 0; i < version.length || i < packages.length; i++) {
        if (i < version.length && i < packages.length) {
          if (int.parse(packages[i]) < int.parse(version[i])) {
            setState(() {
              updateAvailable = true;
            });
            break;
          } else if (int.parse(packages[i]) > int.parse(version[i])) {
            setState(() {
              updateAvailable = false;
            });
            break;
          }
        } else if (i >= version.length && i < packages.length) {
          setState(() {
            updateAvailable = false;
          });
          break;
        } else if (i < version.length && i >= packages.length) {
          setState(() {
            updateAvailable = true;
          });
          break;
        }
      }
    }

    if (updateAvailable == false) {
      await getDetailsOfDevice();
      if (internet == true) {
        var val = await getLocalData();
        if (val == '3') {
          navigate();
        } else if (val == '2') {
          Future.delayed(
              Duration.zero,
              () => Navigator.pushReplacementNamed(
                  context, RouteNames.loginScreen));
        } else {
          Future.delayed(
              Duration.zero,
              () => Navigator.pushReplacementNamed(
                  context, RouteNames.introScreen));
        }
      } else {
        setState(() {});
      }
    }
  }
}
