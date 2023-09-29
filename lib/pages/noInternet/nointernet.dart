import 'package:awii/core/constants/exports.dart';

class NoInternet extends StatefulWidget {
  final dynamic onTap;
  // ignore: use_key_in_widget_constructors
  const NoInternet({required this.onTap});

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.h * 1,
      width: context.w * 1,
      color: Colors.transparent.withOpacity(0.6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //no internet popup
          Container(
            padding: EdgeInsets.all(context.w * 0.05),
            width: context.w * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: page),
            child: Column(
              children: [
                SizedBox(
                    width: context.w * 0.6,
                    child: Image.asset('assets/images/noInternet.png',
                        fit: BoxFit.contain)),
                SizedBox(height: context.w * 0.05),
                Text(
                  (languages.isNotEmpty && choosenLanguage != '')
                      ? languages[choosenLanguage]['text_nointernet']
                      : 'No Internet Connection',
                  style: GoogleFonts.roboto(
                      fontSize: context.w * eighteen,
                      fontWeight: FontWeight.w600,
                      color: textColor),
                ),
                SizedBox(height: context.w * 0.05),
                Text(
                  (languages.isNotEmpty && choosenLanguage != '')
                      ? languages[choosenLanguage]['text_nointernetdesc']
                      : 'Please check your Internet connection, try enabling wifi or tey again later',
                  style: GoogleFonts.roboto(
                      fontSize: context.w * fourteen, color: hintColor),
                ),
                SizedBox(height: context.w * 0.05),
                Button(
                    onTap: widget.onTap,
                    text: (languages.isNotEmpty && choosenLanguage != '')
                        ? languages[choosenLanguage]['text_ok']
                        : 'Ok')
              ],
            ),
          )
        ],
      ),
    );
  }
}
