import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:awii/pages/onTripPage/booking_confirmation.dart';
import 'package:awii/pages/onTripPage/invoice.dart';
import 'package:awii/pages/loadingPage/loading.dart';
import 'package:awii/pages/login/get_started.dart';
import 'package:awii/pages/login/login.dart';
import 'package:awii/pages/onTripPage/map_page.dart';
import 'package:awii/pages/noInternet/nointernet.dart';
import 'package:awii/translations/translation.dart';
import 'package:awii/widgets/widgets.dart';
import '../../styles/styles.dart';
import '../../functions/functions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  var resendTime = 60; //otp resend time
  late Timer timer; //timer for resend time
  String _error =
      ''; //otp error string to show if error occurs in otp validation
  TextEditingController otpController =
      TextEditingController(); //otp textediting controller
  bool _loading = false; //loading screen showing
  @override
  void initState() {
    _loading = false;
    timers();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel;
    super.dispose();
  }

  //navigate
  navigate(verify) {
    if (verify == true) {
      if (userRequestData.isNotEmpty && userRequestData['is_completed'] == 1) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const InvoiceScreen()),
            (route) => false);
      } else if (userRequestData.isNotEmpty &&
          userRequestData['is_completed'] != 1) {
        Future.delayed(const Duration(seconds: 2), () {
          if (userRequestData['is_rental'] == true) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => BookingConfirmation(
                          type: 1,
                        )),
                (route) => false);
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => BookingConfirmation()),
                (route) => false);
          }
        });
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Maps()),
            (route) => false);
      }
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const GetStarted()));
    }
  }

  //auto verify otp

  verifyOtp() async {
    try {
      // Sign the user in (or link) with the credential
      await FirebaseAuth.instance.signInWithCredential(credentials);

      var verify = await verifyUser(phnumber);
      navigate(verify);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-verification-code') {
        setState(() {
          otpController.clear();
          _error = languages[choosenLanguage]['text_otp_error'];
        });
      }
    }
  }

// running resend otp timer
  timers() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTime != 0) {
        if (mounted) {
          setState(() {
            resendTime--;
          });
        }
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Material(
      child: Directionality(
        textDirection: (languageDirection == 'rtl')
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: ValueListenableBuilder(
            valueListenable: valueNotifierHome.value,
            builder: (context, value, child) {
              if (credentials != null) {
                _loading = true;
                verifyOtp();
              }
              return Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 12.0),
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF7F7F7),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Image.asset('assets/images/otp_bg.jpg'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: media.width * 0.04, right: media.width * 0.08),
                    height: media.height * 1,
                    width: media.width * 1,
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: media.width * 0.03),
                            height: media.height * 0.12,
                            width: media.width * 1,
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                              ),
                              Text(
                                languages[choosenLanguage]['text_phone_verify'],
                                style: GoogleFonts.poppins(
                                    fontSize: media.width * twentyfour,
                                    fontWeight: FontWeight.bold,
                                    color: textColor),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                languages[choosenLanguage]['text_enter_otp'],
                                style: GoogleFonts.poppins(
                                    fontSize: media.width * thirteen,
                                    color: textColor.withOpacity(0.3)),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                countries[phcode]['dial_code'] + phnumber,
                                style: GoogleFonts.poppins(
                                    fontSize: media.width * fifteen,
                                    color: textColor,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1),
                              ),
                              SizedBox(height: media.height * 0.04),

                              //otp text box
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: PinCodeTextField(
                                    appContext: context,
                                    length: 6,
                                    onChanged: (val) {},
                                    pinTheme: PinTheme(
                                      inactiveColor: Colors.grey,
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      selectedColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                    keyboardType: TextInputType.number,
                                    controller: otpController),
                              ),

                              //otp error
                              (_error != '')
                                  ? Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                          top: media.height * 0.02),
                                      child: Text(
                                        _error,
                                        style: GoogleFonts.poppins(
                                            fontSize: media.width * sixteen,
                                            color: Colors.red),
                                      ),
                                    )
                                  : Container(),
                              SizedBox(
                                height: media.height * 0.03,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        setState(() {
                                          resendTime = 60;
                                        });
                                        timers();
                                      });
                                      phoneAuth(countries[phcode]['dial_code'] +
                                          phnumber);
                                    },
                                    child: Text(
                                      'Resend code ',
                                      style: TextStyle(
                                        color: resendTime == 0
                                            ? Theme.of(context).primaryColor
                                            : Colors.grey,
                                        fontWeight: resendTime == 0
                                            ? FontWeight.w600
                                            : FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Text('in $resendTime seconds')
                                ],
                              ),
                              const Spacer(),
                              Container(
                                alignment: Alignment.center,
                                child: Button(
                                  onTap: () async {
                                    if (otpController.text.trim().length == 6) {
                                      setState(() {
                                        _loading = true;
                                        _error = '';
                                      });
                                      //firebase code send false
                                      if (phoneAuthCheck == false) {
                                        var verify = await verifyUser(phnumber);

                                        navigate(verify);
                                      } else {
                                        // firebase code send true
                                        try {
                                          PhoneAuthCredential credential =
                                              PhoneAuthProvider.credential(
                                                  verificationId: verId,
                                                  smsCode: otpController.text
                                                      .trim());

                                          // Sign the user in (or link) with the credential
                                          await FirebaseAuth.instance
                                              .signInWithCredential(credential);

                                          var verify =
                                              await verifyUser(phnumber);
                                          navigate(verify);
                                        } on FirebaseAuthException catch (error) {
                                          if (error.code ==
                                              'invalid-verification-code') {
                                            setState(() {
                                              otpController.clear();
                                              _error =
                                                  languages[choosenLanguage]
                                                      ['text_otp_error'];
                                            });
                                          }
                                        }
                                      }
                                      setState(() {
                                        _loading = false;
                                      });
                                    }
                                  },
                                  text: languages[choosenLanguage]
                                      ['text_verify'],
                                  color: (resendTime != 0 &&
                                          otpController.text.trim().length != 6)
                                      ? underline
                                      : null,
                                  borcolor: (resendTime != 0 &&
                                          otpController.text.trim().length != 6)
                                      ? underline
                                      : null,
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  //no internet
                  (internet == false)
                      ? Positioned(
                          top: 0,
                          child: NoInternet(onTap: () {
                            setState(() {
                              internetTrue();
                            });
                          }))
                      : Container(),

                  //loader
                  (_loading == true)
                      ? Positioned(
                          top: 0,
                          child: SizedBox(
                            height: media.height * 1,
                            width: media.width * 1,
                            child: const Loading(),
                          ))
                      : Container()
                ],
              );
            }),
      ),
    );
  }
}
