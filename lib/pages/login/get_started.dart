import 'package:awii/core/constants/exports.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

String name = ''; //name of user
String email = ''; // email of user
dynamic proImageFile1;

class _GetStartedState extends State<GetStarted> {
  bool _loading = false;
  var verifyEmailError = '';
  var _error = '';

  late final TextEditingController _emailText;
  late final TextEditingController _nameText;

  ImagePicker picker = ImagePicker();
  bool _pickImage = false;
  String _permission = '';

  //TODO Recreate this method again
  getGalleryPermission() async {
    var status = await Permission.photos.status;
    if (status != PermissionStatus.granted) {
      status = await Permission.photos.request();
    }
    return status;
  }

//get camera permission
  getCameraPermission() async {
    var status = await Permission.camera.status;
    if (status != PermissionStatus.granted) {
      status = await Permission.camera.request();
    }
    return status;
  }

//pick image from gallery
  pickImageFromGallery() async {
    var permission = await getGalleryPermission();
    if (permission == PermissionStatus.granted) {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        proImageFile1 = pickedFile?.path;
        _pickImage = false;
      });
    } else {
      setState(() => _permission = 'noPhotos');
    }
  }

//pick image from camera
  pickImageFromCamera() async {
    var permission = await getCameraPermission();
    if (permission == PermissionStatus.granted) {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      setState(() {
        proImageFile1 = pickedFile?.path;
        _pickImage = false;
      });
    } else {
      setState(() {
        _permission = 'noCamera';
      });
    }
  }

  //navigate
  navigate() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Referral()),
        (route) => false);
  }

  @override
  void initState() {
    _emailText = TextEditingController();
    _nameText = TextEditingController();
    proImageFile1 = null;
    super.initState();
  }

  @override
  void dispose() {
    _emailText.dispose();
    _nameText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Directionality(
          textDirection: (languageDirection == 'rtl')
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: context.w * 0.08, right: context.w * 0.08),
                height: context.h * 1,
                width: context.w * 1,
                color: page,
                child: Column(
                  children: [
                    Container(
                        height: context.h * 0.12,
                        width: context.w * 1,
                        color: topBar,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(Icons.arrow_back)),
                          ],
                        )),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: context.h * 0.04),
                          SizedBox(
                            width: context.w * 1,
                            child: Text(
                              languages[choosenLanguage]['text_get_started'],
                              style: GoogleFonts.roboto(
                                  fontSize: context.w * twentyeight,
                                  fontWeight: FontWeight.bold,
                                  color: textColor),
                            ),
                          ),
                          SizedBox(height: context.h * 0.012),
                          Text(
                            languages[choosenLanguage]['text_fill_form'],
                            style: GoogleFonts.roboto(
                                fontSize: context.w * sixteen,
                                color: textColor.withOpacity(0.3)),
                          ),
                          SizedBox(height: context.h * 0.04),
                          Center(
                            child: InkWell(
                              onTap: () => setState(() => _pickImage = true),
                              child: proImageFile1 != null
                                  ? Container(
                                      height: context.w * 0.4,
                                      width: context.w * 0.4,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: backgroundColor,
                                          image: DecorationImage(
                                              image: FileImage(
                                                  File(proImageFile1)),
                                              fit: BoxFit.cover)),
                                    )
                                  : Container(
                                      alignment: Alignment.center,
                                      height: context.w * 0.4,
                                      width: context.w * 0.4,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: backgroundColor,
                                      ),
                                      child: Text(
                                        languages[choosenLanguage]
                                            ['text_add_photo'],
                                        style: GoogleFonts.roboto(
                                            fontSize: context.w * fourteen,
                                            color: textColor),
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(height: context.h * 0.04),
                          InputField(
                            icon: Icons.person_outline_rounded,
                            text: languages[choosenLanguage]['text_name'],
                            onTap: (val) {
                              setState(() {
                                name = _nameText.text;
                              });
                            },
                            textController: _nameText,
                          ),
                          SizedBox(height: context.h * 0.012),
                          InputField(
                            icon: Icons.email_outlined,
                            text: languages[choosenLanguage]['text_email'],
                            onTap: (val) =>
                                setState(() => email = _emailText.text),
                            textController: _emailText,
                            color: (verifyEmailError == '') ? null : Colors.red,
                          ),
                          SizedBox(height: context.h * 0.012),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: underline))),
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        countries[phcode]['dial_code'],
                                        style: GoogleFonts.roboto(
                                            fontSize: context.w * sixteen,
                                            color: textColor),
                                      ),
                                      const SizedBox(width: 2),
                                      const Icon(Icons.keyboard_arrow_down)
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  phnumber,
                                  style: GoogleFonts.roboto(
                                      fontSize: context.w * sixteen,
                                      color: textColor,
                                      letterSpacing: 2),
                                )
                              ],
                            ),
                          ),
                          //email already exist error
                          (_error != '')
                              ? Container(
                                  width: context.w * 0.8,
                                  margin:
                                      EdgeInsets.only(top: context.h * 0.03),
                                  alignment: Alignment.center,
                                  child: Text(
                                    _error,
                                    style: GoogleFonts.roboto(
                                        fontSize: context.w * sixteen,
                                        color: Colors.red),
                                  ),
                                )
                              : const SizedBox.shrink(),

                          SizedBox(height: context.h * 0.065),
                          (_nameText.text.isNotEmpty &&
                                  _emailText.text.isNotEmpty)
                              ? Container(
                                  width: context.w * 1,
                                  alignment: Alignment.center,
                                  child: Button(
                                      onTap: () async {
                                        String pattern =
                                            r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])*$";
                                        RegExp regex = RegExp(pattern);
                                        if (regex.hasMatch(_emailText.text)) {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          setState(() {
                                            verifyEmailError = '';
                                            _error = '';
                                            _loading = true;
                                          });
                                          //validate email already exist
                                          var result = await validateEmail();
                                          if (result == 'success') {
                                            setState(() {
                                              verifyEmailError = '';
                                              _error = '';
                                            });
                                            var register = await registerUser();
                                            if (register == 'true') {
                                              //referral page
                                              navigate();
                                            } else {
                                              setState(() =>
                                                  _error = register.toString());
                                            }
                                          } else {
                                            setState(() {
                                              verifyEmailError =
                                                  result.toString();
                                              _error = result.toString();
                                            });
                                          }
                                          setState(() => _loading = false);
                                        } else {
                                          setState(() {
                                            verifyEmailError =
                                                languages[choosenLanguage]
                                                    ['text_email_validation'];
                                            _error = languages[choosenLanguage]
                                                ['text_email_validation'];
                                          });
                                        }
                                      },
                                      text: languages[choosenLanguage]
                                          ['text_next']))
                              : const SizedBox.shrink()
                        ],
                      ),
                    )),
                  ],
                ),
              ),

              (_pickImage == true)
                  ? Positioned(
                      bottom: 0,
                      child: InkWell(
                        onTap: () => setState(() => _pickImage = false),
                        child: Container(
                          height: context.h * 1,
                          width: context.w * 1,
                          color: Colors.transparent.withOpacity(0.6),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.all(context.w * 0.05),
                                width: context.w * 1,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25)),
                                    border: Border.all(
                                      color: borderLines,
                                      width: 1.2,
                                    ),
                                    color: page),
                                child: Column(
                                  children: [
                                    Container(
                                      height: context.w * 0.02,
                                      width: context.w * 0.15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            context.w * 0.01),
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(height: context.w * 0.05),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                pickImageFromCamera();
                                              },
                                              child: Container(
                                                  height: context.w * 0.171,
                                                  width: context.w * 0.171,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: borderLines,
                                                          width: 1.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: Icon(
                                                    Icons.camera_alt_outlined,
                                                    size: context.w * 0.064,
                                                  )),
                                            ),
                                            SizedBox(height: context.w * 0.01),
                                            Text(
                                              languages[choosenLanguage]
                                                  ['text_camera'],
                                              style: GoogleFonts.roboto(
                                                  fontSize: context.w * ten,
                                                  color:
                                                      const Color(0xff666666)),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () =>
                                                  pickImageFromGallery(),
                                              child: Container(
                                                  height: context.w * 0.171,
                                                  width: context.w * 0.171,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: borderLines,
                                                          width: 1.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: Icon(
                                                    Icons.image_outlined,
                                                    size: context.w * 0.064,
                                                  )),
                                            ),
                                            SizedBox(height: context.w * 0.01),
                                            Text(
                                              languages[choosenLanguage]
                                                  ['text_gallery'],
                                              style: GoogleFonts.roboto(
                                                  fontSize: context.w * ten,
                                                  color:
                                                      const Color(0xff666666)),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                  : const SizedBox.shrink(),

              //permission denied popup
              (_permission != '')
                  ? Positioned(
                      child: Container(
                      height: context.h * 1,
                      width: context.w * 1,
                      color: Colors.transparent.withOpacity(0.6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: context.w * 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () => setState(() {
                                    _permission = '';
                                    _pickImage = false;
                                  }),
                                  child: Container(
                                    height: context.w * 0.1,
                                    width: context.w * 0.1,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle, color: page),
                                    child: const Icon(Icons.cancel_outlined),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: context.w * 0.05),
                          Container(
                            padding: EdgeInsets.all(context.w * 0.05),
                            width: context.w * 0.9,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: page,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 2.0,
                                      spreadRadius: 2.0,
                                      color: Colors.black.withOpacity(0.2))
                                ]),
                            child: Column(
                              children: [
                                SizedBox(
                                    width: context.w * 0.8,
                                    child: Text(
                                      (_permission == 'noPhotos')
                                          ? languages[choosenLanguage]
                                              ['text_open_photos_setting']
                                          : languages[choosenLanguage]
                                              ['text_open_camera_setting'],
                                      style: GoogleFonts.roboto(
                                          fontSize: context.w * sixteen,
                                          color: textColor,
                                          fontWeight: FontWeight.w600),
                                    )),
                                SizedBox(height: context.w * 0.05),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                        onTap: () async {
                                          await openAppSettings();
                                        },
                                        child: Text(
                                          languages[choosenLanguage]
                                              ['text_open_settings'],
                                          style: GoogleFonts.roboto(
                                              fontSize: context.w * sixteen,
                                              color: buttonColor,
                                              fontWeight: FontWeight.w600),
                                        )),
                                    InkWell(
                                        onTap: () async {
                                          (_permission == 'noCamera')
                                              ? pickImageFromCamera()
                                              : pickImageFromGallery();
                                          setState(() {
                                            _permission = '';
                                          });
                                        },
                                        child: Text(
                                          languages[choosenLanguage]
                                              ['text_done'],
                                          style: GoogleFonts.roboto(
                                              fontSize: context.w * sixteen,
                                              color: buttonColor,
                                              fontWeight: FontWeight.w600),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ))
                  : const SizedBox.shrink(),

              //loader
              (_loading == true)
                  ? const Positioned(top: 0, child: Loading())
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
