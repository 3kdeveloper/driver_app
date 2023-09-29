import 'package:awii/core/constants/exports.dart';

// ignore: must_be_immutable
class CashFreePage extends StatefulWidget {
  dynamic from;
  CashFreePage({this.from, Key? key}) : super(key: key);

  @override
  State<CashFreePage> createState() => _CashFreePageState();
}

class _CashFreePageState extends State<CashFreePage> {
  bool _isLoading = false;
  bool _success = false;
  bool _failed = false;

  @override
  void initState() {
    payMoney();
    super.initState();
  }

//payment code
  payMoney() async {
    setState(() => _isLoading = true);
    var getToken =
        await getCfToken(addMoney.toString(), walletBalance['currency_code']);
    if (getToken == 'success') {
      await CashfreePGSDK.doPayment({
        'appId': (walletBalance['cashfree_environment'] == 'test')
            ? walletBalance['cashfree_test_app_id']
            : walletBalance['cashfree_live_app_id'],
        'stage':
            (walletBalance['cashfree_environment'] == 'test') ? 'TEST' : 'PROD',
        'orderId': cftToken['orderId'],
        'orderAmount': addMoney.toString(),
        'orderCurrency': walletBalance['currency_code'],
        'customerPhone': userDetails['mobile'],
        'customerEmail': userDetails['email'],
        'tokenData': cftToken['cftoken'],
        'color1': '#FCB13D',
        'color2': '#ffffff',
        'customerName': userDetails['name']
      }).then((value) async {
        cfSuccessList = jsonDecode(jsonEncode(value));
        if (cfSuccessList['txStatus'] == 'SUCCESS') {
          dynamic verify;
          if (widget.from == '1') {
            verify = await payMoneyStripe(cfSuccessList['orderId']);
          } else {
            verify = await cashFreePaymentSuccess();
          }
          if (verify == 'success') {
            setState(() {
              _success = true;
              _isLoading = false;
            });
          } else {
            setState(() {
              _failed = true;
              _isLoading = false;
            });
          }
        } else {
          setState(() {
            _failed = true;
          });
        }
      });
    } else {
      setState(() {
        _failed = true;
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Material(
        child: ValueListenableBuilder(
            valueListenable: valueNotifierHome.value,
            builder: (context, value, child) {
              return Directionality(
                textDirection: (languageDirection == 'rtl')
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(context.w * 0.05,
                          context.w * 0.05, context.w * 0.05, 0),
                      height: context.h * 1,
                      width: context.w * 1,
                      color: page,
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).padding.top),
                          Stack(
                            children: [
                              Container(
                                padding:
                                    EdgeInsets.only(bottom: context.w * 0.05),
                                width: context.w * 0.9,
                                alignment: Alignment.center,
                                child: Text(
                                  languages[choosenLanguage]['text_addmoney'],
                                  style: GoogleFonts.roboto(
                                      fontSize: context.w * sixteen,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Positioned(
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context, true);
                                      },
                                      child: const Icon(Icons.arrow_back)))
                            ],
                          ),
                          SizedBox(
                            height: context.w * 0.05,
                          ),
                        ],
                      ),
                    ),
                    //payment failed
                    (_failed == true)
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
                                              ['text_somethingwentwrong'],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                              fontSize: context.w * sixteen,
                                              color: textColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: context.w * 0.05,
                                        ),
                                        Button(
                                            onTap: () async {
                                              setState(() {
                                                _failed = false;
                                              });
                                              Navigator.pop(context, true);
                                            },
                                            text: languages[choosenLanguage]
                                                ['text_ok'])
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ))
                        : Container(),

                    //payment success
                    (_success == true)
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
                                              ['text_paymentsuccess'],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                              fontSize: context.w * sixteen,
                                              color: textColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: context.w * 0.05,
                                        ),
                                        Button(
                                            onTap: () async {
                                              setState(() {
                                                _success = false;
                                                // super.detachFromGLContext();
                                                Navigator.pop(context, true);
                                              });
                                            },
                                            text: languages[choosenLanguage]
                                                ['text_ok'])
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ))
                        : Container(),

                    //no internet
                    (internet == false)
                        ? Positioned(
                            top: 0,
                            child: NoInternet(
                              onTap: () {
                                setState(() {
                                  internetTrue();
                                  _isLoading = true;
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
            }),
      ),
    );
  }
}
