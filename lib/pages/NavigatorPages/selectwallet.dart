import 'package:awii/core/constants/exports.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

// ignore: must_be_immutable
class SelectWallet extends StatefulWidget {
  dynamic from;
  SelectWallet({this.from, Key? key}) : super(key: key);

  @override
  State<SelectWallet> createState() => _SelectWalletState();
}

CardEditController cardController = CardEditController();

class _SelectWalletState extends State<SelectWallet> {
  bool _isLoading = false;
  bool _success = false;
  bool _failed = false;

  @override
  void initState() {
    if (walletBalance['stripe_environment'] == 'test') {
      Stripe.publishableKey = walletBalance['stripe_test_publishable_key'];
    } else {
      Stripe.publishableKey = walletBalance['stripe_live_publishable_key'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Material(
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
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(Icons.arrow_back)))
                            ],
                          ),
                          SizedBox(
                            height: context.w * 0.05,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //card design
                                CardField(
                                  controller: cardController,
                                  onCardChanged: (card) {
                                    setState(() {});
                                  },
                                ),
                                SizedBox(
                                  height: context.w * 0.1,
                                ),

                                //pay money button
                                Button(
                                    width: context.w * 0.5,
                                    onTap: () async {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      var val =
                                          await getStripePayment(addMoney);
                                      if (val == 'success') {
                                        var val2 = await Stripe.instance
                                            .confirmPayment(
                                          stripeToken['client_token'],
                                          PaymentMethodParams.card(
                                            paymentMethodData:
                                                PaymentMethodData(
                                              billingDetails: BillingDetails(
                                                  name: userDetails['name'],
                                                  phone: userDetails['mobile']),
                                            ),
                                          ),
                                        );
                                        if (val2.status ==
                                            PaymentIntentsStatus.Succeeded) {
                                          dynamic val3;
                                          if (widget.from == '1') {
                                            val3 =
                                                await payMoneyStripe(val2.id);
                                          } else {
                                            val3 = await addMoneyStripe(
                                                addMoney, val2.id);
                                          }
                                          if (val3 == 'success') {
                                            setState(() => _success = true);
                                          }
                                        } else {
                                          setState(() => _failed = true);
                                        }
                                      } else {
                                        setState(() => _failed = true);
                                      }
                                      setState(() => _isLoading = false);
                                    },
                                    text: 'Pay')
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    //failure error
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

                    //success popup
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
