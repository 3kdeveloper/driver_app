import 'package:awii/core/constants/exports.dart';

class HistoryDetails extends StatefulWidget {
  const HistoryDetails({Key? key}) : super(key: key);

  @override
  State<HistoryDetails> createState() => _HistoryDetailsState();
}

class _HistoryDetailsState extends State<HistoryDetails> {
  List _tripStops = [];

  @override
  void initState() {
    _tripStops = myHistory[selectedHistory]['requestStops']['data'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Directionality(
        textDirection: (languageDirection == 'rtl')
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Container(
          padding: EdgeInsets.fromLTRB(
              context.w * 0.05,
              MediaQuery.of(context).padding.top + context.w * 0.05,
              context.w * 0.05,
              0),
          height: context.h * 1,
          width: context.w * 1,
          color: page,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: context.w * 0.05),
                    width: context.w * 0.9,
                    alignment: Alignment.center,
                    child: Text(
                      languages[choosenLanguage]['text_tripsummary'],
                      style: GoogleFonts.roboto(
                          fontSize: context.w * sixteen,
                          fontWeight: FontWeight.bold),
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

                  //history details
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: context.h * 0.04,
                      ),
                      SizedBox(
                        width: context.w * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              languages[choosenLanguage]['text_location'],
                              style: GoogleFonts.roboto(
                                  fontSize: context.w * sixteen,
                                  color: textColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: context.h * 0.02,
                      ),
                      Container(
                        padding: EdgeInsets.all(context.w * 0.034),
                        margin: EdgeInsets.only(
                          bottom: context.h * 0.03,
                        ),
                        // height: context.w * 0.21,
                        width: context.w * 0.9,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: borderLines,
                            width: 1.2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: context.w * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: context.w * 0.025,
                                  width: context.w * 0.025,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xff319900)
                                          .withOpacity(0.3)),
                                  child: Container(
                                    height: context.w * 0.01,
                                    width: context.w * 0.01,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff319900)),
                                  ),
                                ),
                                SizedBox(
                                  width: context.w * 0.75,
                                  child: Text(
                                    myHistory[selectedHistory]['pick_address'],
                                    style: GoogleFonts.roboto(
                                        fontSize: context.w * twelve,
                                        color: textColor),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: context.w * 0.025,
                            ),
                            Column(
                              children: _tripStops
                                  .asMap()
                                  .map((i, value) {
                                    return MapEntry(
                                        i,
                                        (i < _tripStops.length - 1)
                                            ? Container(
                                                padding: EdgeInsets.only(
                                                    bottom: context.w * 0.025),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      (i + 1).toString(),
                                                      style: GoogleFonts.roboto(
                                                          fontSize: context.w *
                                                              twelve,
                                                          color: const Color(
                                                              0xffFF0000)),
                                                    ),
                                                    SizedBox(
                                                        width: context.w * 0.75,
                                                        child: Text(
                                                          _tripStops[i]
                                                              ['address'],
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize:
                                                                      context.w *
                                                                          twelve,
                                                                  color:
                                                                      textColor),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ))
                                                  ],
                                                ),
                                              )
                                            : Container());
                                  })
                                  .values
                                  .toList(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: context.w * 0.025,
                                  width: context.w * 0.025,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xffFF0000)
                                          .withOpacity(0.3)),
                                  child: Container(
                                    height: context.w * 0.01,
                                    width: context.w * 0.01,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffFF0000)),
                                  ),
                                ),
                                SizedBox(
                                  width: context.w * 0.75,
                                  child: Text(
                                    myHistory[selectedHistory]['drop_address'],
                                    style: GoogleFonts.roboto(
                                        fontSize: context.w * twelve,
                                        color: textColor),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: context.w * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: context.w * 0.05,
                                width: context.w * 0.05,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: buttonColor),
                                child: Icon(
                                  Icons.done,
                                  size: context.w * 0.04,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: context.w * 0.02,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: context.w * 0.16,
                                child: Text(
                                  languages[choosenLanguage]['text_assigned'],
                                  style: GoogleFonts.roboto(
                                      fontSize: context.w * twelve,
                                      color: textColor.withOpacity(0.4)),
                                ),
                              ),
                              SizedBox(
                                height: context.w * 0.02,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: context.w * 0.16,
                                child: Text(
                                  '${myHistory[selectedHistory]['accepted_at'].toString().split(' ').toList()[2]} ${myHistory[selectedHistory]['accepted_at'].toString().split(' ').toList()[3]}',
                                  style: GoogleFonts.roboto(
                                      fontSize: context.w * twelve,
                                      color: textColor.withOpacity(0.4)),
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: context.w * 0.025),
                            height: 1,
                            width: context.w * 0.15,
                            color: buttonColor,
                          ),
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: context.w * 0.05,
                                width: context.w * 0.05,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: buttonColor),
                                child: Icon(
                                  Icons.done,
                                  size: context.w * 0.04,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: context.w * 0.02,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: context.w * 0.16,
                                child: Text(
                                  languages[choosenLanguage]['text_started'],
                                  style: GoogleFonts.roboto(
                                      fontSize: context.w * twelve,
                                      color: textColor.withOpacity(0.4)),
                                ),
                              ),
                              SizedBox(
                                height: context.w * 0.02,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: context.w * 0.16,
                                child: Text(
                                  '${myHistory[selectedHistory]['trip_start_time'].toString().split(' ').toList()[2]} ${myHistory[selectedHistory]['trip_start_time'].toString().split(' ').toList()[3]}',
                                  style: GoogleFonts.roboto(
                                      fontSize: context.w * twelve,
                                      color: textColor.withOpacity(0.4)),
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: context.w * 0.025),
                            height: 1,
                            width: context.w * 0.15,
                            color: buttonColor,
                          ),
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: context.w * 0.05,
                                width: context.w * 0.05,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: buttonColor),
                                child: Icon(
                                  Icons.done,
                                  size: context.w * 0.04,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: context.w * 0.02,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: context.w * 0.16,
                                child: Text(
                                  languages[choosenLanguage]['text_completed'],
                                  style: GoogleFonts.roboto(
                                      fontSize: context.w * twelve,
                                      color: textColor.withOpacity(0.4)),
                                ),
                              ),
                              SizedBox(
                                height: context.w * 0.02,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: context.w * 0.16,
                                child: Text(
                                  '${myHistory[selectedHistory]['completed_at'].toString().split(' ').toList()[2]} ${myHistory[selectedHistory]['completed_at'].toString().split(' ').toList()[3]}',
                                  style: GoogleFonts.roboto(
                                      fontSize: context.w * twelve,
                                      color: textColor.withOpacity(0.4)),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: context.w * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: context.w * 0.13,
                            width: context.w * 0.13,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        myHistory[selectedHistory]
                                                ['driverDetail']['data']
                                            ['profile_picture']),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(
                            width: context.w * 0.05,
                          ),
                          Text(
                            myHistory[selectedHistory]['driverDetail']['data']
                                ['name'],
                            style: GoogleFonts.roboto(
                              fontSize: context.w * eighteen,
                            ),
                          ),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                myHistory[selectedHistory]['ride_user_rating']
                                    .toString(),
                                style: GoogleFonts.roboto(
                                    fontSize: context.w * eighteen,
                                    fontWeight: FontWeight.w600),
                              ),
                              Icon(
                                Icons.star,
                                size: context.w * twenty,
                                color: buttonColor,
                              )
                            ],
                          ))
                        ],
                      ),
                      SizedBox(
                        height: context.h * 0.05,
                      ),
                      SizedBox(
                        width: context.w * 0.72,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      languages[choosenLanguage]
                                          ['text_reference'],
                                      style: GoogleFonts.roboto(
                                          fontSize: context.w * twelve,
                                          color: const Color(0xff898989)),
                                    ),
                                    SizedBox(
                                      height: context.w * 0.02,
                                    ),
                                    Text(
                                      myHistory[selectedHistory]
                                          ['request_number'],
                                      style: GoogleFonts.roboto(
                                          fontSize: context.w * fourteen,
                                          color: textColor),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      languages[choosenLanguage]
                                          ['text_rideType'],
                                      style: GoogleFonts.roboto(
                                          fontSize: context.w * twelve,
                                          color: const Color(0xff898989)),
                                    ),
                                    SizedBox(
                                      height: context.w * 0.02,
                                    ),
                                    Text(
                                      (myHistory[selectedHistory]
                                                  ['is_rental'] ==
                                              false)
                                          ? languages[choosenLanguage]
                                              ['text_regular']
                                          : languages[choosenLanguage]
                                              ['text_rental'],
                                      style: GoogleFonts.roboto(
                                          fontSize: context.w * fourteen,
                                          color: textColor),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: context.h * 0.02,
                            ),
                            Container(
                              height: 2,
                              color: const Color(0xffAAAAAA),
                            ),
                            SizedBox(
                              height: context.h * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      languages[choosenLanguage]
                                          ['text_distance'],
                                      style: GoogleFonts.roboto(
                                          fontSize: context.w * twelve,
                                          color: const Color(0xff898989)),
                                    ),
                                    SizedBox(
                                      height: context.w * 0.02,
                                    ),
                                    Text(
                                      myHistory[selectedHistory]
                                              ['total_distance'] +
                                          ' ' +
                                          myHistory[selectedHistory]['unit'],
                                      style: GoogleFonts.roboto(
                                          fontSize: context.w * fourteen,
                                          color: textColor),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      languages[choosenLanguage]
                                          ['text_duration'],
                                      style: GoogleFonts.roboto(
                                          fontSize: context.w * twelve,
                                          color: const Color(0xff898989)),
                                    ),
                                    SizedBox(
                                      height: context.w * 0.02,
                                    ),
                                    Text(
                                      '${myHistory[selectedHistory]['total_time']} mins',
                                      style: GoogleFonts.roboto(
                                          fontSize: context.w * fourteen,
                                          color: textColor),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: context.h * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.info),
                          SizedBox(
                            width: context.w * 0.04,
                          ),
                          Text(
                            languages[choosenLanguage]['text_tripfare'],
                            style: GoogleFonts.roboto(
                                fontSize: context.w * fourteen,
                                color: textColor),
                          )
                        ],
                      ),
                      SizedBox(
                        height: context.h * 0.05,
                      ),
                      (myHistory[selectedHistory]['is_rental'] == true)
                          ? Container(
                              padding:
                                  EdgeInsets.only(bottom: context.w * 0.05),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    languages[choosenLanguage]
                                        ['text_ride_type'],
                                    style: GoogleFonts.roboto(
                                        fontSize: context.w * fourteen,
                                        color: textColor),
                                  ),
                                  Text(
                                    myHistory[selectedHistory]
                                        ['rental_package_name'],
                                    style: GoogleFonts.roboto(
                                        fontSize: context.w * fourteen,
                                        color: textColor),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            languages[choosenLanguage]['text_baseprice'],
                            style: GoogleFonts.roboto(
                                fontSize: context.w * twelve, color: textColor),
                          ),
                          Text(
                            myHistory[selectedHistory]['requestBill']['data']
                                    ['requested_currency_symbol'] +
                                ' ' +
                                myHistory[selectedHistory]['requestBill']
                                        ['data']['base_price']
                                    .toString(),
                            style: GoogleFonts.roboto(
                                fontSize: context.w * twelve, color: textColor),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: context.h * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            languages[choosenLanguage]['text_distprice'],
                            style: GoogleFonts.roboto(
                                fontSize: context.w * twelve, color: textColor),
                          ),
                          Text(
                            myHistory[selectedHistory]['requestBill']['data']
                                    ['requested_currency_symbol'] +
                                ' ' +
                                myHistory[selectedHistory]['requestBill']
                                        ['data']['distance_price']
                                    .toString(),
                            style: GoogleFonts.roboto(
                                fontSize: context.w * twelve, color: textColor),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: context.h * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            languages[choosenLanguage]['text_timeprice'],
                            style: GoogleFonts.roboto(
                                fontSize: context.w * twelve, color: textColor),
                          ),
                          Text(
                            myHistory[selectedHistory]['requestBill']['data']
                                    ['requested_currency_symbol'] +
                                ' ' +
                                myHistory[selectedHistory]['requestBill']
                                        ['data']['time_price']
                                    .toString(),
                            style: GoogleFonts.roboto(
                                fontSize: context.w * twelve, color: textColor),
                          ),
                        ],
                      ),
                      (myHistory[selectedHistory]['requestBill']['data']
                                  ['cancellation_fee'] !=
                              0)
                          ? SizedBox(
                              height: context.h * 0.02,
                            )
                          : Container(),
                      (myHistory[selectedHistory]['requestBill']['data']
                                  ['cancellation_fee'] !=
                              0)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  languages[choosenLanguage]['text_cancelfee'],
                                  style: GoogleFonts.roboto(
                                      fontSize: context.w * twelve,
                                      color: textColor),
                                ),
                                Text(
                                  myHistory[selectedHistory]['requestBill']
                                              ['data']
                                          ['requested_currency_symbol'] +
                                      ' ' +
                                      myHistory[selectedHistory]['requestBill']
                                              ['data']['cancellation_fee']
                                          .toString(),
                                  style: GoogleFonts.roboto(
                                      fontSize: context.w * twelve,
                                      color: textColor),
                                ),
                              ],
                            )
                          : Container(),
                      (myHistory[selectedHistory]['requestBill']['data']
                                  ['airport_surge_fee'] !=
                              0)
                          ? SizedBox(
                              height: context.h * 0.02,
                            )
                          : Container(),
                      (myHistory[selectedHistory]['requestBill']['data']
                                  ['airport_surge_fee'] !=
                              0)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  languages[choosenLanguage]['text_surge_fee'],
                                  style: GoogleFonts.roboto(
                                      fontSize: context.w * twelve,
                                      color: textColor),
                                ),
                                Text(
                                  myHistory[selectedHistory]['requestBill']
                                              ['data']
                                          ['requested_currency_symbol'] +
                                      ' ' +
                                      myHistory[selectedHistory]['requestBill']
                                              ['data']['airport_surge_fee']
                                          .toString(),
                                  style: GoogleFonts.roboto(
                                      fontSize: context.w * twelve,
                                      color: textColor),
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: context.h * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            languages[choosenLanguage]['text_waiting_time_1'] +
                                ' (' +
                                myHistory[selectedHistory]['requestBill']
                                    ['data']['requested_currency_symbol'] +
                                ' ' +
                                myHistory[selectedHistory]['requestBill']
                                        ['data']['waiting_charge_per_min']
                                    .toString() +
                                ' x ' +
                                myHistory[selectedHistory]['requestBill']
                                        ['data']['calculated_waiting_time']
                                    .toString() +
                                ' mins' +
                                ')',
                            style: GoogleFonts.roboto(
                                fontSize: context.w * twelve, color: textColor),
                          ),
                          Text(
                            myHistory[selectedHistory]['requestBill']['data']
                                    ['requested_currency_symbol'] +
                                ' ' +
                                myHistory[selectedHistory]['requestBill']
                                        ['data']['waiting_charge']
                                    .toString(),
                            style: GoogleFonts.roboto(
                                fontSize: context.w * twelve, color: textColor),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: context.h * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            languages[choosenLanguage]['text_convfee'],
                            style: GoogleFonts.roboto(
                                fontSize: context.w * twelve, color: textColor),
                          ),
                          Text(
                            myHistory[selectedHistory]['requestBill']['data']
                                    ['requested_currency_symbol'] +
                                ' ' +
                                myHistory[selectedHistory]['requestBill']
                                        ['data']['admin_commision']
                                    .toString(),
                            style: GoogleFonts.roboto(
                                fontSize: context.w * twelve, color: textColor),
                          ),
                        ],
                      ),
                      (myHistory[selectedHistory]['requestBill']['data']
                                  ['promo_discount'] !=
                              null)
                          ? SizedBox(
                              height: context.h * 0.02,
                            )
                          : Container(),
                      (myHistory[selectedHistory]['requestBill']['data']
                                  ['promo_discount'] !=
                              null)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  languages[choosenLanguage]['text_discount'],
                                  style: GoogleFonts.roboto(
                                      fontSize: context.w * twelve,
                                      color: Colors.red),
                                ),
                                Text(
                                  myHistory[selectedHistory]['requestBill']
                                              ['data']
                                          ['requested_currency_symbol'] +
                                      ' ' +
                                      myHistory[selectedHistory]['requestBill']
                                              ['data']['promo_discount']
                                          .toString(),
                                  style: GoogleFonts.roboto(
                                      fontSize: context.w * twelve,
                                      color: Colors.red),
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: context.h * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            languages[choosenLanguage]['text_taxes'],
                            style: GoogleFonts.roboto(
                                fontSize: context.w * twelve, color: textColor),
                          ),
                          Text(
                            myHistory[selectedHistory]['requestBill']['data']
                                    ['requested_currency_symbol'] +
                                ' ' +
                                myHistory[selectedHistory]['requestBill']
                                        ['data']['service_tax']
                                    .toString(),
                            style: GoogleFonts.roboto(
                                fontSize: context.w * twelve, color: textColor),
                          ),
                        ],
                      ),
                      SizedBox(height: context.h * 0.02),
                      Container(
                        height: 1.5,
                        color: const Color(0xffE0E0E0),
                      ),
                      SizedBox(height: context.h * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            languages[choosenLanguage]['text_totalfare'],
                            style: GoogleFonts.roboto(
                                fontSize: context.w * twelve, color: textColor),
                          ),
                          Text(
                            myHistory[selectedHistory]['requestBill']['data']
                                    ['requested_currency_symbol'] +
                                ' ' +
                                myHistory[selectedHistory]['requestBill']
                                        ['data']['total_amount']
                                    .toString(),
                            style: GoogleFonts.roboto(
                                fontSize: context.w * twelve, color: textColor),
                          ),
                        ],
                      ),
                      SizedBox(height: context.h * 0.02),
                      Container(
                        height: 1.5,
                        color: const Color(0xffE0E0E0),
                      ),
                      // SizedBox(height: context.h*0.02,),
                      SizedBox(
                        height: context.h * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            (myHistory[selectedHistory]['payment_opt'] == '1')
                                ? languages[choosenLanguage]['text_cash']
                                : (myHistory[selectedHistory]['payment_opt'] ==
                                        '2')
                                    ? languages[choosenLanguage]['text_wallet']
                                    : '',
                            style: GoogleFonts.roboto(
                                fontSize: context.w * sixteen,
                                color: buttonColor),
                          ),
                          Text(
                            myHistory[selectedHistory]['requestBill']['data']
                                    ['requested_currency_symbol'] +
                                ' ' +
                                myHistory[selectedHistory]['requestBill']
                                        ['data']['total_amount']
                                    .toString(),
                            style: GoogleFonts.roboto(
                                fontSize: context.w * twentysix,
                                color: textColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              //make complaint button
              Container(
                padding: EdgeInsets.all(context.w * 0.05),
                child: Button(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MakeComplaint(fromPage: 1)));
                    },
                    text: languages[choosenLanguage]['text_make_complaints']),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
