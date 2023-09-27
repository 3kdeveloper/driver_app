import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awii/functions/functions.dart';
import 'package:awii/pages/loadingPage/loading.dart';
import 'package:awii/pages/loadingPage/loadingpage.dart';
import 'package:awii/pages/noInternet/nointernet.dart';
import 'package:awii/styles/styles.dart';
import 'package:awii/translations/translation.dart';
import 'package:awii/widgets/widgets.dart';
import 'package:share_plus/share_plus.dart';

class ReferralPage extends StatefulWidget {
  const ReferralPage({Key? key}) : super(key: key);

  @override
  State<ReferralPage> createState() => _ReferralPageState();
}

class _ReferralPageState extends State<ReferralPage> {
  bool _isLoading = true;
  bool _showToast = false;

  @override
  void initState() {
    _getReferral();
    super.initState();
  }

//get referral code
  _getReferral() async {
    await getReferral();
    setState(() {
      _isLoading = false;
    });
  }

//show toast for copied
  showToast() {
    setState(() {
      _showToast = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showToast = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Material(
      child: ValueListenableBuilder(
          valueListenable: valueNotifierHome.value,
          builder: (context, value, child) {
            return Directionality(
              textDirection: (languageDirection == 'rtl')
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(media.width * 0.05),
                    height: media.height * 1,
                    width: media.width * 1,
                    color: page,
                    child: (myReferralCode.isNotEmpty)
                        ? Column(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).padding.top),
                                    Stack(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              bottom: media.width * 0.05),
                                          width: media.width * 1,
                                          alignment: Alignment.center,
                                          child: Text(
                                            languages[choosenLanguage]
                                                ['text_enable_referal'],
                                            style: GoogleFonts.roboto(
                                                fontSize: media.width * twenty,
                                                fontWeight: FontWeight.w600,
                                                color: textColor),
                                          ),
                                        ),
                                        Positioned(
                                            child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Icon(
                                                    Icons.arrow_back)))
                                      ],
                                    ),
                                    Container(
                                      width: media.width,
                                      padding: const EdgeInsets.all(32),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF7F7F7),
                                      ),
                                      height: media.height * 0.24,
                                      child: Image.asset(
                                        'assets/images/referral.jpg',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.1,
                                    ),
                                    Text(
                                      myReferralCode[
                                          'referral_comission_string'],
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                          fontSize: media.width * sixteen,
                                          color: textColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.05,
                                    ),
                                    Container(
                                        width: media.width * 0.9,
                                        padding:
                                            EdgeInsets.all(media.width * 0.05),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: borderLines, width: 1.2),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              myReferralCode['refferal_code'],
                                              style: GoogleFonts.roboto(
                                                  fontSize:
                                                      media.width * sixteen,
                                                  color: textColor,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    Clipboard.setData(ClipboardData(
                                                        text: myReferralCode[
                                                            'refferal_code']));
                                                  });
                                                  showToast();
                                                },
                                                child: const Icon(Icons.copy))
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: media.width * 0.05,
                                    bottom: media.width * 0.05),
                                child: Button(
                                    onTap: () async {
                                      await Share.share(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          languages[choosenLanguage]
                                                      ['text_invitation_1']
                                                  .toString()
                                                  .replaceAll(
                                                      '55', package.appName) +
                                              ' ' +
                                              myReferralCode['refferal_code'] +
                                              ' ' +
                                              languages[choosenLanguage]
                                                  ['text_invitation_2']);
                                    },
                                    text: languages[choosenLanguage]
                                        ['text_invite']),
                              )
                            ],
                          )
                        : Container(),
                  ),
                  (internet == false)
                      ? Positioned(
                          top: 0,
                          child: NoInternet(
                            onTap: () {
                              setState(() {
                                internetTrue();
                                _isLoading = true;
                                getReferral();
                              });
                            },
                          ))
                      : Container(),

                  //loader
                  (_isLoading == true)
                      ? const Positioned(top: 0, child: Loading())
                      : Container(),

                  //display toast
                  (_showToast == true)
                      ? Positioned(
                          bottom: media.height * 0.2,
                          child: Container(
                            padding: EdgeInsets.all(media.width * 0.025),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.transparent.withOpacity(0.6)),
                            child: Text(
                              languages[choosenLanguage]['text_code_copied'],
                              style: GoogleFonts.roboto(
                                  fontSize: media.width * twelve,
                                  color: Colors.white),
                            ),
                          ))
                      : Container()
                ],
              ),
            );
          }),
    );
  }
}
