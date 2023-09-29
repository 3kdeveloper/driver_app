import 'package:awii/core/constants/exports.dart';
import 'sk_onboarding_model.dart';

class SKOnboardingScreen extends StatefulWidget {
  final List<SkOnboardingModel> pages;
  final Color bgColor;
  final Color themeColor;
  final ValueChanged<String> skipClicked;
  final ValueChanged<String> getStartedClicked;

  const SKOnboardingScreen({
    Key? key,
    required this.pages,
    required this.bgColor,
    required this.themeColor,
    required this.skipClicked,
    required this.getStartedClicked,
  }) : super(key: key);

  @override
  SKOnboardingScreenState createState() => SKOnboardingScreenState();
}

class SKOnboardingScreenState extends State<SKOnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < widget.pages.length; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  List<Widget> buildOnboardingPages() {
    final children = <Widget>[];
    for (int i = 0; i < widget.pages.length; i++) {
      children.add(_showPageData(widget.pages[i]));
    }
    return children;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      height: 8.h,
      width: isActive ? 24.w : 12.w,
      decoration: BoxDecoration(
        color: isActive ? widget.themeColor : const Color(0xFF929794),
        borderRadius: BorderRadius.all(Radius.circular(12.w)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.bgColor,
      body: SafeArea(
        child: SizedBox(
          height: context.h,
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    color: Colors.transparent,
                    child: PageView(
                      physics: const BouncingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) =>
                          setState(() => _currentPage = page),
                      children: buildOnboardingPages(),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator()),
                ],
              )),
        ),
      ),
      bottomNavigationBar: _currentPage == widget.pages.length - 1
          ? _showGetStartedButton()
          : const SizedBox.shrink(),
      floatingActionButton: _currentPage != widget.pages.length - 1
          ? FloatingActionButton(
              backgroundColor: widget.bgColor,
              child: const Icon(Icons.arrow_forward,
                  color: ColorsResource.primaryColor),
              onPressed: () => _pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _showPageData(SkOnboardingModel page) {
    return Padding(
      padding: EdgeInsets.all(40.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image(
                image: AssetImage(page.imagePath), height: 300.h, width: 300.w),
          ),
          SizedBox(height: 30.h),
          Text(
            page.title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: page.titleColor,
              fontSize: 26.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15.h),
          Text(
            page.description,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: page.descriptionColor,
              fontSize: 16.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _showGetStartedButton() {
    final GestureDetector loginButtonWithGesture = GestureDetector(
      onTap: _getStartedTapped,
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
            color: widget.themeColor,
            borderRadius: const BorderRadius.all(Radius.circular(6.0))),
        child: Center(
          child: Text(
            'Get Started',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );

    return Padding(
        padding:
            EdgeInsets.only(left: 20.w, right: 20.w, top: 5.h, bottom: 30.h),
        child: loginButtonWithGesture);
  }

  void _getStartedTapped() => widget.getStartedClicked("Get Started Tapped");
}
