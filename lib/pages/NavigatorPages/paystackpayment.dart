import 'package:awii/core/constants/exports.dart';

// ignore: must_be_immutable
class PayStackPage extends StatefulWidget {
  dynamic from;
  PayStackPage({this.from, Key? key}) : super(key: key);

  @override
  State<PayStackPage> createState() => _PayStackPageState();
}

class _PayStackPageState extends State<PayStackPage> {
  bool _isLoading = false;
  bool _success = false;
  String _error = '';
  // final plugin = PaystackPlugin();
  @override
  void initState() {
    if (walletBalance['paystack_environment'] == 'test') {
      payMoney();
      super.initState();
    }
  }

//payment gateway code

  payMoney() async {
    setState(() {
      _isLoading = true;
    });
    dynamic val;
    if (widget.from == '1') {
      val = await getPaystackPayment(jsonEncode(
          {'amount': addMoney * 100, 'payment_for': userRequestData['id']}));
    } else {
      val = await getPaystackPayment(jsonEncode({'amount': addMoney * 100}));
    }
    if (val != 'success') {
      _error = val.toString();
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
                          Expanded(
                            child: (paystackCode['authorization_url'] != null &&
                                    _error == '')
                                ? WebView(
                                    initialUrl:
                                        paystackCode['authorization_url'],
                                    javascriptMode: JavascriptMode.unrestricted,
                                    userAgent: 'Flutter;Webview',
                                  )
                                : Container(),
                          )
                        ],
                      ),
                    ),
                    //payment failed
                    (_error != '')
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
                                        SizedBox(
                                          width: context.w * 0.8,
                                          child: Text(
                                            _error.toString(),
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.roboto(
                                                fontSize: context.w * sixteen,
                                                color: textColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        SizedBox(
                                          height: context.w * 0.05,
                                        ),
                                        Button(
                                            onTap: () async {
                                              setState(() {
                                                _error = '';
                                              });
                                              Navigator.pop(context, false);
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

                    //success
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
