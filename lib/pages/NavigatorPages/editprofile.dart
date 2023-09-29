import 'package:awii/core/constants/exports.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

dynamic imageFile;

class _EditProfileState extends State<EditProfile> {
  ImagePicker picker = ImagePicker();
  bool _isLoading = false;
  bool _error = false;
  String _permission = '';
  bool _pickImage = false;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();

//gallery permission
  getGalleryPermission() async {
    var status = await Permission.photos.status;
    if (status != PermissionStatus.granted) {
      status = await Permission.photos.request();
    }
    return status;
  }

//camera permission
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
        imageFile = pickedFile?.path;
        _pickImage = false;
      });
    } else {
      setState(() {
        _permission = 'noPhotos';
      });
    }
  }

//pick image from camera
  pickImageFromCamera() async {
    var permission = await getCameraPermission();
    if (permission == PermissionStatus.granted) {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      setState(() {
        imageFile = pickedFile?.path;
        _pickImage = false;
      });
    } else {
      setState(() {
        _permission = 'noCamera';
      });
    }
  }

  //navigate
  pop() => Navigator.pop(context, true);

  @override
  void initState() {
    imageFile = null;
    name.text = userDetails['name'];
    email.text = userDetails['email'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Directionality(
        textDirection: (languageDirection == 'rtl')
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(context.w * 0.05),
              height: context.h * 1,
              width: context.w * 1,
              color: page,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).padding.top),
                        Stack(
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.only(bottom: context.w * 0.05),
                              width: context.w * 1,
                              alignment: Alignment.center,
                              child: Text(
                                languages[choosenLanguage]['text_editprofile'],
                                style: GoogleFonts.roboto(
                                    fontSize: context.w * twenty,
                                    fontWeight: FontWeight.w600,
                                    color: textColor),
                              ),
                            ),
                            Positioned(
                                child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(Icons.arrow_back)))
                          ],
                        ),
                        SizedBox(height: context.w * 0.1),
                        Container(
                          height: context.w * 0.4,
                          width: context.w * 0.4,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: page,
                              image: (imageFile == null)
                                  ? DecorationImage(
                                      image: NetworkImage(
                                        userDetails['profile_picture'],
                                      ),
                                      fit: BoxFit.cover)
                                  : DecorationImage(
                                      image: FileImage(File(imageFile)),
                                      fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          height: context.w * 0.04,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _pickImage = true;
                            });
                          },
                          child: Text(
                              languages[choosenLanguage]['text_editimage'],
                              style: GoogleFonts.roboto(
                                  fontSize: context.w * sixteen,
                                  color: buttonColor)),
                        ),
                        SizedBox(
                          height: context.w * 0.1,
                        ),
                        SizedBox(
                          width: context.w * 0.8,
                          child: TextField(
                            textDirection: (choosenLanguage == 'iw' ||
                                    choosenLanguage == 'ur' ||
                                    choosenLanguage == 'ar')
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            controller: name,
                            decoration: InputDecoration(
                                labelText: languages[choosenLanguage]
                                    ['text_name'],
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    gapPadding: 1),
                                isDense: true),
                          ),
                        ),
                        SizedBox(
                          height: context.w * 0.1,
                        ),
                        SizedBox(
                          width: context.w * 0.8,
                          child: TextField(
                            controller: email,
                            textDirection: (choosenLanguage == 'iw' ||
                                    choosenLanguage == 'ur' ||
                                    choosenLanguage == 'ar')
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            decoration: InputDecoration(
                                labelText: languages[choosenLanguage]
                                    ['text_email'],
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    gapPadding: 1),
                                isDense: true),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                      width: context.w * 0.8,
                      child: Button(
                          onTap: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            dynamic val;

                            if (imageFile == null) {
                              //update name or email
                              val = await updateProfileWithoutImage(
                                  name.text, email.text);
                            } else {
                              //update image
                              val = await updateProfile(name.text, email.text);
                            }
                            if (val == 'success') {
                              pop();
                            } else {
                              setState(() {
                                _error = true;
                              });
                            }
                            setState(() {
                              _isLoading = false;
                            });
                          },
                          text: languages[choosenLanguage]['text_confirm']))
                ],
              ),
            ),

            //pick image bar
            (_pickImage == true)
                ? Positioned(
                    bottom: 0,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _pickImage = false;
                        });
                      },
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
                                  SizedBox(
                                    height: context.w * 0.05,
                                  ),
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
                                          SizedBox(
                                            height: context.w * 0.01,
                                          ),
                                          Text(
                                            languages[choosenLanguage]
                                                ['text_camera'],
                                            style: GoogleFonts.roboto(
                                                fontSize: context.w * ten,
                                                color: const Color(0xff666666)),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              pickImageFromGallery();
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
                                                  Icons.image_outlined,
                                                  size: context.w * 0.064,
                                                )),
                                          ),
                                          SizedBox(
                                            height: context.w * 0.01,
                                          ),
                                          Text(
                                            languages[choosenLanguage]
                                                ['text_gallery'],
                                            style: GoogleFonts.roboto(
                                                fontSize: context.w * ten,
                                                color: const Color(0xff666666)),
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

            //popup for denied permission
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
                                onTap: () {
                                  setState(() {
                                    _permission = '';
                                    _pickImage = false;
                                  });
                                },
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
                        SizedBox(
                          height: context.w * 0.05,
                        ),
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
                                        languages[choosenLanguage]['text_done'],
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
            (internet == false)
                ? Positioned(
                    top: 0,
                    child: NoInternet(
                      onTap: () => setState(() => internetTrue()),
                    ))
                : const SizedBox.shrink(),

            //loader
            (_isLoading == true)
                ? const Positioned(top: 0, child: Loading())
                : const SizedBox.shrink(),

            //error
            (_error == true)
                ? Positioned(
                    child: Container(
                    height: context.h * 1,
                    width: context.w * 1,
                    color: Colors.transparent.withOpacity(0.6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(context.w * 0.05),
                          width: context.w * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: page),
                          child: Column(
                            children: [
                              Text(
                                languages[choosenLanguage]
                                    ['text_somethingwentwrong'],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                    fontSize: context.w * sixteen,
                                    color: textColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: context.w * 0.05),
                              Button(
                                  onTap: () async =>
                                      setState(() => _error = false),
                                  text: languages[choosenLanguage]['text_ok'])
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
