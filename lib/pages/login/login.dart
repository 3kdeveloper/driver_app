import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awii/pages/loadingPage/loading.dart';
import 'package:awii/pages/login/otp_page.dart';
import 'package:awii/pages/noInternet/nointernet.dart';
import 'package:awii/translations/translation.dart';
import '../../styles/styles.dart';
import '../../functions/functions.dart';
import '../../widgets/widgets.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

//code as int for getting phone dial code of choosen country
String phnumber = ''; // phone number as string entered in input field
// String phone = '';

class _LoginState extends State<Login> {
  TextEditingController controller = TextEditingController();

  bool terms = true; //terms and conditions true or false
  bool _isLoading = true;

  @override
  void initState() {
    countryCode();
    super.initState();
  }

  countryCode() async {
    var result = await getCountryCode();
    if (result == 'success') {
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  //navigate
  navigate() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Otp()));
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Material(
      child: Directionality(
        textDirection: (languageDirection == 'rtl')
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Stack(
          children: [
            (countries.isNotEmpty)
                ? Container(
                    color: page,
                    height: media.height * 1,
                    width: media.width * 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4 +
                              MediaQuery.of(context).padding.top,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF7F7F7),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Image.asset('assets/images/login_bg.jpg'),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  languages[choosenLanguage]['text_login'],
                                  style: GoogleFonts.poppins(
                                      fontSize: media.width * twentysix,
                                      fontWeight: FontWeight.bold,
                                      color: textColor),
                                ),
                                SizedBox(
                                  height: media.height * 0.05,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  height: 55,
                                  width: media.width * 1 -
                                      (media.width * 0.08 * 2),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: underline))),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          if (countries.isNotEmpty &&
                                              countries.length != 1) {
                                            //dialod box for select country for dial code
                                            await showDialog(
                                                context: context,
                                                builder: (context) {
                                                  var searchVal = '';
                                                  return AlertDialog(
                                                    insetPadding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    content: StatefulBuilder(
                                                        builder: (context,
                                                            setState) {
                                                      return Container(
                                                        width:
                                                            media.width * 0.9,
                                                        color: Colors.white,
                                                        child: Directionality(
                                                          textDirection:
                                                              (languageDirection ==
                                                                      'rtl')
                                                                  ? TextDirection
                                                                      .rtl
                                                                  : TextDirection
                                                                      .ltr,
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20),
                                                                height: 40,
                                                                width: media
                                                                        .width *
                                                                    0.9,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .grey,
                                                                        width:
                                                                            1.5)),
                                                                child:
                                                                    TextField(
                                                                  decoration: InputDecoration(
                                                                      contentPadding: (languageDirection ==
                                                                              'rtl')
                                                                          ? EdgeInsets.only(
                                                                              bottom: media.width *
                                                                                  0.035)
                                                                          : EdgeInsets.only(
                                                                              bottom: media.width *
                                                                                  0.025),
                                                                      border: InputBorder
                                                                          .none,
                                                                      hintText:
                                                                          languages[choosenLanguage]
                                                                              [
                                                                              'text_search'],
                                                                      hintStyle:
                                                                          GoogleFonts.poppins(
                                                                              fontSize: media.width * sixteen)),
                                                                  onChanged:
                                                                      (val) {
                                                                    setState(
                                                                        () {
                                                                      searchVal =
                                                                          val;
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 20),
                                                              Expanded(
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child: Column(
                                                                    children: countries
                                                                        .asMap()
                                                                        .map((i, value) {
                                                                          return MapEntry(
                                                                              i,
                                                                              SizedBox(
                                                                                width: media.width * 0.9,
                                                                                child: (searchVal == '' && countries[i]['flag'] != null)
                                                                                    ? InkWell(
                                                                                        onTap: () {
                                                                                          setState(() {
                                                                                            phcode = i;
                                                                                          });
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        child: Container(
                                                                                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                                                                                          color: Colors.white,
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              Row(
                                                                                                children: [
                                                                                                  Image.asset('assets/flags/${countries[i]['code']}.png', width: 30),
                                                                                                  SizedBox(
                                                                                                    width: media.width * 0.02,
                                                                                                  ),
                                                                                                  SizedBox(
                                                                                                      width: media.width * 0.4,
                                                                                                      child: Text(
                                                                                                        countries[i]['name'],
                                                                                                        style: GoogleFonts.poppins(fontSize: media.width * sixteen),
                                                                                                      )),
                                                                                                ],
                                                                                              ),
                                                                                              Text(
                                                                                                countries[i]['dial_code'],
                                                                                                style: GoogleFonts.poppins(fontSize: media.width * sixteen),
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                        ))
                                                                                    : (countries[i]['flag'] != null && countries[i]['name'].toLowerCase().contains(searchVal.toLowerCase()))
                                                                                        ? InkWell(
                                                                                            onTap: () {
                                                                                              setState(() {
                                                                                                phcode = i;
                                                                                              });
                                                                                              Navigator.pop(context);
                                                                                            },
                                                                                            child: Container(
                                                                                              padding: const EdgeInsets.only(top: 10, bottom: 10),
                                                                                              color: Colors.white,
                                                                                              child: Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                children: [
                                                                                                  Row(
                                                                                                    children: [
                                                                                                      Image.asset(
                                                                                                        'assets/flags/${countries[i]['code']}.png',
                                                                                                        width: 30,
                                                                                                      ),
                                                                                                      SizedBox(
                                                                                                        width: media.width * 0.02,
                                                                                                      ),
                                                                                                      SizedBox(
                                                                                                          width: media.width * 0.4,
                                                                                                          child: Text(
                                                                                                            countries[i]['name'],
                                                                                                            style: GoogleFonts.poppins(fontSize: media.width * sixteen),
                                                                                                          )),
                                                                                                    ],
                                                                                                  ),
                                                                                                  Text(
                                                                                                    countries[i]['dial_code'],
                                                                                                    style: GoogleFonts.poppins(fontSize: media.width * sixteen),
                                                                                                  )
                                                                                                ],
                                                                                              ),
                                                                                            ))
                                                                                        : Container(),
                                                                              ));
                                                                        })
                                                                        .values
                                                                        .toList(),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                  );
                                                });
                                          } else {
                                            getCountryCode();
                                          }
                                          setState(() {});
                                        },
                                        //input field
                                        child: Container(
                                          height: 50,
                                          alignment: Alignment.center,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                  'assets/flags/${countries[phcode]['code']}.png',
                                                  width: 30),
                                              SizedBox(
                                                width: media.width * 0.02,
                                              ),
                                              Text(
                                                countries[phcode]['dial_code']
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    fontSize:
                                                        media.width * sixteen,
                                                    color: textColor),
                                              ),
                                              const SizedBox(
                                                width: 2,
                                              ),
                                              const Icon(
                                                  Icons.keyboard_arrow_down)
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Container(
                                        width: .5,
                                        height: media.width * 0.0693,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 10),
                                      Container(
                                        height: 50,
                                        alignment: Alignment.center,
                                        width: media.width * 0.5,
                                        child: TextFormField(
                                          controller: controller,
                                          onChanged: (val) {
                                            setState(() {
                                              phnumber = controller.text;
                                            });
                                            if (controller.text.length ==
                                                countries[phcode]
                                                    ['dial_max_length']) {
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            }
                                          },
                                          maxLength: countries[phcode]
                                              ['dial_max_length'],
                                          style: GoogleFonts.poppins(
                                              fontSize: media.width * sixteen,
                                              color: textColor,
                                              letterSpacing: 1),
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: languages[choosenLanguage]
                                                ['text_phone_number'],
                                            counterText: '',
                                            hintStyle: GoogleFonts.poppins(
                                                fontSize: media.width * sixteen,
                                                color:
                                                    textColor.withOpacity(0.7)),
                                            border: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: media.height * 0.05),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (terms == true) {
                                            terms = false;
                                          } else {
                                            terms = true;
                                          }
                                        });
                                      },
                                      child: Container(
                                          height: media.width * 0.08,
                                          width: media.width * 0.08,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: buttonColor, width: 2),
                                              shape: BoxShape.circle,
                                              color: (terms == true)
                                                  ? buttonColor
                                                  : page),
                                          child: const Icon(Icons.done,
                                              color: Colors.white)),
                                    ),
                                    SizedBox(
                                      width: media.width * 0.03,
                                    ),

                                    //terms and condition and privacy policy url
                                    SizedBox(
                                      width: media.width * 0.7,
                                      child: Wrap(
                                        direction: Axis.horizontal,
                                        children: [
                                          Text(
                                            languages[choosenLanguage]
                                                    ['text_agree'] +
                                                ' ',
                                            style: GoogleFonts.poppins(
                                                fontSize:
                                                    media.width * fourteen,
                                                color:
                                                    textColor.withOpacity(0.7)),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              openBrowser(
                                                  'https://awiiapp.com/terms');
                                            },
                                            child: Text(
                                              languages[choosenLanguage]
                                                  ['text_terms'],
                                              style: GoogleFonts.poppins(
                                                  fontSize:
                                                      media.width * fifteen,
                                                  color: buttonColor),
                                            ),
                                          ),
                                          Text(
                                            ' ${languages[choosenLanguage]['text_and']} ',
                                            style: GoogleFonts.poppins(
                                                fontSize:
                                                    media.width * fourteen,
                                                color:
                                                    textColor.withOpacity(0.7)),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              openBrowser(
                                                  'https://awiiapp.com/privacy');
                                            },
                                            child: Text(
                                              languages[choosenLanguage]
                                                  ['text_privacy'],
                                              style: GoogleFonts.poppins(
                                                  fontSize:
                                                      media.width * fifteen,
                                                  color: buttonColor),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: media.height * 0.1,
                                ),
                                Container(
                                  width: media.width * 1 - media.width * 0.08,
                                  alignment: Alignment.center,
                                  child: Button(
                                    color: (controller.text.length >=
                                                countries[phcode]
                                                    ['dial_min_length'] &&
                                            terms == true)
                                        ? null
                                        : Colors.grey,
                                    borcolor: (controller.text.length >=
                                                countries[phcode]
                                                    ['dial_min_length'] &&
                                            terms == true)
                                        ? null
                                        : Colors.grey,
                                    onTap: () async {
                                      if ((controller.text.length >=
                                              countries[phcode]
                                                  ['dial_min_length'] &&
                                          terms == true)) {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        var val = await otpCall();
                                        if (val.value == true) {
                                          phoneAuthCheck = true;
                                          await phoneAuth(countries[phcode]
                                                  ['dial_code'] +
                                              phnumber);

                                          navigate();
                                        } else {
                                          phoneAuthCheck = false;
                                          navigate();
                                        }
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      }
                                    },
                                    text: languages[choosenLanguage]
                                        ['text_login'],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    height: media.height * 1,
                    width: media.width * 1,
                    color: page,
                  ),

            //No internet
            (internet == false)
                ? Positioned(
                    top: 0,
                    child: NoInternet(onTap: () {
                      setState(() {
                        _isLoading = true;
                        internet = true;
                        countryCode();
                      });
                    }))
                : Container(),

            //loader
            (_isLoading == true)
                ? const Positioned(top: 0, child: Loading())
                : Container()
          ],
        ),
      ),
    );
  }
}
