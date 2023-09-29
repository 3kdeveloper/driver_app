import 'package:awii/core/constants/exports.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Directionality(
        textDirection: (languageDirection == 'rtl')
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Container(
          padding: EdgeInsets.all(context.w * 0.05),
          height: context.h * 1,
          width: context.w * 1,
          color: page,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).padding.top),
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: context.w * 0.05),
                          width: context.w * 1,
                          alignment: Alignment.center,
                          child: Text(
                            languages[choosenLanguage]['text_about'],
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
                        'assets/images/about_bg.jpg',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: context.w * 0.1,
                    ),
                    //terms and condition
                    InkWell(
                      onTap: () {
                        openBrowser('https://awiiapp.com/terms');
                      },
                      child: Text(
                        languages[choosenLanguage]['text_termsandconditions'],
                        style: GoogleFonts.roboto(
                            fontSize: context.w * sixteen,
                            fontWeight: FontWeight.w600,
                            color: textColor),
                      ),
                    ),
                    SizedBox(
                      height: context.w * 0.05,
                    ),
                    //privacy policy
                    InkWell(
                      onTap: () {
                        openBrowser('https://awiiapp.com/privacy');
                      },
                      child: Text(
                        languages[choosenLanguage]['text_privacy'],
                        style: GoogleFonts.roboto(
                            fontSize: context.w * sixteen,
                            fontWeight: FontWeight.w600,
                            color: textColor),
                      ),
                    ),
                    SizedBox(
                      height: context.w * 0.05,
                    ),
                    //website url
                    InkWell(
                      onTap: () {
                        openBrowser('https://awiiapp.com/');
                      },
                      child: Text(
                        languages[choosenLanguage]['text_about'],
                        style: GoogleFonts.roboto(
                            fontSize: context.w * sixteen,
                            fontWeight: FontWeight.w600,
                            color: textColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
