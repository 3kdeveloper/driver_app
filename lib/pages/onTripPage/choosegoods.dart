import 'package:awii/core/constants/exports.dart';

class ChooseGoods extends StatefulWidget {
  const ChooseGoods({Key? key}) : super(key: key);

  @override
  State<ChooseGoods> createState() => _ChooseGoodsState();
}

String selectedGoodsId = '';
String vehicleIconType = '';
dynamic _selGoods;

class _ChooseGoodsState extends State<ChooseGoods> {
  TextEditingController goodsText = TextEditingController();

  bool _isLoading = true;

  @override
  void initState() {
    _selGoods = null;
    goodsTypeList.clear();
    getGoods();
    super.initState();
  }

  getGoods() async {
    await getGoodsList();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(vehicleIconType);
    return Material(
      child: Directionality(
        textDirection: (languageDirection == 'rtl')
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: context.h * 1,
                width: context.w * 1,
                color: page,
                padding: EdgeInsets.only(
                    left: context.w * 0.05, right: context.w * 0.05),
                child: Column(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).padding.top +
                            context.w * 0.05),
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: context.w * 0.05),
                          width: context.w * 1,
                          alignment: Alignment.center,
                          child: Text(
                            languages[choosenLanguage]['text_choose_goods'],
                            style: GoogleFonts.poppins(
                                fontSize: context.w * twenty,
                                fontWeight: FontWeight.w600,
                                color: textColor),
                          ),
                        ),
                        Positioned(
                            child: InkWell(
                                onTap: () {
                                  Navigator.pop(context, false);
                                },
                                child: const Icon(Icons.arrow_back)))
                      ],
                    ),
                    SizedBox(
                      height: context.w * 0.05,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                          children: goodsTypeList
                              .asMap()
                              .map((i, value) {
                                return MapEntry(
                                    i,
                                    Container(
                                      width: context.w * 0.9,
                                      padding: EdgeInsets.all(context.w * 0.02),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _selGoods = goodsTypeList[i]['id']
                                                .toString();
                                            goodsSize =
                                                languages[choosenLanguage]
                                                    ['text_loose'];
                                            goodsText.clear();
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: context.w * 0.6,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    child: (goodsTypeList[i]
                                                                    ['icon'] ??
                                                                '') ==
                                                            ''
                                                        ? Container(
                                                            width: 40,
                                                            height: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: Colors.grey
                                                                  .shade300,
                                                            ),
                                                          )
                                                        : Image.network(
                                                            goodsTypeList[i]
                                                                    ['icon'] ??
                                                                '',
                                                            width: 40,
                                                            height: 40,
                                                            fit: BoxFit.cover,
                                                          ),
                                                  ),
                                                  SizedBox(
                                                      width: context.w * 0.05),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        goodsTypeList[i]
                                                            ['goods_type_name'],
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize:
                                                                    context.w *
                                                                        sixteen),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      (_selGoods ==
                                                                  goodsTypeList[
                                                                              i]
                                                                          ['id']
                                                                      .toString() &&
                                                              goodsSize != '')
                                                          ? Text(
                                                              goodsSize,
                                                              style: GoogleFonts.poppins(
                                                                  fontSize:
                                                                      context.w *
                                                                          twelve,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            )
                                                          : const SizedBox
                                                              .shrink()
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: context.w * 0.05,
                                              width: context.w * 0.05,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  shape: BoxShape.circle),
                                              alignment: Alignment.center,
                                              child: (_selGoods ==
                                                      goodsTypeList[i]['id']
                                                          .toString())
                                                  ? Container(
                                                      height: context.w * 0.03,
                                                      width: context.w * 0.03,
                                                      decoration:
                                                          const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  Colors.black),
                                                    )
                                                  : const SizedBox.shrink(),
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                              })
                              .values
                              .toList()),
                    )),
                    SizedBox(
                      height: context.w * 0.025,
                    ),
                    (_selGoods != null)
                        ? Container(
                            margin: EdgeInsets.only(bottom: context.w * 0.025),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (goodsSize !=
                                            languages[choosenLanguage]
                                                ['text_loose']) {
                                          setState(() {
                                            goodsSize =
                                                languages[choosenLanguage]
                                                    ['text_loose'];
                                            goodsText.clear();
                                          });
                                        }
                                      },
                                      child: Container(
                                        height: context.w * 0.04,
                                        width: context.w * 0.04,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            shape: BoxShape.circle),
                                        alignment: Alignment.center,
                                        child: (goodsSize ==
                                                languages[choosenLanguage]
                                                    ['text_loose'])
                                            ? Container(
                                                height: context.w * 0.02,
                                                width: context.w * 0.02,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.black),
                                              )
                                            : const SizedBox.shrink(),
                                      ),
                                    ),
                                    SizedBox(
                                      width: context.w * 0.02,
                                    ),
                                    SizedBox(
                                        width: context.w * 0.25,
                                        child: Text(
                                          languages[choosenLanguage]
                                              ['text_loose'],
                                          style: GoogleFonts.poppins(
                                            fontSize: context.w * sixteen,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ))
                                  ],
                                ),
                                SizedBox(width: context.w * 0.05),

                                //choose loose or qty
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (goodsSize ==
                                            languages[choosenLanguage]
                                                ['text_loose']) {
                                          setState(() {
                                            goodsSize = '';
                                            goodsText.clear();
                                          });
                                        }
                                      },
                                      child: Container(
                                        height: context.w * 0.04,
                                        width: context.w * 0.04,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            shape: BoxShape.circle),
                                        alignment: Alignment.center,
                                        child: (goodsSize !=
                                                languages[choosenLanguage]
                                                    ['text_loose'])
                                            ? Container(
                                                height: context.w * 0.02,
                                                width: context.w * 0.02,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.black),
                                              )
                                            : const SizedBox.shrink(),
                                      ),
                                    ),
                                    SizedBox(
                                      width: context.w * 0.02,
                                    ),
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.fromLTRB(
                                            context.w * 0.03,
                                            context.w * 0.0,
                                            context.w * 0.03,
                                            context.w * 0.01),
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: borderLines),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        height: context.w * 0.1,
                                        width: context.w * 0.3,
                                        child: (goodsSize !=
                                                languages[choosenLanguage]
                                                    ['text_loose'])
                                            ? TextField(
                                                controller: goodsText,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: languages[
                                                            choosenLanguage][
                                                        'text_quantitywithunit'],
                                                    hintStyle:
                                                        GoogleFonts.poppins(
                                                            fontSize:
                                                                context.w *
                                                                    twelve)),
                                                onChanged: (val) {
                                                  setState(() {
                                                    goodsSize = goodsText.text;
                                                  });
                                                },
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                style: GoogleFonts.poppins(
                                                    fontSize:
                                                        context.w * twelve),
                                              )
                                            : Text(
                                                languages[choosenLanguage]
                                                    ['text_quantitywithunit'],
                                                style: GoogleFonts.poppins(
                                                    fontSize:
                                                        context.w * twelve,
                                                    color: hintColor)))
                                  ],
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                    Button(
                        onTap: () {
                          setState(() {
                            if (goodsSize != '' && _selGoods != null) {
                              selectedGoodsId = _selGoods;
                              Navigator.pop(context, true);
                            }
                          });
                        },
                        text: languages[choosenLanguage]['text_confirm']),
                    SizedBox(height: context.w * 0.05)
                  ],
                ),
              ),
              if (_isLoading == true) const Positioned(child: Loading())
            ],
          ),
        ),
      ),
    );
  }
}
