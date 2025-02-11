import 'package:auto_route/annotations.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/router/app_router.dart';
import 'package:homework/ui/walkthrough/store/walkthrough_store.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/values/extensions/int_ext.dart';
import 'package:homework/values/extensions/theme_ext.dart';
import 'package:homework/widget/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class WalkthroughPage extends StatefulWidget {
  const WalkthroughPage({super.key});

  @override
  WalkthroughPageState createState() => WalkthroughPageState();
}

class WalkthroughPageState extends State<WalkthroughPage> {
  final WalkthroughStore _store = WalkthroughStore();

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    // Start a timer that changes the page every 2 seconds
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Observer(builder: (context) {
      return Scaffold(
        bottomNavigationBar: _buildBottomRow(theme, _store.currentPage),
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                _store.setPage(index);
              },
              children: [
                _buildIntroPage(
                  theme,
                  0,
                  title: "workspaces",
                  description:
                      "hybrid work or simply looking for places to explore. Explore a wide range of workspaces for people like yourself.",
                  imagePath: theme.assets.walkthrough1,
                ),
                _buildIntroPage(
                  theme,
                  1,
                  title: "a change in\nscenery",
                  description:
                      "see whats available in your area. See different things and explore new places.",
                  imagePath: theme.assets.walkthrough2,
                ),
                _buildIntroPage(theme, 2,
                    title: "workspace \nbooking",
                    description:
                        "It's more than just a simple workspace app. It's an experience, Need a place to work? See what's available and book at ease.",
                    imagePath: theme.assets.walkthrough3),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildIntroPage(
    ThemeData theme,
    int index, {
    required String title,
    required String description,
    required String imagePath,
  }) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: 30.spMin,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            index == 2
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: context.height * .4,
                      width: context.width * .3,
                      child: Text(
                        "Its more than just a simple workspace app.\n\nIt’s an experience.",
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize: 18.spMin,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  )
                : AppImage(
                    assetPath: imagePath,
                    height: context.height * .4,
                    width: context.width,
                  ),
            const SizedBox(height: 16),
            Expanded(
              child: Text(
                description,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 18.spMin,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomRow(ThemeData theme, int currentPage) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                currentPage == 0
                    ? SizedBox(
                        width: 40.r,
                      )
                    : GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(currentPage - 1,
                              duration: 400.milliseconds, curve: Curves.easeIn);
                        },
                        child: AppImage(
                          radius: 20.r,
                          assetPath: theme.assets.back,
                        ),
                      ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: _buildDotsIndicator(theme, currentPage),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (currentPage != 2) {
                      _pageController.animateToPage(currentPage + 1,
                          duration: 400.milliseconds, curve: Curves.easeIn);
                    } else {
                      session.isWalkthroughSeen = true;
                      appRouter.replaceAll([const StartRoute()]);
                    }
                  },
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: AppImage(
                      radius: 20.r,
                      assetPath: theme.assets.back,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDotsIndicator(ThemeData theme, int activeIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(3, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
          width: 10.r,
          // Larger width for active dot
          height: 10.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: activeIndex == index
                ? theme.colors.textColor // Active dot color
                : theme.colors.disabledColor, // Inactive dot color
          ),
        );
      }),
    );
  }
}
