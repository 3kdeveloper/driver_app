import 'package:awii/core/constants/exports.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  bool _isLoading = false;
  bool _deletingAddress = false;
  dynamic _deletingId;
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
                              width: context.w * 1,
                              alignment: Alignment.center,
                              child: Text(
                                languages[choosenLanguage]['text_favourites'],
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
                        SizedBox(
                          width: context.w * 0.9,
                          height: context.h * 0.16,
                          child: Image.asset(
                            'assets/images/favourites_bg.jpg',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: context.w * 0.1,
                        ),
                        (favAddress.isNotEmpty)
                            ? Expanded(
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Column(
                                    children: favAddress
                                        .asMap()
                                        .map((i, value) {
                                          return MapEntry(
                                            i,
                                            Container(
                                              width: context.w * 0.9,
                                              padding: EdgeInsets.only(
                                                  top: context.w * 0.03,
                                                  bottom: context.w * 0.03),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    favAddress[i]
                                                        ['address_name'],
                                                    style: GoogleFonts.roboto(
                                                        fontSize:
                                                            context.w * sixteen,
                                                        color: textColor,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: context.w * 0.03,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      (favAddress[i][
                                                                  'address_name'] ==
                                                              'Home')
                                                          ? Image.asset(
                                                              'assets/images/home.png',
                                                              color:
                                                                  Colors.black,
                                                              width: context.w *
                                                                  0.075,
                                                            )
                                                          : (favAddress[i][
                                                                      'address_name'] ==
                                                                  'Work')
                                                              ? Image.asset(
                                                                  'assets/images/briefcase.png',
                                                                  color: Colors
                                                                      .black,
                                                                  width: context
                                                                          .w *
                                                                      0.075,
                                                                )
                                                              : Image.asset(
                                                                  'assets/images/navigation.png',
                                                                  color: Colors
                                                                      .black,
                                                                  width: context
                                                                          .w *
                                                                      0.075,
                                                                ),
                                                      SizedBox(
                                                        width: context.w * 0.02,
                                                      ),
                                                      SizedBox(
                                                        width: context.w * 0.6,
                                                        child: Text(
                                                          favAddress[i]
                                                              ['pick_address'],
                                                          style: GoogleFonts
                                                              .roboto(
                                                            fontSize:
                                                                context.w *
                                                                    twelve,
                                                            color: textColor,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                          child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          InkWell(
                                                              onTap: () async {
                                                                setState(() {
                                                                  _deletingId =
                                                                      favAddress[
                                                                              i]
                                                                          [
                                                                          'id'];
                                                                  _deletingAddress =
                                                                      true;
                                                                });
                                                              },
                                                              child: const Icon(
                                                                  Icons
                                                                      .remove_circle_outline)),
                                                        ],
                                                      ))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        })
                                        .values
                                        .toList(),
                                  ),
                                ),
                              )
                            : Text(
                                languages[choosenLanguage]['text_noDataFound'],
                                style: GoogleFonts.roboto(
                                    fontSize: context.w * eighteen,
                                    fontWeight: FontWeight.w600,
                                    color: textColor),
                              )
                      ],
                    ),
                  ),

                  //popup for delete address
                  (_deletingAddress == true)
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
                                                _deletingAddress = false;
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
                                          ['text_removeFav'],
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
                                            _isLoading = true;
                                          });
                                          var result = await removeFavAddress(
                                              _deletingId);
                                          if (result == 'success') {
                                            setState(() {
                                              _deletingAddress = false;
                                            });
                                          }
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        },
                                        text: languages[choosenLanguage]
                                            ['text_confirm'])
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
                          child: NoInternet(onTap: () {
                            setState(() {
                              internetTrue();
                            });
                          }))
                      : Container(),

                  //loader
                  (_isLoading == true)
                      ? const Positioned(child: Loading())
                      : Container()
                ],
              ),
            );
          }),
    );
  }
}
