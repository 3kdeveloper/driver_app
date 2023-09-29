import 'package:awii/core/constants/exports.dart';
import 'package:location/location.dart';

class Faq extends StatefulWidget {
  const Faq({Key? key}) : super(key: key);

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  bool _faqCompleted = false;
  bool _isLoading = true;
  dynamic _selectedQuestion;

  @override
  void initState() {
    faqDatas();
    super.initState();
  }

//get faq data
  faqDatas() async {
    if (currentLocation != null) {
      await getFaqData(currentLocation.latitude, currentLocation.longitude);
      setState(() {
        _faqCompleted = true;
        _isLoading = false;
      });
    } else {
      var loc = await Location.instance.getLocation();
      await getFaqData(loc.latitude, loc.longitude);
      setState(() {
        _faqCompleted = true;
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
                                languages[choosenLanguage]['text_faq'],
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
                        SizedBox(height: context.w * 0.05),
                        SizedBox(
                          width: context.w * 0.9,
                          height: context.h * 0.16,
                          child: Image.asset(
                            'assets/images/faq_bg.jpg',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: context.w * 0.05),
                        Expanded(
                          child: SingleChildScrollView(
                            child: (faqData.isNotEmpty)
                                ? Column(
                                    children: faqData
                                        .asMap()
                                        .map((i, value) {
                                          return MapEntry(
                                              i,
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _selectedQuestion = i;
                                                  });
                                                },
                                                child: Container(
                                                  width: context.w * 0.9,
                                                  margin: EdgeInsets.only(
                                                      top: context.w * 0.025,
                                                      bottom:
                                                          context.w * 0.025),
                                                  padding: EdgeInsets.all(
                                                      context.w * 0.05),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: page,
                                                      border: Border.all(
                                                          color: borderLines,
                                                          width: 1.2)),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                              // color: Colors.red,
                                                              width: context.w *
                                                                  0.7,
                                                              child: Text(
                                                                faqData[i][
                                                                    'question'],
                                                                style: GoogleFonts.roboto(
                                                                    fontSize: context
                                                                            .w *
                                                                        fourteen,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color:
                                                                        textColor),
                                                              )),
                                                          RotatedBox(
                                                              quarterTurns:
                                                                  (_selectedQuestion ==
                                                                          i)
                                                                      ? 2
                                                                      : 0,
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/chevron-down.png',
                                                                width:
                                                                    context.w *
                                                                        0.075,
                                                              ))
                                                        ],
                                                      ),
                                                      AnimatedContainer(
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    200),
                                                        child: (_selectedQuestion ==
                                                                i)
                                                            ? Container(
                                                                padding: EdgeInsets.only(
                                                                    top: context
                                                                            .w *
                                                                        0.025),
                                                                child: Text(
                                                                  faqData[i][
                                                                      'answer'],
                                                                  style: GoogleFonts.roboto(
                                                                      fontSize:
                                                                          context.w *
                                                                              twelve,
                                                                      color:
                                                                          textColor),
                                                                ))
                                                            : Container(),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ));
                                        })
                                        .values
                                        .toList(),
                                  )
                                : (_faqCompleted == true)
                                    ? Text(
                                        languages[choosenLanguage]
                                            ['text_noDataFound'],
                                        style: GoogleFonts.roboto(
                                            fontSize: context.w * eighteen,
                                            fontWeight: FontWeight.w600,
                                            color: textColor),
                                      )
                                    : Container(),
                          ),
                        )
                      ],
                    ),
                  ),

                  //no internet
                  (internet == false)
                      ? Positioned(
                          top: 0,
                          child: NoInternet(
                            onTap: () {
                              setState(() {
                                internetTrue();
                                _isLoading = true;
                                _faqCompleted = false;
                                faqDatas();
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
    );
  }
}
