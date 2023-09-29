import 'package:awii/core/constants/exports.dart';

class Sos extends StatefulWidget {
  const Sos({Key? key}) : super(key: key);

  @override
  State<Sos> createState() => _SosState();
}

class _SosState extends State<Sos> {
  bool _isDeleting = false;
  bool _isLoading = false;
  String _deleteId = '';

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
                    padding: EdgeInsets.only(
                        left: context.w * 0.05, right: context.w * 0.05),
                    height: context.h * 1,
                    width: context.w * 1,
                    color: page,
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).padding.top +
                                context.w * 0.05),
                        Stack(
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.only(bottom: context.w * 0.05),
                              width: context.w * 1,
                              alignment: Alignment.center,
                              child: Text(
                                languages[choosenLanguage]['text_sos'],
                                style: GoogleFonts.roboto(
                                    fontSize: context.w * twenty,
                                    fontWeight: FontWeight.w600,
                                    color: textColor),
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
                        SizedBox(
                          height: context.h * 0.25,
                          child: Image.asset(
                            'assets/images/sos_bg.jpg',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: context.w * 0.05,
                        ),
                        Text(
                          languages[choosenLanguage]['text_trust_contact_3'],
                          style: GoogleFonts.roboto(
                              fontSize: context.w * fourteen,
                              fontWeight: FontWeight.w600,
                              color: textColor),
                        ),
                        Text(
                          languages[choosenLanguage]['text_trust_contact_4'],
                          style: GoogleFonts.roboto(
                              fontSize: context.w * twelve, color: textColor),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: context.w * 0.05,
                        ),
                        Text(
                          languages[choosenLanguage]
                              ['text_yourTrustedContacts'],
                          style: GoogleFonts.roboto(
                              fontSize: context.w * fourteen,
                              fontWeight: FontWeight.w600,
                              color: buttonColor),
                        ),
                        SizedBox(
                          height: context.w * 0.025,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: context.w * 0.025,
                                ),
                                (sosData
                                        .where((element) =>
                                            element['user_type'] != 'admin')
                                        .isNotEmpty)
                                    ? Column(
                                        children: sosData
                                            .asMap()
                                            .map((i, value) {
                                              return MapEntry(
                                                  i,
                                                  (sosData[i]['user_type'] !=
                                                          'admin')
                                                      ? Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  context.w *
                                                                      0.025),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SizedBox(
                                                                    width: context
                                                                            .w *
                                                                        0.7,
                                                                    child: Text(
                                                                      sosData[i]
                                                                          [
                                                                          'name'],
                                                                      style: GoogleFonts.roboto(
                                                                          fontSize: context.w *
                                                                              sixteen,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              textColor),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      height: context
                                                                              .w *
                                                                          0.01),
                                                                  Text(
                                                                    sosData[i][
                                                                        'number'],
                                                                    style: GoogleFonts.roboto(
                                                                        fontSize:
                                                                            context.w *
                                                                                twelve,
                                                                        color:
                                                                            textColor),
                                                                  ),
                                                                ],
                                                              ),
                                                              InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      _deleteId =
                                                                          sosData[i]
                                                                              [
                                                                              'id'];
                                                                      _isDeleting =
                                                                          true;
                                                                    });
                                                                  },
                                                                  child: const Icon(
                                                                      Icons
                                                                          .remove_circle_outline))
                                                            ],
                                                          ),
                                                        )
                                                      : Container());
                                            })
                                            .values
                                            .toList(),
                                      )
                                    : Text(
                                        languages[choosenLanguage]
                                            ['text_noDataFound'],
                                        style: GoogleFonts.roboto(
                                            fontSize: context.w * eighteen,
                                            fontWeight: FontWeight.w600,
                                            color: textColor),
                                      )
                              ],
                            ),
                          ),
                        ),

                        //add sos button
                        (sosData
                                    .where((element) =>
                                        element['user_type'] != 'admin')
                                    .length <
                                5)
                            ? Container(
                                padding: EdgeInsets.only(
                                    top: context.w * 0.05,
                                    bottom: context.w * 0.05),
                                child: Button(
                                    onTap: () async {
                                      var nav = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PickContact(
                                                    from: 2,
                                                  )));
                                      if (nav) {
                                        setState(() {});
                                      }
                                    },
                                    text: languages[choosenLanguage]
                                        ['text_add_trust_contact']))
                            : Container()
                      ],
                    ),
                  ),

                  //delete sos
                  (_isDeleting == true)
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
                                                  _isDeleting = false;
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
                                            ['text_removeSos'],
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

                                            var val =
                                                await deleteSos(_deleteId);
                                            if (val == 'success') {
                                              setState(() {
                                                _isDeleting = false;
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
                          ),
                        )
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
