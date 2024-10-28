import 'package:balcony/ui/auth/ui/reset_password_page.dart';
import 'package:balcony/ui/auth/ui/sign_in_page.dart';
import 'package:balcony/ui/auth/ui/sign_up_page.dart';
import 'package:balcony/values/extensions/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingBottomSheet extends StatefulWidget {
  const OnboardingBottomSheet({super.key});

  @override
  OnboardingBottomSheetState createState() => OnboardingBottomSheetState();
}

class OnboardingBottomSheetState extends State<OnboardingBottomSheet> {
  int _currentIndex = 1;

  final PageController _pageController = PageController(initialPage: 1);

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        final theme = Theme.of(context);
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              40.h.verticalSpace,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                margin: EdgeInsets.only(left: 20.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    border: Border.all(color: Colors.black.withOpacity(.25))),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTab(theme, "sign in", 0),
                    _buildTab(theme, "sign up", 1),
                    _buildTab(theme, "password reset", 2),
                  ],
                ),
              ),
              const Divider(),
              // PageView for different forms
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  children: const [
                    SignInPage(),
                    SignUpPage(),
                    ResetPasswordPage(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTab(ThemeData theme, String text, int index) {
    bool isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
            color: isActive ? theme.colors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(12.r))),
        child: Text(
          text,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 16.spMin,
            fontWeight: FontWeight.w500,
            color: _currentIndex == index
                ? theme.colors.backgroundColor
                : theme.colors.primaryColor,
          ),
        ),
      ),
    );
  }

}

void showOnboardingBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,

    builder: (context) => const OnboardingBottomSheet(),
  );
}
