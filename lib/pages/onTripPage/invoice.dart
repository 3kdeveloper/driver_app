import 'package:awii/core/constants/exports.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  bool _choosePayment = false;
  bool _isLoading = false;

  @override
  void initState() {
    myMarkers.clear();
    promoCode = '';
    payingVia = 0;
    timing = 0.0;
    promoStatus = null;
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
              padding: EdgeInsets.fromLTRB(
                  context.w * 0.05,
                  MediaQuery.of(context).padding.top + context.w * 0.05,
                  context.w * 0.05,
                  context.w * 0.05),
              height: context.h * 1,
              width: context.w * 1,
              color: page,
              //invoice details
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            languages[choosenLanguage]['text_tripsummary'],
                            style: TextStyle(
                                fontSize: context.w * sixteen,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: context.h * 0.04,
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
                                            userRequestData['driverDetail']
                                                ['data']['profile_picture']),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                width: context.w * 0.05,
                              ),
                              Text(
                                userRequestData['driverDetail']['data']['name'],
                                style: TextStyle(
                                  fontSize: context.w * eighteen,
                                ),
                              )
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          languages[choosenLanguage]
                                              ['text_reference'],
                                          style: TextStyle(
                                              fontSize: context.w * twelve,
                                              color: const Color(0xff898989)),
                                        ),
                                        SizedBox(
                                          height: context.w * 0.02,
                                        ),
                                        Text(
                                          userRequestData['request_number'],
                                          style: TextStyle(
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
                                          style: TextStyle(
                                              fontSize: context.w * twelve,
                                              color: const Color(0xff898989)),
                                        ),
                                        SizedBox(
                                          height: context.w * 0.02,
                                        ),
                                        Text(
                                          (userRequestData['is_rental'] ==
                                                  false)
                                              ? languages[choosenLanguage]
                                                  ['text_regular']
                                              : languages[choosenLanguage]
                                                  ['text_rental'],
                                          style: TextStyle(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          languages[choosenLanguage]
                                              ['text_distance'],
                                          style: TextStyle(
                                              fontSize: context.w * twelve,
                                              color: const Color(0xff898989)),
                                        ),
                                        SizedBox(
                                          height: context.w * 0.02,
                                        ),
                                        Text(
                                          userRequestData['total_distance'] +
                                              ' ' +
                                              userRequestData['unit'],
                                          style: TextStyle(
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
                                          style: TextStyle(
                                              fontSize: context.w * twelve,
                                              color: const Color(0xff898989)),
                                        ),
                                        SizedBox(
                                          height: context.w * 0.02,
                                        ),
                                        Text(
                                          '${userRequestData['total_time']} mins',
                                          style: TextStyle(
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
                                style: TextStyle(
                                    fontSize: context.w * fourteen,
                                    color: textColor),
                              )
                            ],
                          ),
                          SizedBox(
                            height: context.h * 0.05,
                          ),
                          (userRequestData['is_rental'] == true)
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
                                        style: TextStyle(
                                            fontSize: context.w * fourteen,
                                            color: textColor),
                                      ),
                                      Text(
                                        userRequestData['rental_package_name'],
                                        style: TextStyle(
                                            fontSize: context.w * fourteen,
                                            color: textColor),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox.shrink(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                languages[choosenLanguage]['text_baseprice'],
                                style: TextStyle(
                                    fontSize: context.w * twelve,
                                    color: textColor),
                              ),
                              Text(
                                '${userRequestData['requestBill']['data']['requested_currency_symbol']} ${userRequestData['requestBill']['data']['base_price']}',
                                style: TextStyle(
                                    fontSize: context.w * twelve,
                                    color: textColor),
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
                                style: TextStyle(
                                    fontSize: context.w * twelve,
                                    color: textColor),
                              ),
                              Text(
                                userRequestData['requestBill']['data']
                                        ['requested_currency_symbol'] +
                                    ' ' +
                                    userRequestData['requestBill']['data']
                                            ['distance_price']
                                        .toString(),
                                style: TextStyle(
                                    fontSize: context.w * twelve,
                                    color: textColor),
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
                                style: TextStyle(
                                    fontSize: context.w * twelve,
                                    color: textColor),
                              ),
                              Text(
                                userRequestData['requestBill']['data']
                                        ['requested_currency_symbol'] +
                                    ' ' +
                                    userRequestData['requestBill']['data']
                                            ['time_price']
                                        .toString(),
                                style: TextStyle(
                                    fontSize: context.w * twelve,
                                    color: textColor),
                              ),
                            ],
                          ),
                          (userRequestData['requestBill']['data']
                                      ['cancellation_fee'] !=
                                  0)
                              ? SizedBox(
                                  height: context.h * 0.02,
                                )
                              : const SizedBox.shrink(),
                          (userRequestData['requestBill']['data']
                                      ['cancellation_fee'] !=
                                  0)
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      languages[choosenLanguage]
                                          ['text_cancelfee'],
                                      style: TextStyle(
                                          fontSize: context.w * twelve,
                                          color: textColor),
                                    ),
                                    Text(
                                      userRequestData['requestBill']['data']
                                              ['requested_currency_symbol'] +
                                          ' ' +
                                          userRequestData['requestBill']['data']
                                                  ['cancellation_fee']
                                              .toString(),
                                      style: TextStyle(
                                          fontSize: context.w * twelve,
                                          color: textColor),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          (userRequestData['requestBill']['data']
                                      ['airport_surge_fee'] !=
                                  0)
                              ? SizedBox(
                                  height: context.h * 0.02,
                                )
                              : const SizedBox.shrink(),
                          (userRequestData['requestBill']['data']
                                      ['airport_surge_fee'] !=
                                  0)
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      languages[choosenLanguage]
                                          ['text_surge_fee'],
                                      style: TextStyle(
                                          fontSize: context.w * twelve,
                                          color: textColor),
                                    ),
                                    Text(
                                      userRequestData['requestBill']['data']
                                              ['requested_currency_symbol'] +
                                          ' ' +
                                          userRequestData['requestBill']['data']
                                                  ['airport_surge_fee']
                                              .toString(),
                                      style: TextStyle(
                                          fontSize: context.w * twelve,
                                          color: textColor),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          SizedBox(height: context.h * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                languages[choosenLanguage]
                                        ['text_waiting_time_1'] +
                                    ' (' +
                                    userRequestData['requestBill']['data']
                                        ['requested_currency_symbol'] +
                                    ' ' +
                                    userRequestData['requestBill']['data']
                                            ['waiting_charge_per_min']
                                        .toString() +
                                    ' x ' +
                                    userRequestData['requestBill']['data']
                                            ['calculated_waiting_time']
                                        .toString() +
                                    ' mins' +
                                    ')',
                                style: TextStyle(
                                    fontSize: context.w * twelve,
                                    color: textColor),
                              ),
                              Text(
                                userRequestData['requestBill']['data']
                                        ['requested_currency_symbol'] +
                                    ' ' +
                                    userRequestData['requestBill']['data']
                                            ['waiting_charge']
                                        .toString(),
                                style: TextStyle(
                                    fontSize: context.w * twelve,
                                    color: textColor),
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
                                style: TextStyle(
                                    fontSize: context.w * twelve,
                                    color: textColor),
                              ),
                              Text(
                                userRequestData['requestBill']['data']
                                        ['requested_currency_symbol'] +
                                    ' ' +
                                    userRequestData['requestBill']['data']
                                            ['admin_commision']
                                        .toString(),
                                style: TextStyle(
                                    fontSize: context.w * twelve,
                                    color: textColor),
                              ),
                            ],
                          ),
                          (userRequestData['requestBill']['data']
                                      ['promo_discount'] !=
                                  null)
                              ? SizedBox(
                                  height: context.h * 0.02,
                                )
                              : const SizedBox.shrink(),
                          (userRequestData['requestBill']['data']
                                      ['promo_discount'] !=
                                  null)
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      languages[choosenLanguage]
                                          ['text_discount'],
                                      style: TextStyle(
                                          fontSize: context.w * twelve,
                                          color: Colors.red),
                                    ),
                                    Text(
                                      userRequestData['requestBill']['data']
                                              ['requested_currency_symbol'] +
                                          ' ' +
                                          userRequestData['requestBill']['data']
                                                  ['promo_discount']
                                              .toString(),
                                      style: TextStyle(
                                          fontSize: context.w * twelve,
                                          color: Colors.red),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          SizedBox(
                            height: context.h * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                languages[choosenLanguage]['text_taxes'],
                                style: TextStyle(
                                    fontSize: context.w * twelve,
                                    color: textColor),
                              ),
                              Text(
                                userRequestData['requestBill']['data']
                                        ['requested_currency_symbol'] +
                                    ' ' +
                                    userRequestData['requestBill']['data']
                                            ['service_tax']
                                        .toString(),
                                style: TextStyle(
                                    fontSize: context.w * twelve,
                                    color: textColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: context.h * 0.02,
                          ),
                          Container(
                            height: 1.5,
                            color: const Color(0xffE0E0E0),
                          ),
                          SizedBox(
                            height: context.h * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                languages[choosenLanguage]['text_totalfare'],
                                style: TextStyle(
                                    fontSize: context.w * twelve,
                                    color: textColor),
                              ),
                              Text(
                                userRequestData['requestBill']['data']
                                        ['requested_currency_symbol'] +
                                    ' ' +
                                    userRequestData['requestBill']['data']
                                            ['total_amount']
                                        .toString(),
                                style: TextStyle(
                                    fontSize: context.w * twelve,
                                    color: textColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: context.h * 0.02,
                          ),
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
                                (userRequestData['payment_opt'] == '1')
                                    ? languages[choosenLanguage]['text_cash']
                                    : (userRequestData['payment_opt'] == '2')
                                        ? languages[choosenLanguage]
                                            ['text_wallet']
                                        : languages[choosenLanguage]
                                            ['text_card'],
                                style: TextStyle(
                                    fontSize: context.w * sixteen,
                                    color: buttonColor),
                              ),
                              Text(
                                userRequestData['requestBill']['data']
                                        ['requested_currency_symbol'] +
                                    ' ' +
                                    userRequestData['requestBill']['data']
                                            ['total_amount']
                                        .toString(),
                                style: TextStyle(
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
                  Button(
                      onTap: () async {
                        if (userRequestData['payment_opt'] == '0' &&
                            userRequestData['is_paid'] == 0) {
                          setState(() {
                            _isLoading = true;
                          });
                          await getWalletHistory();
                          setState(() {
                            _isLoading = false;
                            _choosePayment = true;
                          });
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Review()));
                        }
                      },
                      text: (userRequestData['payment_opt'] == '0' &&
                              userRequestData['is_paid'] == 0)
                          ? languages[choosenLanguage]['text_pay']
                          : languages[choosenLanguage]['text_confirm'])
                ],
              ),
            ),

            //choose payment method
            (_choosePayment == true)
                ? Positioned(
                    child: Container(
                    height: context.h * 1,
                    width: context.w * 1,
                    color: Colors.transparent.withOpacity(0.6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: context.w * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _choosePayment = false;
                                  });
                                },
                                child: Container(
                                  height: context.h * 0.05,
                                  width: context.h * 0.05,
                                  decoration: BoxDecoration(
                                    color: page,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.cancel, color: buttonColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: context.w * 0.025),
                        Container(
                          padding: EdgeInsets.all(context.w * 0.05),
                          width: context.w * 0.8,
                          height: context.h * 0.6,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: page),
                          child: Column(
                            children: [
                              SizedBox(
                                  width: context.w * 0.7,
                                  child: Text(
                                    languages[choosenLanguage]
                                        ['text_choose_payment'],
                                    style: TextStyle(
                                        fontSize: context.w * eighteen,
                                        fontWeight: FontWeight.w600),
                                  )),
                              SizedBox(
                                height: context.w * 0.05,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Column(
                                    children: [
                                      (walletBalance['stripe'] == true)
                                          ? Container(
                                              margin: EdgeInsets.only(
                                                  bottom: context.w * 0.025),
                                              alignment: Alignment.center,
                                              width: context.w * 0.7,
                                              child: InkWell(
                                                onTap: () async {
                                                  addMoney = double.parse(
                                                      userRequestData['requestBill']
                                                                  ['data']
                                                              ['total_amount']
                                                          .toStringAsFixed(2));
                                                  var val =
                                                      await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SelectWallet(
                                                                    from: '1',
                                                                  )));
                                                  if (val != null) {
                                                    if (val) {
                                                      setState(() {
                                                        _isLoading = true;
                                                        _choosePayment = false;
                                                      });
                                                      await getUserDetails();
                                                      setState(() {
                                                        _isLoading = false;
                                                      });
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  width: context.w * 0.25,
                                                  height: context.w * 0.125,
                                                  decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              'assets/images/stripe-icon.png'),
                                                          fit: BoxFit.contain)),
                                                ),
                                              ))
                                          : const SizedBox.shrink(),
                                      (walletBalance['paystack'] == true)
                                          ? Container(
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.only(
                                                  bottom: context.w * 0.025),
                                              width: context.w * 0.7,
                                              child: InkWell(
                                                onTap: () async {
                                                  addMoney = int.parse(
                                                      userRequestData['requestBill']
                                                                  ['data']
                                                              ['total_amount']
                                                          .toStringAsFixed(0));
                                                  var val =
                                                      await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  PayStackPage(
                                                                    from: '1',
                                                                  )));
                                                  if (val != null) {
                                                    if (val) {
                                                      setState(() {
                                                        _isLoading = true;
                                                        _choosePayment = false;
                                                      });
                                                      await getUserDetails();
                                                      setState(() {
                                                        _isLoading = false;
                                                      });
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  width: context.w * 0.25,
                                                  height: context.w * 0.125,
                                                  decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              'assets/images/paystack-icon.png'),
                                                          fit: BoxFit.contain)),
                                                ),
                                              ))
                                          : const SizedBox.shrink(),
                                      (walletBalance['flutter_wave'] == true)
                                          ? Container(
                                              margin: EdgeInsets.only(
                                                  bottom: context.w * 0.025),
                                              alignment: Alignment.center,
                                              width: context.w * 0.7,
                                              child: InkWell(
                                                onTap: () async {
                                                  addMoney = double.parse(
                                                      userRequestData['requestBill']
                                                                  ['data']
                                                              ['total_amount']
                                                          .toStringAsFixed(2));
                                                  var val =
                                                      await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  FlutterWavePage(
                                                                    from: '1',
                                                                  )));
                                                  if (val != null) {
                                                    if (val) {
                                                      setState(() {
                                                        _choosePayment = false;
                                                      });
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  width: context.w * 0.25,
                                                  height: context.w * 0.125,
                                                  decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              'assets/images/flutterwave-icon.png'),
                                                          fit: BoxFit.contain)),
                                                ),
                                              ))
                                          : const SizedBox.shrink(),
                                      (walletBalance['razor_pay'] == true)
                                          ? Container(
                                              margin: EdgeInsets.only(
                                                  bottom: context.w * 0.025),
                                              alignment: Alignment.center,
                                              width: context.w * 0.7,
                                              child: InkWell(
                                                onTap: () async {
                                                  addMoney = int.parse(
                                                      userRequestData['requestBill']
                                                                  ['data']
                                                              ['total_amount']
                                                          .toStringAsFixed(0));
                                                  var val =
                                                      await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  RazorPayPage(
                                                                    from: '1',
                                                                  )));
                                                  if (val != null) {
                                                    if (val) {
                                                      setState(() {
                                                        _isLoading = true;
                                                        _choosePayment = false;
                                                      });
                                                      await getUserDetails();
                                                      setState(() {
                                                        _isLoading = false;
                                                      });
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  width: context.w * 0.25,
                                                  height: context.w * 0.125,
                                                  decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              'assets/images/razorpay-icon.jpeg'),
                                                          fit: BoxFit.contain)),
                                                ),
                                              ))
                                          : const SizedBox.shrink(),
                                      (walletBalance['cash_free'] == true)
                                          ? Container(
                                              margin: EdgeInsets.only(
                                                  bottom: context.w * 0.025),
                                              alignment: Alignment.center,
                                              width: context.w * 0.7,
                                              child: InkWell(
                                                onTap: () async {
                                                  addMoney = double.parse(
                                                      userRequestData['requestBill']
                                                                  ['data']
                                                              ['total_amount']
                                                          .toStringAsFixed(2));
                                                  var val =
                                                      await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  CashFreePage(
                                                                    from: '1',
                                                                  )));
                                                  if (val != null) {
                                                    if (val) {
                                                      setState(() {
                                                        _isLoading = true;
                                                        _choosePayment = false;
                                                      });
                                                      await getUserDetails();
                                                      setState(() =>
                                                          _isLoading = false);
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  width: context.w * 0.25,
                                                  height: context.w * 0.125,
                                                  decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              'assets/images/cashfree-icon.jpeg'),
                                                          fit: BoxFit.contain)),
                                                ),
                                              ))
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
                : const SizedBox.shrink(),

            if (_isLoading == true) const Positioned(child: Loading())
          ],
        ),
      ),
    );
  }
}
