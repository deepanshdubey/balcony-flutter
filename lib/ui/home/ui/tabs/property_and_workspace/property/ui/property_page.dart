import 'package:auto_route/annotations.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/property/store/property_store.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/property/widget/property_widget.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/widget/map_workspace_widget.dart';
import 'package:balcony/ui/home/ui/tabs/user_home/widget/pagination_widget.dart';
import 'package:balcony/widget/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

@RoutePage()
class PropertyPage extends StatefulWidget {
  final bool showBack;

  const PropertyPage({super.key, this.showBack = true});

  @override
  PropertyPageState createState() => PropertyPageState();
}

class PropertyPageState extends State<PropertyPage> {
  final propertyStore = PropertyStore();
  int currentPage = 1;
  bool isMapViewSelected = false;

  @override
  void initState() {
    super.initState();
    fetchProperties();
  }

  Future<void> fetchProperties() async {
    await propertyStore.getProperty(page: currentPage, limit: 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) {
          if (propertyStore.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (propertyStore.errorMessage != null) {
            return Center(
              child: Text(
                propertyStore.errorMessage!,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            );
          }
          return isMapViewSelected ? mapView() : listView();
        },
      ),
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
              children: [
                const AppBackButton(
                  text: 'back',
                ),
                const Spacer(),
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
                      ),
                    ],
                  ),
                ),
                16.w.horizontalSpace,
                GestureDetector(
                  onTap: () {
                    // Filter action
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
            10.h.verticalSpace,
            Text(
              'properties',
              textAlign: TextAlign.end,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 28.spMin,
              ),
            ),
            10.h.verticalSpace,
            ListView.builder(
              itemCount: propertyStore.propertyResponse?.length ?? 0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final property = propertyStore.propertyResponse![index];
                return PropertyWidget(
                  data: property,
                );
              },
            ),
            Observer(builder: (context) {
              var totalPages = propertyStore.totalPages;
              return PaginationControl(
                currentPage: currentPage,
                totalPages: totalPages,
                // Replace with actual total pages if available
                onPageChanged: (newPage) {
                  setState(() {
                    currentPage = newPage;
                  });
                  fetchProperties();
                },
              );
            }),
            60.h.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget mapView() {
    final theme = Theme.of(context);
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              MapLibreMap(
                styleString:
                'https://api.maptiler.com/maps/streets-v2/style.json?key=HRmXb4He6yvLBd6RRIcJ',
                myLocationEnabled: true,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(0, 0),
                  zoom: 1,
                ),
                trackCameraPosition: true,
                onMapCreated: (controller) {},
                onStyleLoadedCallback: () async {},
              ),
              Positioned(
                right: 20.r,
                child: SafeArea(
                  child: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: theme.primaryColor),
                    ),
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
                              ),
                            ],
                          ),
                        ),
                        16.w.horizontalSpace,
                        GestureDetector(
                          onTap: () {
                            // Map filter action
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
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                //  top: 20.0,
                left: 0.0,
                right:0.0,
                bottom:20.0,
                child: Container(
                  height: 250.h, // Set a height for the ListView to allow scrolling
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: 220.h, // Container height
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: propertyStore.propertyResponse?.length ?? 0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final property = propertyStore.propertyResponse![index];
                          return MapWorkspaceWidget(
                            data: property,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
