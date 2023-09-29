import 'package:awii/core/constants/exports.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController chatText = TextEditingController();
  ScrollController controller = ScrollController();
  bool _sendingMessage = false;
  @override
  void initState() {
    //get messages
    getCurrentMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child: Material(
        child: Scaffold(
          body: ValueListenableBuilder(
              valueListenable: valueNotifierBook.value,
              builder: (context, value, child) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  controller.animateTo(controller.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                });
                //call for message seen
                messageSeen();

                return Directionality(
                  textDirection: (languageDirection == 'rtl')
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            context.w * 0.05,
                            MediaQuery.of(context).padding.top +
                                context.w * 0.05,
                            context.w * 0.05,
                            context.w * 0.05),
                        height: context.h * 1,
                        width: context.w * 1,
                        color: page,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: context.w * 0.9,
                                  height: context.w * 0.1,
                                  alignment: Alignment.center,
                                  child: Text(
                                    languages[choosenLanguage]
                                        ['text_chatwithdriver'],
                                    style: GoogleFonts.roboto(
                                        fontSize: context.w * twenty,
                                        color: textColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Positioned(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context, true);
                                    },
                                    child: Container(
                                      height: context.w * 0.1,
                                      width: context.w * 0.1,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                spreadRadius: 2,
                                                blurRadius: 2)
                                          ],
                                          color: page),
                                      alignment: Alignment.center,
                                      child: const Icon(Icons.arrow_back),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Expanded(
                                child: SingleChildScrollView(
                              controller: controller,
                              child: Column(
                                children: chatList
                                    .asMap()
                                    .map((i, value) {
                                      return MapEntry(
                                          i,
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: context.w * 0.025),
                                            width: context.w * 0.9,
                                            alignment:
                                                (chatList[i]['from_type'] == 1)
                                                    ? Alignment.centerRight
                                                    : Alignment.centerLeft,
                                            child: Column(
                                              crossAxisAlignment: (chatList[i]
                                                          ['from_type'] ==
                                                      1)
                                                  ? CrossAxisAlignment.end
                                                  : CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: context.w * 0.4,
                                                  padding: EdgeInsets.fromLTRB(
                                                      context.w * 0.04,
                                                      context.w * 0.02,
                                                      context.w * 0.04,
                                                      context.w * 0.02),
                                                  decoration: BoxDecoration(
                                                      borderRadius: (chatList[i]['from_type'] == 1)
                                                          ? const BorderRadius.only(
                                                              topLeft:
                                                                  Radius.circular(
                                                                      24),
                                                              bottomLeft:
                                                                  Radius.circular(
                                                                      24),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                      24))
                                                          : const BorderRadius.only(
                                                              topRight:
                                                                  Radius.circular(
                                                                      24),
                                                              bottomLeft:
                                                                  Radius.circular(
                                                                      24),
                                                              bottomRight:
                                                                  Radius.circular(24)),
                                                      color: (chatList[i]['from_type'] == 1) ? const Color(0xff000000).withOpacity(0.15) : const Color(0xff222222)),
                                                  child: Text(
                                                    chatList[i]['message'],
                                                    style: GoogleFonts.roboto(
                                                        fontSize: context.w *
                                                            fourteen,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: context.w * 0.015,
                                                ),
                                                Text(chatList[i]
                                                    ['converted_created_at'])
                                              ],
                                            ),
                                          ));
                                    })
                                    .values
                                    .toList(),
                              ),
                            )),

                            //text field
                            Container(
                              margin: EdgeInsets.only(top: context.w * 0.025),
                              padding: EdgeInsets.fromLTRB(
                                  context.w * 0.025,
                                  context.w * 0.01,
                                  context.w * 0.025,
                                  context.w * 0.01),
                              width: context.w * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: borderLines, width: 1.2),
                                  color: page),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: context.w * 0.7,
                                    child: TextField(
                                      controller: chatText,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: languages[choosenLanguage]
                                              ['text_entermessage'],
                                          hintStyle: GoogleFonts.roboto(
                                              fontSize: context.w * twelve,
                                              color: hintColor)),
                                      minLines: 1,
                                      maxLines: 4,
                                      onChanged: (val) {},
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      setState(() {
                                        _sendingMessage = true;
                                      });
                                      await sendMessage(chatText.text);
                                      chatText.clear();
                                      setState(() {
                                        _sendingMessage = false;
                                      });
                                    },
                                    child: Image.asset(
                                      'assets/images/send.png',
                                      fit: BoxFit.contain,
                                      width: context.w * 0.075,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      //loader
                      (_sendingMessage == true)
                          ? const Positioned(top: 0, child: Loading())
                          : Container()
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
