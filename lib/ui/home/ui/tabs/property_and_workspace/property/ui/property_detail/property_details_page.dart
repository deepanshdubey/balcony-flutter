import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/data/model/response/workspace_data.dart';
import 'package:homework/generated/assets.dart';
import 'package:homework/ui/home/ui/tabs/chat/store/chat_store.dart';
import 'package:homework/ui/home/ui/tabs/chat/ui/chat_details_page.dart';
import 'package:homework/ui/home/ui/tabs/chat/ui/chat_page.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/store/property_store.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/ui/workspace_details/custom_dropdown.dart';
import 'package:homework/ui/home/widget/floating_expandable_action.dart';
import 'package:homework/values/colors.dart';
import 'package:homework/values/extensions/theme_ext.dart';
import 'package:homework/widget/app_back_button.dart';
import 'package:homework/widget/app_image.dart';
import 'package:homework/widget/app_text_field.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class PropertyDetailPage extends StatefulWidget {
  final String? propertyId;

  const PropertyDetailPage({super.key, this.propertyId});

  @override
  State<PropertyDetailPage> createState() => _PropertyDetailPageState();
}

class _PropertyDetailPageState extends State<PropertyDetailPage> {
  late MapLibreMapController _mapController;
  List<ReactionDisposer>? disposers;
  late TextEditingController leaseController = TextEditingController();
  final propertyStore = PropertyStore();
  final chatStore = ChatStore();

  @override
  void initState() {
    addDisposer();
    propertyStore.getPropertyDetails(id: widget.propertyId);
    super.initState();
  }

  @override
  void dispose() {
    removeDisposer();
    super.dispose();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => propertyStore.errorMessage, (String? errorMessage) {
        if (errorMessage != null) {
          alertManager.showError(context, errorMessage);
        }
      }),
      reaction((_) => chatStore.startConversationResponse, (response) {
        var host = propertyStore.propertyDetailsResponse?.host as Host;
        session.user.id == host.Id
            ? alertManager.showError(context, "User and host same")
            : showAppBottomSheet(
                context,
                ChatDetailsPage(
                  image: host.image,
                  name: host.firstName,
                  /*conversationId: response?.data.conversation?.Id ?? "",*/
                  receiverId: session.user.id,
                ));
      }),
    ];
  }

  void removeDisposer() {
    if (disposers == null) return;
    for (final element in disposers!) {
      element.reaction.dispose();
    }
  }

  Future<void> onMapCreated(MapLibreMapController controller) async {
    _mapController = controller;
  }

  void addCustomMarker() async {
    ByteData byteData = await rootBundle.load(Assets.imagesLocationOn);
    final Uint8List imageData = byteData.buffer.asUint8List();
    await _mapController.addImage('custom-marker', imageData);
  }

  void _makingPhoneCall(String number) async {
    final Uri url = Uri.parse("tel://1111111111");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void sendEmail() async {
    final String subject = Uri.encodeComponent("Help & Support Inquiry");
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'test.host@hw.co',
      query: 'subject=$subject',
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not launch email")),
      );
    }
  }

  //! Handle phone call with permission check
  Future<void> _handlePhoneCall(BuildContext context, String url) async {
    try {
      //! For Android and iOS, check phone permissions
      if (Theme.of(context).platform == TargetPlatform.android ||
          Theme.of(context).platform == TargetPlatform.iOS) {
        var callStatus = await Permission.phone.status;
        if (callStatus.isDenied) {
          callStatus = await Permission.phone.request();
        }

        if (callStatus.isGranted) {
          final Uri callUri = Uri.parse(url);
          if (await canLaunchUrl(callUri)) {
            await launchUrl(callUri, mode: LaunchMode.externalApplication);
          } else {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Could not launch $url")),
              );
            }
          }
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Enable call access in settings to continue."),
              ),
            );

            //! Adding delay before opening settings
            Future.delayed(const Duration(seconds: 1), () {
              openAppSettings();
            });
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error making call: ${e.toString()}"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Observer(builder: (context) {
      var isLoading = propertyStore.isLoading;
      var data = propertyStore.propertyDetailsResponse;
      return isLoading
          ? Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24).r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      45.verticalSpace,
                      const AppBackButton(
                        text: "back",
                      ),
                      20.verticalSpace,
                      AppImage(
                        url: data?.images?.first ??
                            Assets.fontsHostYourWorkspaceOrProperty,
                        height: 173.h,
                        width: double.infinity,
                        boxFit: BoxFit.cover,
                        radius: 10,
                      ),
                      12.verticalSpace,
                      Row(
                        children:
                            data?.images != null && data!.images!.length > 1
                                ? List.generate(
                                    2,
                                    (index) => Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          right: index == 0 ? 12.w : 0,
                                        ),
                                        child: AppImage(
                                          url: data.images?[index + 1] ??
                                              Assets
                                                  .fontsHostYourWorkspaceOrProperty,
                                          height: 173.h,
                                          boxFit: BoxFit.cover,
                                          radius: 10,
                                          color: appColor.primaryColor,
                                        ),
                                      ),
                                    ),
                                  )
                                : [Container()],
                      ),
                      30.verticalSpace,
                      Text(
                        data?.info?.name ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: 28.spMin,
                        ),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          buildRatingStars(
                              theme, data?.ratings?.toDouble() ?? 0),
                          6.horizontalSpace,
                          Text(
                            "(${data?.ratings ?? 0})",
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: 11.spMax,
                            ),
                          ),
                          40.horizontalSpace,
                          Image.asset(
                            Assets.imagesShare,
                            height: 16.h,
                            width: 16.w,
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                      30.verticalSpace,
                      PrimaryButton(
                        text: "apply for tenancy",
                        onPressed: () {
                          launchUrl(
                              Uri.parse(
                                  "https://hw.co/property/${widget.propertyId}"),
                              mode: LaunchMode.externalApplication);
                          /*showAppBottomSheet(
                          context,
                          TenantApplicationPage(
                            propertyData: propertyStore.propertyDetailsResponse,
                          ));*/
                        },
                      ),
                      32.verticalSpace,
                      const Divider(
                        color: Color(0xff005451),
                        thickness: 0.5,
                      ),
                      24.verticalSpace,
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8).r,
                          border: Border.all(color: appColor.grayBorder),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24).r,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("lease duration",
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontSize: 23.spMin,
                                    color: appColor.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  )),
                              12.verticalSpace,
                              SizedBox(
                                width: 50.w,
                                child: AppTextField(
                                  readOnly: true,
                                  hintText:
                                      data?.other?.leaseDuration.toString() ??
                                          "0",
                                  keyboardType: TextInputType.number,
                                  label: 'months to years',
                                  controller: leaseController,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      30.verticalSpace,
                      Text(
                        "Contact Host for Support",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 14.spMin,
                          color: appColor.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Chat &/or call with the workspace host before booking",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 14.spMin,
                          color: appColor.primaryColor,
                        ),
                      ),
                      16.verticalSpace,
                      const Divider(
                        color: Color(0xff005451),
                        thickness: 0.5,
                      ),
                      16.verticalSpace,
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              var host = data?.host as Host;
                              var request = {"userId": host.Id};
                              chatStore.startConversations(request);
                            },
                            child: Text(
                              "chat",
                              style: theme.textTheme.titleMedium?.copyWith(
                                  fontSize: 14.spMin,
                                  color: appColor.primaryColor,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                          16.horizontalSpace,
                          Container(
                            color: const Color(0xff005451),
                            height: 20.h,
                            width: 1.w,
                          ),
                          16.horizontalSpace,
                          GestureDetector(
                            onTap: () {
                              var host = data?.host as Host;
                              _makingPhoneCall(host.phone.toString());
                            },
                            child: Text(
                              "call",
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontSize: 14.spMin,
                                decoration: TextDecoration.underline,
                                color: appColor.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      25.verticalSpace,
                      UnitTable(
                        units: data?.unitList
                                ?.map((unit) => unit.toJson())
                                .toList() ??
                            [],
                      ),
                      25.verticalSpace,
                      CustomDropdown(
                        title: 'Locations',
                        items: data?.info?.address != null
                            ? [
                                {
                                  'icon': Icons.location_pin,
                                  'title': data?.info?.address
                                }
                              ]
                            : [],
                        visibleItem: 1,
                        iconImage: Assets.imagesLocationOn,
                      ),
                      18.verticalSpace,
                      CustomDropdown(
                        title: 'Amenities',
                        items: data?.amenities
                                ?.map((amenity) => {
                                      'icon': Icons.check,
                                      'title': amenity,
                                    })
                                .toList() ??
                            [],
                        visibleItem: 9,
                      ),
                      18.verticalSpace,

                      23.verticalSpace,
                      // Workspace Overview
                      Container(
                        width: 1.sw,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8).r,
                          border: Border.all(color: appColor.primaryColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12).r,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              24.verticalSpace,
                              Text(
                                "Workspace Overview",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontSize: 28.spMin,
                                  color: appColor.primaryColor,
                                ),
                              ),
                              30.verticalSpace,
                              Text(
                                data?.info?.summary ?? "",
                                maxLines: 70,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontSize: 15.spMin,
                                  color: appColor.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              30.verticalSpace
                            ],
                          ),
                        ),
                      ),
                      23.verticalSpace,
                      // Map Image Placeholder
                      Observer(
                        builder: (context) {
                          var data = propertyStore.propertyDetailsResponse;
                          return propertyStore.isLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                      color: appColor.primaryColor),
                                )
                              : Column(
                                  children: [
                                    // Other widgets...

                                    SizedBox(
                                      height: 200.h,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20).r,
                                        child: MapLibreMap(
                                          styleString:
                                              'https://api.maptiler.com/maps/streets-v2/style.json?key=HRmXb4He6yvLBd6RRIcJ',
                                          myLocationEnabled: true,
                                          initialCameraPosition: CameraPosition(
                                            target: LatLng(
                                                data?.geocode?.lat ?? 0,
                                                data?.geocode?.lon ?? 0),
                                            zoom: 13,
                                          ),
                                          trackCameraPosition: true,
                                          onMapCreated: onMapCreated,
                                          onStyleLoadedCallback: () async {
                                            await Future.delayed(const Duration(
                                                milliseconds:
                                                    500)); // Optional delay
                                            addCustomMarker();
                                            try {
                                              _mapController.addSymbol(
                                                SymbolOptions(
                                                  geometry: LatLng(
                                                      data?.geocode?.lat ?? 0,
                                                      data?.geocode?.lon ?? 0),
                                                  iconImage: 'custom-marker',
                                                  iconSize: 3.0,
                                                ),
                                              );
                                            } catch (e) {
                                              print(
                                                  "Error while adding symbol: $e");
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingExpandableActions(
                onChat: () {
                  showChatBottomSheet(context);
                },
                onEmail: () {
                  sendEmail();
                },
                onSchedule: () {/* handle schedule */},
                onCall: () {
                  _handlePhoneCall(context, "tel://2312231323");
                },
              ),
            );
    });
  }

  Widget buildRatingStars(ThemeData theme, double rating) {
    int fullStars = rating.floor(); // Full stars to show
    bool hasHalfStar =
        (rating - fullStars) >= 0.5; // Whether to show a half star

    return Row(
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: .5.w),
            child: AppImage(
              assetPath: theme.assets.ratingStar,
              height: 18.r,
              width: 18.r,
            ),
          );
        } else if (index == fullStars && hasHalfStar) {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: .5.w),
              child: Icon(
                Icons.star,
                color: theme.primaryColor,
                size: 18.r,
              ));
        } else {
          return Icon(
            Icons.star_border,
            color: theme.primaryColor,
            size: 18.r,
          );
        }
      }),
    );
  }
}

class UnitTable extends StatefulWidget {
  final List<Map<String, dynamic>> units;

  const UnitTable({
    required this.units,
    super.key,
  });

  @override
  State<UnitTable> createState() => _UnitTableState();
}

class _UnitTableState extends State<UnitTable> {
  final ValueNotifier<int> rowsPerPageNotifier = ValueNotifier<int>(3);
  final List<int> rowOptions = [3, 5, 10];
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search and Filters Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Filter search...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add_circle_outline),
                label: const Text("Status"),
              ),
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.tune),
                label: const Text("View"),
              ),
            ],
          ),
          20.verticalSpace,
          Text(
            "Availability",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 23.spMin,
                  fontWeight: FontWeight.w600,
                ),
          ),
          20.verticalSpace,

          // Table Header
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      SizedBox(width: 40),
                      Expanded(
                        child: Text(
                          "Unit",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Icon(Icons.more_horiz),
                      SizedBox(width: 40),
                    ],
                  ),
                ),
                Divider(height: 1, color: Colors.grey.shade300),
                ...widget.units.map(
                  (unit) => Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: unit['selected'] ?? false,
                            onChanged: (bool? value) {
                              setState(() {
                                unit['selected'] = value;
                              });
                            },
                          ),
                          Expanded(
                            child: Text(
                              unit['unit'].toString(),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          const Icon(Icons.more_horiz),
                          const SizedBox(width: 40),
                        ],
                      ),
                      Divider(height: 1, color: Colors.grey.shade300),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
              "${widget.units.where((unit) => unit['selected'] == true).length} of ${widget.units.length} row(s) selected."),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
