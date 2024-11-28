import 'package:auto_route/annotations.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/store/workspace_store.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/widget/workspace_widget.dart';
import 'package:balcony/ui/home/ui/tabs/user_home/widget/pagination_widget.dart';
import 'package:balcony/widget/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

@RoutePage()
class SearchWorkspacePage extends StatefulWidget {
  final bool showBack;
  final String? checkIn;
  final String? checkOut;
  final int? people;
  final String? place;


  const SearchWorkspacePage(
      {super.key, this.showBack = true,  this.checkIn, this.checkOut, this.people, this.place});

  @override
  SearchWorkspacePageState createState() => SearchWorkspacePageState();
}

class SearchWorkspacePageState extends State<SearchWorkspacePage> {
  final workspaceStore = WorkspaceStore();
  int currentPage = 1;
  bool isMapViewSelected = false;

  @override
  void initState() {
    super.initState();
    _fetchWorkspacesSearch();
  }


  Future<void> _fetchWorkspacesSearch() async {
    await workspaceStore.searchWorkspace(page: currentPage,
        people: widget.people ?? 0,
        checkin: widget.checkIn,
        checkout: widget.checkOut,
        place: widget.place);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) {
          if (workspaceStore.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (workspaceStore.errorMessage != null) {
            return Center(
              child: Text(
                workspaceStore.errorMessage!,
                style: TextStyle(color: Theme
                    .of(context)
                    .primaryColor),
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
              'workspaces',
              textAlign: TextAlign.end,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 28.spMin,
              ),
            ),
            10.h.verticalSpace,
            ListView.builder(
              itemCount: workspaceStore.searchWorkspaceResponse?.length ?? 0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final workspace = workspaceStore.searchWorkspaceResponse![index];
                return WorkspaceWidget(
                  data: workspace,
                );
              },
            ),
            Observer(builder: (context) {
              var totalPages = workspaceStore.totalPages;
              return PaginationControl(
                currentPage: currentPage,
                totalPages: totalPages,
                // Replace with actual total pages if available
                onPageChanged: (newPage) {
                  setState(() {
                    currentPage = newPage;
                  });
                  _fetchWorkspacesSearch();
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
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        MapLibreMap(
          styleString: 'https://maps.tilehosting.com/styles/basic/style.json?key=Np0YtMXcGscEPnJKgTsu',
          // Replace with your style URL
          initialCameraPosition: const CameraPosition(
            target: LatLng(25.276987, 55.296249), // Default location (Dubai)
            zoom: 12,
          ),
          onMapCreated: (controller) {
            /*_onMapCreated(controller);*/
          },
          onStyleLoadedCallback: () {
            /*_addMarkers();*/
          },
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
      ],
    );
  }
}
