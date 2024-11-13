import 'package:balcony/generated/assets.dart';
import 'package:balcony/ui/home/ui/tabs/user_and_host/widget/pagination_widget.dart';
import 'package:balcony/ui/home/ui/tabs/user_and_host/widget/property_widget.dart';
import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/widget/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkspacePage extends StatefulWidget {
  const WorkspacePage({super.key});

  @override
  WorkspacePageState createState() => WorkspacePageState();
}

class WorkspacePageState extends State<WorkspacePage> {
  int currentPage = 2;
  final int totalPages = 20;
  bool isMapViewSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isMapViewSelected ? mapView() : listView(),
    );
  }

  Widget listView() {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMapViewSelected = true;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.map,
                        color: theme.primaryColor,
                        size: 30.r,
                      ),
                      Text(
                        "map view",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.primaryColor,
                          fontSize: 12.spMin,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                16.w.horizontalSpace,
                GestureDetector(
                  onTap: () {
                    // Map view action
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.filter_alt_outlined,
                        color: theme.primaryColor,
                        size: 30.r,
                      ),
                      Text(
                        "filter",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.primaryColor,
                          fontSize: 12.spMin,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            10.h.verticalSpace,
            Text(
              'workspaces',
              textAlign: TextAlign.end,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 28.spMin,
              ),
            ),
            10.h.verticalSpace,
            ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return PropertyWidget(
                  title: 'Backyard w. NYC View',
                  location: 'Paris',
                  rating: 4.5,
                  price: '\$123.45',
                  reviews: 221,
                );
              },
            ),
            PaginationControl(
              currentPage: currentPage,
              totalPages: totalPages,
              onPageChanged: (newPage) {
                setState(() {
                  currentPage = newPage;
                });
              },
            ),
            60.h.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget mapView() {
    final theme = Theme.of(context);
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        AppImage(
          height: context.height,
          width: context.width,
          assetPath: Assets.dummyMap,
          boxFit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
        ),
        Positioned(
          right: 20.r,
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: theme.primaryColor)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isMapViewSelected = false;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.list,
                          color: theme.primaryColor,
                          size: 30.r,
                        ),
                        Text(
                          "list view",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.primaryColor,
                            fontSize: 12.spMin,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  16.w.horizontalSpace,
                  GestureDetector(
                    onTap: () {
                      // Map view action
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.filter_alt_outlined,
                          color: theme.primaryColor,
                          size: 30.r,
                        ),
                        Text(
                          "filter",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.primaryColor,
                            fontSize: 12.spMin,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            top: context.height * .5,
            left: 0,
            right: 0,
            child: SizedBox(
              height: context.height * .4,
              child: ListView.separated(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return PropertyWidget(
                    title: 'Backyard w. NYC View',
                    location: 'Paris',
                    rating: 4.5,
                    price: '\$123.45',
                    reviews: 221,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return 10.w.horizontalSpace;
                },
              ),
            )),
      ],
    );
  }
}
