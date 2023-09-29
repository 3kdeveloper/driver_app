import 'package:awii/core/constants/exports.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({Key? key}) : super(key: key);

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  var _choosenLanguage = choosenLanguage;
  bool _isLoading = false;

//navigate
  pop() {
    Navigator.pop(context, true);
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
              height: context.h * 1,
              width: context.w * 1,
              padding: EdgeInsets.fromLTRB(context.w * 0.05, context.w * 0.05,
                  context.w * 0.05, context.w * 0.05),
              color: page,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top),
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: context.w * 0.05),
                        width: context.w * 1,
                        alignment: Alignment.center,
                        child: Text(
                          languages[choosenLanguage]['text_change_language'],
                          style: TextStyle(
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
                      'assets/images/selectLanguage.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: context.w * 0.1,
                  ),
                  Expanded(
                    child: SizedBox(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            children: languages
                                .map((i, value) {
                                  return MapEntry(
                                      i,
                                      InkWell(
                                        onTap: () => setState(
                                            () => _choosenLanguage = i),
                                        child: Container(
                                          padding:
                                              EdgeInsets.all(context.w * 0.025),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                      'assets/languages/${languagesCode.firstWhere((e) => e['code'] == i)['code']}.png',
                                                      width: 30),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    languagesCode
                                                        .firstWhere((e) =>
                                                            e['code'] ==
                                                            i)['name']
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize:
                                                            context.w * sixteen,
                                                        color: textColor),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                height: context.w * 0.05,
                                                width: context.w * 0.05,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xff222222),
                                                        width: 1.2)),
                                                alignment: Alignment.center,
                                                child: (_choosenLanguage == i)
                                                    ? Container(
                                                        height:
                                                            context.w * 0.03,
                                                        width: context.w * 0.03,
                                                        decoration:
                                                            const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Color(
                                                                    0xff222222)),
                                                      )
                                                    : const SizedBox.shrink(),
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                                })
                                .values
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Button(
                      onTap: () async {
                        choosenLanguage = _choosenLanguage;
                        if (choosenLanguage == 'ar' ||
                            choosenLanguage == 'ur' ||
                            choosenLanguage == 'iw') {
                          languageDirection = 'rtl';
                        } else {
                          languageDirection = 'ltr';
                        }
                        setState(() {
                          _isLoading = true;
                        });
                        await getlangid();
                        pref.setString('languageDirection', languageDirection);
                        pref.setString('choosenLanguage', _choosenLanguage);
                        valueNotifierHome.incrementNotifier();
                        setState(() {
                          _isLoading = false;
                        });
                        pop();
                      },
                      text: languages[choosenLanguage]['text_confirm'])
                ],
              ),
            ),
            //loader
            (_isLoading == true)
                ? const Positioned(top: 0, child: Loading())
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
