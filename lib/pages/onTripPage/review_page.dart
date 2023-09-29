import 'package:awii/core/constants/exports.dart';

class Review extends StatefulWidget {
  const Review({Key? key}) : super(key: key);

  @override
  State<Review> createState() => _ReviewState();
}

double review = 0.0;
String feedback = '';

class _ReviewState extends State<Review> {
  bool _loading = false;

  @override
  void initState() {
    review = 0.0;
    super.initState();
  }

  //navigate
  navigate() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Maps()),
        (route) => false);
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
              padding: EdgeInsets.all(context.w * 0.05),
              color: page,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: context.w * 0.25,
                    width: context.w * 0.25,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(userRequestData['driverDetail']
                                ['data']['profile_picture']),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    height: context.h * 0.02,
                  ),
                  Text(
                    userRequestData['driverDetail']['data']['name'],
                    style: TextStyle(
                        fontSize: context.w * twenty, color: textColor),
                  ),
                  SizedBox(
                    height: context.h * 0.02,
                  ),
                  //stars
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              review = 1.0;
                            });
                          },
                          child: Icon(
                            Icons.star,
                            size: context.w * 0.1,
                            color: (review >= 1) ? buttonColor : Colors.grey,
                          )),
                      SizedBox(
                        width: context.w * 0.02,
                      ),
                      InkWell(
                          onTap: () {
                            setState(() {
                              review = 2.0;
                            });
                          },
                          child: Icon(
                            Icons.star,
                            size: context.w * 0.1,
                            color: (review >= 2) ? buttonColor : Colors.grey,
                          )),
                      SizedBox(
                        width: context.w * 0.02,
                      ),
                      InkWell(
                          onTap: () {
                            setState(() {
                              review = 3.0;
                            });
                          },
                          child: Icon(
                            Icons.star,
                            size: context.w * 0.1,
                            color: (review >= 3) ? buttonColor : Colors.grey,
                          )),
                      SizedBox(
                        width: context.w * 0.02,
                      ),
                      InkWell(
                          onTap: () {
                            setState(() {
                              review = 4.0;
                            });
                          },
                          child: Icon(
                            Icons.star,
                            size: context.w * 0.1,
                            color: (review >= 4) ? buttonColor : Colors.grey,
                          )),
                      SizedBox(
                        width: context.w * 0.02,
                      ),
                      InkWell(
                          onTap: () {
                            setState(() {
                              review = 5.0;
                            });
                          },
                          child: Icon(
                            Icons.star,
                            size: context.w * 0.1,
                            color: (review == 5) ? buttonColor : Colors.grey,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: context.h * 0.05,
                  ),
                  //feedback text
                  Container(
                    padding: EdgeInsets.all(context.w * 0.05),
                    width: context.w * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1.5, color: Colors.grey)),
                    child: TextField(
                      maxLines: 4,
                      onChanged: (val) {
                        setState(() {
                          feedback = val;
                        });
                      },
                      decoration: InputDecoration(
                          hintText: languages[choosenLanguage]['text_feedback'],
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: context.h * 0.05,
                  ),
                  Button(
                      onTap: () async {
                        if (review >= 1.0) {
                          setState(() {
                            _loading = true;
                          });
                          var result = await userRating();

                          if (result == true) {
                            navigate();
                            _loading = false;
                          } else {
                            setState(() {
                              _loading = false;
                            });
                          }
                        }
                      },
                      text: languages[choosenLanguage]['text_submit'])
                ],
              ),
            ),
            //loader
            (_loading == true)
                ? const Positioned(child: Loading())
                : Container()
          ],
        ),
      ),
    );
  }
}
