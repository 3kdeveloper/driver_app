import 'package:awii/core/constants/exports.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool isLoading = true;
  bool error = false;
  dynamic notificationid;
  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() async {
    var val = await getnotificationHistory();
    if (val == 'success') {
      isLoading = false;
    } else {
      isLoading = true;
    }
  }

  bool showinfo = false;
  int? showinfovalue;

  bool showToastbool = false;

  showToast() async {
    setState(() {
      showToastbool = true;
    });
    Future.delayed(const Duration(seconds: 1), () async {
      setState(() {
        showToastbool = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: ValueListenableBuilder(
            valueListenable: valueNotifierHome.value,
            builder: (context, value, child) {
              return Directionality(
                textDirection: (languageDirection == 'rtl')
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: Stack(children: [
                  Container(
                    height: context.h * 1,
                    width: context.w * 1,
                    color: page,
                    padding: EdgeInsets.fromLTRB(context.w * 0.05,
                        context.w * 0.05, context.w * 0.05, 0),
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
                                languages[choosenLanguage]['text_notification']
                                    .toString(),
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
                        Expanded(
                            child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              //wallet history
                              (notificationHistory.isNotEmpty)
                                  ? Column(
                                      children: notificationHistory
                                          .asMap()
                                          .map((i, value) {
                                            return MapEntry(
                                                i,
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      showinfovalue = i;
                                                      showinfo = true;
                                                    });
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: context.w * 0.02,
                                                        bottom:
                                                            context.w * 0.02),
                                                    width: context.w * 0.9,
                                                    padding: EdgeInsets.all(
                                                        context.w * 0.025),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: borderLines,
                                                            width: 1.2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        color: page),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            height: context.w *
                                                                0.1067,
                                                            width:
                                                                context.w *
                                                                    0.1067,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: const Color(
                                                                        0xff000000)
                                                                    .withOpacity(
                                                                        0.05)),
                                                            alignment: Alignment
                                                                .center,
                                                            child: const Icon(Icons
                                                                .notifications)),
                                                        SizedBox(
                                                          width:
                                                              context.w * 0.025,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: context.w *
                                                                  0.55,
                                                              child: Text(
                                                                notificationHistory[
                                                                            i][
                                                                        'title']
                                                                    .toString(),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: GoogleFonts.roboto(
                                                                    fontSize: context
                                                                            .w *
                                                                        fourteen,
                                                                    color:
                                                                        textColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  context.w *
                                                                      0.01,
                                                            ),
                                                            SizedBox(
                                                              width: context.w *
                                                                  0.55,
                                                              child: Text(
                                                                notificationHistory[
                                                                            i]
                                                                        ['body']
                                                                    .toString(),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    GoogleFonts
                                                                        .roboto(
                                                                  fontSize:
                                                                      context.w *
                                                                          ten,
                                                                  color:
                                                                      hintColor,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Expanded(
                                                            child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Container(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                width:
                                                                    context.w *
                                                                        0.15,
                                                                child:
                                                                    IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      error =
                                                                          true;
                                                                      notificationid =
                                                                          notificationHistory[i]
                                                                              [
                                                                              'id'];
                                                                    });
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .delete_forever),
                                                                ))
                                                          ],
                                                        ))
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                          })
                                          .values
                                          .toList(),
                                    )
                                  : Column(
                                      children: [
                                        Container(
                                          height: context.w * 0.7,
                                          width: context.w * 0.7,
                                          decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/notification_bg.png'),
                                                  fit: BoxFit.contain)),
                                        ),
                                        const Text(
                                          'No Data Found',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                  (showinfo == true)
                      ? Positioned(
                          top: 0,
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
                                      Container(
                                          height: context.h * 0.1,
                                          width: context.w * 0.1,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: page),
                                          child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  showinfo = false;
                                                  showinfovalue = null;
                                                });
                                              },
                                              child: const Icon(
                                                  Icons.cancel_outlined))),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(context.w * 0.05),
                                  width: context.w * 0.9,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: page),
                                  child: Column(
                                    children: [
                                      Text(
                                        notificationHistory[showinfovalue!]
                                                ['title']
                                            .toString(),
                                        style: GoogleFonts.roboto(
                                            fontSize: context.w * sixteen,
                                            color: textColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: context.w * 0.05,
                                      ),
                                      Text(
                                        notificationHistory[showinfovalue!]
                                                ['body']
                                            .toString(),
                                        style: GoogleFonts.roboto(
                                          fontSize: context.w * fourteen,
                                          color: hintColor,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ))
                      : Container(),
                  (error == true)
                      ? Positioned(
                          top: 0,
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
                                            ['text_delete_notification'],
                                        style: GoogleFonts.roboto(
                                            fontSize: context.w * sixteen,
                                            color: textColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: context.w * 0.05,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Button(
                                              onTap: () async {
                                                setState(() {
                                                  error = false;
                                                  notificationid = null;
                                                });
                                              },
                                              text: languages[choosenLanguage]
                                                  ['text_no']),
                                          SizedBox(
                                            width: context.w * 0.05,
                                          ),
                                          Button(
                                              onTap: () async {
                                                setState(() {
                                                  isLoading = true;
                                                });
                                                var result =
                                                    await deleteNotification(
                                                        notificationid);
                                                if (result == 'success') {
                                                  setState(() {
                                                    getdata();

                                                    error = false;
                                                    isLoading = false;
                                                    showToast();
                                                  });
                                                } else {
                                                  // setState(() {
                                                  //   logout = true;
                                                  // });
                                                }
                                              },
                                              text: languages[choosenLanguage]
                                                  ['text_yes']),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ))
                      : Container(),
                  (isLoading == true)
                      ? const Positioned(top: 0, child: Loading())
                      : Container(),
                  (showToastbool == true)
                      ? Positioned(
                          bottom: context.h * 0.2,
                          left: context.w * 0.2,
                          right: context.w * 0.2,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(context.w * 0.025),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.transparent.withOpacity(0.6)),
                            child: Text(
                              languages[choosenLanguage]
                                  ['text_notification_deleted'],
                              style: GoogleFonts.roboto(
                                  fontSize: context.w * twelve,
                                  color: Colors.white),
                            ),
                          ))
                      : Container()
                ]),
              );
            }));
  }
}
