import 'package:flutter/material.dart';
import 'package:awii/functions/functions.dart';
import 'package:awii/pages/NavigatorPages/about.dart';
import 'package:awii/pages/NavigatorPages/editprofile.dart';
import 'package:awii/pages/NavigatorPages/faq.dart';
import 'package:awii/pages/NavigatorPages/favourite.dart';
import 'package:awii/pages/NavigatorPages/history.dart';
import 'package:awii/pages/NavigatorPages/makecomplaint.dart';
import 'package:awii/pages/NavigatorPages/notification.dart';
import 'package:awii/pages/NavigatorPages/referral.dart';
import 'package:awii/pages/NavigatorPages/selectlanguage.dart';
import 'package:awii/pages/NavigatorPages/sos.dart';
import 'package:awii/pages/onTripPage/map_page.dart';
import 'package:awii/styles/styles.dart';
import 'package:awii/translations/translation.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);
  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      width: media.width * 0.8,
      child: Directionality(
        textDirection: (languageDirection == 'rtl')
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Drawer(
            child: SizedBox(
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: media.width * 0.07 +
                            MediaQuery.of(context).padding.top,
                        bottom: media.width * 0.015 +
                            MediaQuery.of(context).padding.top,
                        left: media.width * 0.05,
                        right: media.width * 0.01),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    width: media.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: media.width * 0.175,
                          width: media.width * 0.175,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      userDetails['profile_picture']),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          width: media.width * 0.030,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: media.width * 0.45,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: media.width * 0.3,
                                    child: Text(
                                      userDetails['name'],
                                      style: TextStyle(
                                          fontSize: media.width * eighteen,
                                          color: page,
                                          fontWeight: FontWeight.w600),
                                      maxLines: 1,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      var val = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const EditProfile()));
                                      if (val) {
                                        setState(() {});
                                      }
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      size: media.width * eighteen,
                                      color: page,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: media.width * 0.01,
                            ),
                            SizedBox(
                              width: media.width * 0.5,
                              child: Text(
                                userDetails['email'],
                                style: TextStyle(
                                    fontSize: media.width * fourteen,
                                    color: page),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: media.width * 0.05),
                    width: media.width * 0.7,
                    child: Column(
                      children: [
                        //notification
                        ValueListenableBuilder(
                            valueListenable: valueNotifierNotification.value,
                            builder: (context, value, child) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const NotificationPage()));
                                  setState(() {
                                    userDetails['notifications_count'] = 0;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.all(media.width * 0.025),
                                      child: Row(
                                        children: [
                                          const Icon(
                                              Icons.notifications_outlined,
                                              size: 26),
                                          SizedBox(
                                            width: media.width * 0.030,
                                          ),
                                          SizedBox(
                                            width: media.width * 0.49,
                                            child: Text(
                                              languages[choosenLanguage]
                                                      ['text_notification']
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize:
                                                      media.width * sixteen,
                                                  color: textColor),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    (userDetails['notifications_count'] == 0)
                                        ? Container()
                                        : Container(
                                            height: 20,
                                            width: 20,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: buttonColor,
                                            ),
                                            child: Text(
                                              userDetails['notifications_count']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize:
                                                      media.width * fourteen,
                                                  color: buttonText),
                                            ),
                                          )
                                  ],
                                ),
                              );
                            }),

                        //history
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const History()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(media.width * 0.025),
                            child: Row(
                              children: [
                                Icon(Icons.history, size: 26),
                                SizedBox(
                                  width: media.width * 0.030,
                                ),
                                SizedBox(
                                  width: media.width * 0.55,
                                  child: Text(
                                    languages[choosenLanguage]
                                        ['text_enable_history'],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: media.width * sixteen,
                                        color: textColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        //wallet page
                        /*InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const WalletPage()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(media.width * 0.025),
                            child: Row(
                              children: [
                                Icon(Icons.wallet_outlined, size: 26),
                                SizedBox(
                                  width: media.width * 0.030,
                                ),
                                SizedBox(
                                  width: media.width * 0.55,
                                  child: Text(
                                    languages[choosenLanguage]
                                        ['text_enable_wallet'],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: media.width * sixteen,
                                        color: textColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),*/

                        //referral page
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ReferralPage()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(media.width * 0.025),
                            child: Row(
                              children: [
                                Icon(Icons.person_add_outlined, size: 26),
                                SizedBox(
                                  width: media.width * 0.030,
                                ),
                                SizedBox(
                                  width: media.width * 0.55,
                                  child: Text(
                                    languages[choosenLanguage]
                                        ['text_enable_referal'],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: media.width * sixteen,
                                        color: textColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        //favorite
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Favorite()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(media.width * 0.025),
                            child: Row(
                              children: [
                                const Icon(Icons.favorite_border, size: 26),
                                SizedBox(
                                  width: media.width * 0.030,
                                ),
                                SizedBox(
                                  width: media.width * 0.55,
                                  child: Text(
                                    languages[choosenLanguage]
                                        ['text_favourites'],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: media.width * sixteen,
                                        color: textColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        //faq
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Faq()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(media.width * 0.025),
                            child: Row(
                              children: [
                                Icon(Icons.warning_amber, size: 26),
                                SizedBox(
                                  width: media.width * 0.030,
                                ),
                                SizedBox(
                                  width: media.width * 0.55,
                                  child: Text(
                                    languages[choosenLanguage]['text_faq'],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: media.width * sixteen,
                                        color: textColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        //sos
                        InkWell(
                          onTap: () async {
                            var nav = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Sos()));
                            if (nav) {
                              setState(() {});
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(media.width * 0.025),
                            child: Row(
                              children: [
                                Icon(Icons.emergency_outlined, size: 26),
                                SizedBox(
                                  width: media.width * 0.030,
                                ),
                                SizedBox(
                                  width: media.width * 0.55,
                                  child: Text(
                                    languages[choosenLanguage]['text_sos'],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: media.width * sixteen,
                                        color: textColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        //select language
                        InkWell(
                          onTap: () async {
                            var nav = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SelectLanguage()));
                            if (nav) {
                              setState(() {});
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(media.width * 0.025),
                            child: Row(
                              children: [
                                Icon(Icons.language_outlined, size: 26),
                                SizedBox(
                                  width: media.width * 0.030,
                                ),
                                SizedBox(
                                  width: media.width * 0.55,
                                  child: Text(
                                    languages[choosenLanguage]
                                        ['text_change_language'],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: media.width * sixteen,
                                        color: textColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        //make complaints
                        InkWell(
                          onTap: () async {
                            var nav = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MakeComplaint(
                                          fromPage: 0,
                                        )));
                            if (nav) {
                              setState(() {});
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(media.width * 0.025),
                            child: Row(
                              children: [
                                Icon(Icons.report_outlined, size: 26),
                                SizedBox(
                                  width: media.width * 0.030,
                                ),
                                SizedBox(
                                  width: media.width * 0.55,
                                  child: Text(
                                    languages[choosenLanguage]
                                        ['text_make_complaints'],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: media.width * sixteen,
                                        color: textColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        //about
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const About()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(media.width * 0.025),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  size: 26,
                                ),
                                SizedBox(
                                  width: media.width * 0.030,
                                ),
                                SizedBox(
                                  width: media.width * 0.55,
                                  child: Text(
                                    languages[choosenLanguage]['text_about'],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: media.width * sixteen,
                                        color: textColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        //delete account
                        InkWell(
                          onTap: () {
                            setState(() {
                              deleteAccount = true;
                            });
                            valueNotifierHome.incrementNotifier();
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(media.width * 0.025),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete_forever_outlined,
                                  size: 26,
                                ),
                                SizedBox(
                                  width: media.width * 0.030,
                                ),
                                SizedBox(
                                  width: media.width * 0.55,
                                  child: Text(
                                    languages[choosenLanguage]
                                        ['text_delete_account'],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: media.width * sixteen,
                                        color: textColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        //logout
                        InkWell(
                          onTap: () {
                            setState(() {
                              logout = true;
                            });
                            valueNotifierHome.incrementNotifier();
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(media.width * 0.025),
                            child: Row(
                              children: [
                                Icon(Icons.logout_outlined, size: 26),
                                SizedBox(
                                  width: media.width * 0.030,
                                ),
                                SizedBox(
                                  width: media.width * 0.55,
                                  child: Text(
                                    languages[choosenLanguage]['text_logout'],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: media.width * sixteen,
                                        color: textColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ]),
          ),
        )),
      ),
    );
  }
}
