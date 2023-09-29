import 'package:awii/core/constants/exports.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

dynamic selectedHistory;

class _HistoryState extends State<History> {
  int _showHistory = 0;
  bool _isLoading = true;
  dynamic isCompleted;
  bool _cancelRide = false;
  var _cancelId = '';

  @override
  void initState() {
    _isLoading = true;
    _getHistory();
    super.initState();
  }

//get history datas
  _getHistory() async {
    setState(() {
      myHistoryPage.clear();
      myHistory.clear();
    });
    var val = await getHistory('is_later=1');
    if (val == 'success') {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: ValueListenableBuilder(
            valueListenable: valueNotifierBook.value,
            builder: (context, value, child) {
              return Directionality(
                textDirection: (languageDirection == 'rtl')
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: Stack(
                  children: [
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
                                  languages[choosenLanguage]
                                      ['text_enable_history'],
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
                          SizedBox(
                            height: context.w * 0.05,
                          ),
                          Container(
                            height: context.w * 0.13,
                            width: context.w * 0.9,
                            decoration: BoxDecoration(
                                color: page,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 2,
                                      spreadRadius: 2,
                                      color: Colors.black.withOpacity(0.2))
                                ]),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    setState(() {
                                      myHistory.clear();
                                      myHistoryPage.clear();
                                      _showHistory = 0;
                                      _isLoading = true;
                                    });

                                    await getHistory('is_later=1');
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  },
                                  child: Container(
                                      height: context.w * 0.13,
                                      alignment: Alignment.center,
                                      width: context.w * 0.3,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: (_showHistory == 0)
                                              ? const Color(0xff222222)
                                              : page),
                                      child: Text(
                                        languages[choosenLanguage]
                                            ['text_upcoming'],
                                        style: GoogleFonts.roboto(
                                            fontSize: context.w * fifteen,
                                            fontWeight: FontWeight.w600,
                                            color: (_showHistory == 0)
                                                ? Colors.white
                                                : textColor),
                                      )),
                                ),
                                InkWell(
                                  onTap: () async {
                                    setState(() {
                                      myHistory.clear();
                                      myHistoryPage.clear();
                                      _showHistory = 1;
                                      _isLoading = true;
                                    });

                                    await getHistory('is_completed=1');
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  },
                                  child: Container(
                                      height: context.w * 0.13,
                                      alignment: Alignment.center,
                                      width: context.w * 0.3,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: (_showHistory == 1)
                                              ? const Color(0xff222222)
                                              : page),
                                      child: Text(
                                        languages[choosenLanguage]
                                            ['text_completed'],
                                        style: GoogleFonts.roboto(
                                            fontSize: context.w * fifteen,
                                            fontWeight: FontWeight.w600,
                                            color: (_showHistory == 1)
                                                ? Colors.white
                                                : textColor),
                                      )),
                                ),
                                InkWell(
                                  onTap: () async {
                                    setState(() {
                                      myHistory.clear();
                                      myHistoryPage.clear();
                                      _showHistory = 2;
                                      _isLoading = true;
                                    });

                                    await getHistory('is_cancelled=1');
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  },
                                  child: Container(
                                      height: context.w * 0.13,
                                      alignment: Alignment.center,
                                      width: context.w * 0.3,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: (_showHistory == 2)
                                              ? const Color(0xff222222)
                                              : page),
                                      child: Text(
                                        languages[choosenLanguage]
                                            ['text_cancelled'],
                                        style: GoogleFonts.roboto(
                                            fontSize: context.w * fifteen,
                                            fontWeight: FontWeight.w600,
                                            color: (_showHistory == 2)
                                                ? Colors.white
                                                : textColor),
                                      )),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: context.w * 0.1,
                          ),
                          Expanded(
                              child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                (myHistory.isNotEmpty)
                                    ? Column(
                                        children: myHistory
                                            .asMap()
                                            .map((i, value) {
                                              return MapEntry(
                                                  i,
                                                  (_showHistory == 1)
                                                      ?
                                                      //completed ride history
                                                      Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              myHistory[i][
                                                                  'accepted_at'],
                                                              style: GoogleFonts.roboto(
                                                                  fontSize:
                                                                      context.w *
                                                                          sixteen,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color:
                                                                      textColor),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                selectedHistory =
                                                                    i;
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                const HistoryDetails()));
                                                              },
                                                              child: Container(
                                                                margin: EdgeInsets.only(
                                                                    top: context
                                                                            .w *
                                                                        0.025,
                                                                    bottom: context
                                                                            .w *
                                                                        0.05,
                                                                    left: context
                                                                            .w *
                                                                        0.015,
                                                                    right: context
                                                                            .w *
                                                                        0.015),
                                                                width:
                                                                    context.w *
                                                                        0.85,
                                                                padding: EdgeInsets.fromLTRB(
                                                                    context.w *
                                                                        0.025,
                                                                    context.w *
                                                                        0.05,
                                                                    context.w *
                                                                        0.025,
                                                                    context.w *
                                                                        0.05),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(12),
                                                                    color: page,
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                          blurRadius:
                                                                              2,
                                                                          spreadRadius:
                                                                              2,
                                                                          color: Colors
                                                                              .black
                                                                              .withOpacity(0.2))
                                                                    ]),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      myHistory[
                                                                              i]
                                                                          [
                                                                          'request_number'],
                                                                      style: GoogleFonts.roboto(
                                                                          fontSize: context.w *
                                                                              sixteen,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    SizedBox(
                                                                        height: context.w *
                                                                            0.02),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              context.w * 0.16,
                                                                          width:
                                                                              context.w * 0.16,
                                                                          decoration: BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              image: DecorationImage(image: NetworkImage(myHistory[i]['driverDetail']['data']['profile_picture']), fit: BoxFit.cover)),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              context.w * 0.02,
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            SizedBox(
                                                                              width: context.w * 0.3,
                                                                              child: Text(
                                                                                myHistory[i]['driverDetail']['data']['name'],
                                                                                style: GoogleFonts.roboto(fontSize: context.w * eighteen, fontWeight: FontWeight.w600),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: context.w * 0.01,
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: context.w * 0.06,
                                                                                  child: (myHistory[i]['payment_opt'] == '1')
                                                                                      ? Image.asset(
                                                                                          'assets/images/cash.png',
                                                                                          fit: BoxFit.contain,
                                                                                        )
                                                                                      : (myHistory[i]['payment_opt'] == '2')
                                                                                          ? Image.asset(
                                                                                              'assets/images/wallet.png',
                                                                                              fit: BoxFit.contain,
                                                                                            )
                                                                                          : (myHistory[i]['payment_opt'] == '0')
                                                                                              ? Image.asset(
                                                                                                  'assets/images/card.png',
                                                                                                  fit: BoxFit.contain,
                                                                                                )
                                                                                              : Container(),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: context.w * 0.01,
                                                                                ),
                                                                                Text(
                                                                                  (myHistory[i]['payment_opt'] == '1')
                                                                                      ? languages[choosenLanguage]['text_cash']
                                                                                      : (myHistory[i]['payment_opt'] == '2')
                                                                                          ? languages[choosenLanguage]['text_wallet']
                                                                                          : (myHistory[i]['payment_opt'] == '0')
                                                                                              ? languages[choosenLanguage]['text_card']
                                                                                              : '',
                                                                                  style: GoogleFonts.roboto(fontSize: context.w * twelve, fontWeight: FontWeight.w600),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              Column(
                                                                                children: [
                                                                                  Text(
                                                                                    myHistory[i]['requestBill']['data']['requested_currency_symbol'] + ' ' + myHistory[i]['requestBill']['data']['total_amount'].toString(),
                                                                                    style: GoogleFonts.roboto(fontSize: context.w * sixteen, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                  SizedBox(height: context.w * 0.01),
                                                                                  Row(
                                                                                    children: [
                                                                                      Text(
                                                                                        (myHistory[i]['total_time'] < 50) ? myHistory[i]['total_distance'] + myHistory[i]['unit'] + ' - ' + myHistory[i]['total_time'].toString() + ' mins' : myHistory[i]['total_distance'] + myHistory[i]['unit'] + ' - ' + (myHistory[i]['total_time'] / 60).round().toString() + ' hr',
                                                                                        style: GoogleFonts.roboto(fontSize: context.w * twelve),
                                                                                      ),
                                                                                    ],
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height: context.w *
                                                                            0.05),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              context.w * 0.05,
                                                                          width:
                                                                              context.w * 0.05,
                                                                          alignment:
                                                                              Alignment.center,
                                                                          decoration: BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              color: const Color(0xffFF0000).withOpacity(0.3)),
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                context.w * 0.025,
                                                                            width:
                                                                                context.w * 0.025,
                                                                            decoration:
                                                                                const BoxDecoration(shape: BoxShape.circle, color: Color(0xffFF0000)),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              context.w * 0.05,
                                                                        ),
                                                                        SizedBox(
                                                                            width: context.w *
                                                                                0.5,
                                                                            child:
                                                                                Text(
                                                                              myHistory[i]['pick_address'],
                                                                              style: GoogleFonts.roboto(fontSize: context.w * twelve),
                                                                            )),
                                                                        Expanded(
                                                                            child:
                                                                                Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            Text(
                                                                              '${myHistory[i]['trip_start_time'].toString().split(' ').toList()[2]} ${myHistory[i]['accepted_at'].toString().split(' ').toList()[3]}',
                                                                              style: GoogleFonts.roboto(fontSize: context.w * twelve, color: const Color(0xff898989)),
                                                                              textDirection: TextDirection.ltr,
                                                                            )
                                                                          ],
                                                                        ))
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height: context.w *
                                                                            0.05),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              context.w * 0.05,
                                                                          width:
                                                                              context.w * 0.05,
                                                                          alignment:
                                                                              Alignment.center,
                                                                          decoration: BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              color: const Color(0xff319900).withOpacity(0.3)),
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                context.w * 0.025,
                                                                            width:
                                                                                context.w * 0.025,
                                                                            decoration:
                                                                                const BoxDecoration(shape: BoxShape.circle, color: Color(0xff319900)),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              context.w * 0.05,
                                                                        ),
                                                                        SizedBox(
                                                                            width: context.w *
                                                                                0.5,
                                                                            child:
                                                                                Text(
                                                                              myHistory[i]['drop_address'],
                                                                              style: GoogleFonts.roboto(fontSize: context.w * twelve),
                                                                            )),
                                                                        Expanded(
                                                                            child:
                                                                                Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            Text(
                                                                              '${myHistory[i]['completed_at'].toString().split(' ').toList()[2]} ${myHistory[i]['completed_at'].toString().split(' ').toList()[3]}',
                                                                              style: GoogleFonts.roboto(fontSize: context.w * twelve, color: const Color(0xff898989)),
                                                                              textDirection: TextDirection.ltr,
                                                                            )
                                                                          ],
                                                                        ))
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : (_showHistory == 2)
                                                          ?

                                                          //rejected ride
                                                          Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  myHistory[i][
                                                                      'updated_at'],
                                                                  style: GoogleFonts.roboto(
                                                                      fontSize:
                                                                          context.w *
                                                                              sixteen,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color:
                                                                          textColor),
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets.only(
                                                                      top: context
                                                                              .w *
                                                                          0.025,
                                                                      bottom: context
                                                                              .w *
                                                                          0.05,
                                                                      left: context
                                                                              .w *
                                                                          0.015,
                                                                      right: context
                                                                              .w *
                                                                          0.015),
                                                                  width: context
                                                                          .w *
                                                                      0.85,
                                                                  padding: EdgeInsets.fromLTRB(
                                                                      context.w *
                                                                          0.025,
                                                                      context.w *
                                                                          0.05,
                                                                      context.w *
                                                                          0.025,
                                                                      context.w *
                                                                          0.05),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(12),
                                                                      color: page,
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                            blurRadius:
                                                                                2,
                                                                            spreadRadius:
                                                                                2,
                                                                            color:
                                                                                Colors.black.withOpacity(0.2))
                                                                      ]),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        myHistory[i]
                                                                            [
                                                                            'request_number'],
                                                                        style: GoogleFonts.roboto(
                                                                            fontSize: context.w *
                                                                                sixteen,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                      SizedBox(
                                                                        height: context.w *
                                                                            0.02,
                                                                      ),
                                                                      (myHistory[i]['driverDetail'] !=
                                                                              null)
                                                                          ? Container(
                                                                              padding: EdgeInsets.only(bottom: context.w * 0.05),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  Container(
                                                                                    height: context.w * 0.16,
                                                                                    width: context.w * 0.16,
                                                                                    decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: NetworkImage(myHistory[i]['driverDetail']['data']['profile_picture']), fit: BoxFit.cover)),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: context.w * 0.02,
                                                                                  ),
                                                                                  Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      SizedBox(
                                                                                        width: context.w * 0.3,
                                                                                        child: Text(
                                                                                          myHistory[i]['driverDetail']['data']['name'],
                                                                                          style: GoogleFonts.roboto(fontSize: context.w * eighteen, fontWeight: FontWeight.w600),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                                      children: [
                                                                                        Column(
                                                                                          children: [
                                                                                            const Icon(
                                                                                              Icons.cancel,
                                                                                              color: Color(0xffFF0000),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: context.w * 0.01,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          : Container(),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                context.w * 0.05,
                                                                            width:
                                                                                context.w * 0.05,
                                                                            alignment:
                                                                                Alignment.center,
                                                                            decoration:
                                                                                BoxDecoration(shape: BoxShape.circle, color: const Color(0xffFF0000).withOpacity(0.3)),
                                                                            child:
                                                                                Container(
                                                                              height: context.w * 0.025,
                                                                              width: context.w * 0.025,
                                                                              decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xffFF0000)),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                context.w * 0.05,
                                                                          ),
                                                                          SizedBox(
                                                                              width: context.w * 0.7,
                                                                              child: Text(
                                                                                myHistory[i]['pick_address'],
                                                                                style: GoogleFonts.roboto(fontSize: context.w * twelve),
                                                                              )),
                                                                        ],
                                                                      ),
                                                                      (myHistory[i]['drop_address'] !=
                                                                              null)
                                                                          ? Container(
                                                                              padding: EdgeInsets.only(top: context.w * 0.05),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  Container(
                                                                                    height: context.w * 0.05,
                                                                                    width: context.w * 0.05,
                                                                                    alignment: Alignment.center,
                                                                                    decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xff319900).withOpacity(0.3)),
                                                                                    child: Container(
                                                                                      height: context.w * 0.025,
                                                                                      width: context.w * 0.025,
                                                                                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xff319900)),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: context.w * 0.05,
                                                                                  ),
                                                                                  SizedBox(
                                                                                      width: context.w * 0.7,
                                                                                      child: Text(
                                                                                        myHistory[i]['drop_address'],
                                                                                        style: GoogleFonts.roboto(fontSize: context.w * twelve),
                                                                                      )),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          : Container(),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : (_showHistory == 0)
                                                              ?

                                                              //upcoming ride
                                                              Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          myHistory[i]
                                                                              [
                                                                              'trip_start_time'],
                                                                          style: GoogleFonts.roboto(
                                                                              fontSize: context.w * sixteen,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: textColor),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          top: context.w *
                                                                              0.025,
                                                                          bottom: context.w *
                                                                              0.05,
                                                                          left: context.w *
                                                                              0.015,
                                                                          right:
                                                                              context.w * 0.015),
                                                                      width: context
                                                                              .w *
                                                                          0.85,
                                                                      padding: EdgeInsets.fromLTRB(
                                                                          context.w *
                                                                              0.025,
                                                                          context.w *
                                                                              0.05,
                                                                          context.w *
                                                                              0.025,
                                                                          context.w *
                                                                              0.05),
                                                                      decoration: BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(12),
                                                                          color: page,
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                                blurRadius: 2,
                                                                                spreadRadius: 2,
                                                                                color: Colors.black.withOpacity(0.2))
                                                                          ]),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text(
                                                                                myHistory[i]['request_number'],
                                                                                style: GoogleFonts.roboto(fontSize: context.w * sixteen, fontWeight: FontWeight.w600),
                                                                              ),
                                                                              InkWell(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    _cancelRide = true;
                                                                                    _cancelId = myHistory[i]['id'];
                                                                                  });
                                                                                },
                                                                                child: Text(
                                                                                  languages[choosenLanguage]['text_cancel_ride'],
                                                                                  style: GoogleFonts.roboto(fontSize: context.w * sixteen, fontWeight: FontWeight.w600, color: buttonColor),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                context.w * 0.02,
                                                                          ),
                                                                          (myHistory[i]['driverDetail'] != null)
                                                                              ? Container(
                                                                                  padding: EdgeInsets.only(bottom: context.w * 0.05),
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        height: context.w * 0.16,
                                                                                        width: context.w * 0.16,
                                                                                        decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: NetworkImage(myHistory[i]['driverDetail']['data']['profile_picture']), fit: BoxFit.cover)),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: context.w * 0.02,
                                                                                      ),
                                                                                      Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          SizedBox(
                                                                                            width: context.w * 0.3,
                                                                                            child: Text(
                                                                                              myHistory[i]['driverDetail']['data']['name'],
                                                                                              style: GoogleFonts.roboto(fontSize: context.w * eighteen, fontWeight: FontWeight.w600),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      Expanded(
                                                                                        child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                                          children: [
                                                                                            Column(
                                                                                              children: [
                                                                                                const Icon(
                                                                                                  Icons.cancel,
                                                                                                  color: Color(0xffFF0000),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: context.w * 0.01,
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              : Container(),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              Container(
                                                                                height: context.w * 0.05,
                                                                                width: context.w * 0.05,
                                                                                alignment: Alignment.center,
                                                                                decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xffFF0000).withOpacity(0.3)),
                                                                                child: Container(
                                                                                  height: context.w * 0.025,
                                                                                  width: context.w * 0.025,
                                                                                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xffFF0000)),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: context.w * 0.05,
                                                                              ),
                                                                              SizedBox(
                                                                                  width: context.w * 0.7,
                                                                                  child: Text(
                                                                                    myHistory[i]['pick_address'],
                                                                                    style: GoogleFonts.roboto(fontSize: context.w * twelve),
                                                                                  )),
                                                                            ],
                                                                          ),
                                                                          (myHistory[i]['drop_address'] != null)
                                                                              ? Container(
                                                                                  padding: EdgeInsets.only(top: context.w * 0.05),
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        height: context.w * 0.05,
                                                                                        width: context.w * 0.05,
                                                                                        alignment: Alignment.center,
                                                                                        decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xff319900).withOpacity(0.3)),
                                                                                        child: Container(
                                                                                          height: context.w * 0.025,
                                                                                          width: context.w * 0.025,
                                                                                          decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xff319900)),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: context.w * 0.05,
                                                                                      ),
                                                                                      SizedBox(
                                                                                          width: context.w * 0.7,
                                                                                          child: Text(
                                                                                            myHistory[i]['drop_address'],
                                                                                            style: GoogleFonts.roboto(fontSize: context.w * twelve),
                                                                                          )),
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              : Container(),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : Container());
                                            })
                                            .values
                                            .toList(),
                                      )
                                    : (_isLoading == false)
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: context.w * 0.05,
                                              ),
                                              Container(
                                                height: context.w * 0.7,
                                                width: context.w * 0.7,
                                                decoration: const BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/history_bg.jpg'),
                                                        fit: BoxFit.contain)),
                                              ),
                                              SizedBox(
                                                height: context.w * 0.02,
                                              ),
                                              SizedBox(
                                                width: context.w * 0.9,
                                                child: Text(
                                                  languages[choosenLanguage]
                                                      ['text_noDataFound'],
                                                  style: GoogleFonts.roboto(
                                                      fontSize:
                                                          context.w * sixteen,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: textColor),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            ],
                                          )
                                        : Container(),
                                (myHistoryPage['pagination'] != null)
                                    ? (myHistoryPage['pagination']
                                                ['current_page'] <
                                            myHistoryPage['pagination']
                                                ['total_pages'])
                                        ? InkWell(
                                            onTap: () async {
                                              setState(() {
                                                _isLoading = true;
                                              });
                                              if (_showHistory == 0) {
                                                await getHistoryPages(
                                                    'is_later=1&page=${myHistoryPage['pagination']['current_page'] + 1}');
                                              } else if (_showHistory == 1) {
                                                await getHistoryPages(
                                                    'is_completed=1&page=${myHistoryPage['pagination']['current_page'] + 1}');
                                              } else if (_showHistory == 2) {
                                                await getHistoryPages(
                                                    'is_cancelled=1&page=${myHistoryPage['pagination']['current_page'] + 1}');
                                              }
                                              setState(() {
                                                _isLoading = false;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(
                                                  context.w * 0.025),
                                              margin: EdgeInsets.only(
                                                  bottom: context.w * 0.05),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: page,
                                                  border: Border.all(
                                                      color: borderLines,
                                                      width: 1.2)),
                                              child: Text(
                                                languages[choosenLanguage]
                                                    ['text_loadmore'],
                                                style: GoogleFonts.roboto(
                                                    fontSize:
                                                        context.w * sixteen,
                                                    color: textColor),
                                              ),
                                            ),
                                          )
                                        : Container()
                                    : Container()
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),

                    (_cancelRide == true)
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
                                        Container(
                                            height: context.h * 0.1,
                                            width: context.w * 0.1,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: page),
                                            child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _cancelRide = false;
                                                    _cancelId = '';
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
                                          languages[choosenLanguage]
                                              ['text_ridecancel'],
                                          style: GoogleFonts.roboto(
                                              fontSize: context.w * fourteen,
                                              color: textColor),
                                        ),
                                        SizedBox(
                                          height: context.w * 0.05,
                                        ),
                                        Button(
                                            onTap: () async {
                                              setState(() {
                                                _isLoading = true;
                                              });
                                              await cancelLaterRequest(
                                                  _cancelId);
                                              await _getHistory();
                                              setState(() {
                                                _cancelRide = false;
                                                _cancelId = '';
                                              });
                                            },
                                            text: languages[choosenLanguage]
                                                ['text_cancel_ride'])
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(),

                    //no internet
                    (internet == false)
                        ? Positioned(
                            top: 0,
                            child: NoInternet(
                              onTap: () {
                                setState(() {
                                  internetTrue();
                                });
                              },
                            ))
                        : Container(),

                    //loader
                    (_isLoading == true)
                        ? const Positioned(top: 0, child: Loading())
                        : Container()
                  ],
                ),
              );
            }));
  }
}
