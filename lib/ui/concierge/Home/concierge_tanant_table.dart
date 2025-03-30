import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/generated/assets.dart';
import 'package:homework/router/app_router.dart';
import 'package:homework/ui/concierge/model/concierge_tanant_response.dart';
import 'package:homework/ui/concierge/store/concierge_store.dart';
import 'package:homework/values/extensions/theme_ext.dart';
import 'package:homework/widget/app_text_field.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

class ConciergeTenantTable extends StatefulWidget {
  const ConciergeTenantTable({Key? key}) : super(key: key);

  @override
  State<ConciergeTenantTable> createState() => _ConciergeTenantTableState();
}

class _ConciergeTenantTableState extends State<ConciergeTenantTable> {
  TextEditingController _addPropertyController = TextEditingController();

  final conciergeStore = ConciergeStore();
  List<ReactionDisposer>? disposers;
  final ImagePicker _picker = ImagePicker();
  List<String> scannedTextList = [];
  bool isMatch = false;
  List<ConciergeTenant>? tenants;
  String? _selectedTenant;
  String? _selectedTenantId;



  @override
  void initState() {
    conciergeStore.conciergeTenantAll();
    addDisposer();
    super.initState();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => conciergeStore.conciergePropertyAddResponse, (response) {
        if (response?.success ?? false) {
          alertManager.showSuccess(context, "Property Added to dropdown");
          _addPropertyController.clear();
        }
      }),
      reaction((_) => conciergeStore.conciergeTenantAllResponse, (response) {
        tenants = response?.tenants?.conciergeTenants ;
        setState(() {});
      }),
      reaction((_) => conciergeStore.errorMessage, (String? errorMessage) {
        if (errorMessage != null) {
          alertManager.showError(context, errorMessage);
        }
      }),
    ];
  }

  void removeDisposer() {
    if (disposers == null) return;
    for (final element in disposers!) {
      element.reaction.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return  Center(
      child: Container(
        padding: const EdgeInsets.all(24).r,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12).r,
          border: Border.all(color: Colors.black.withOpacity(.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "manually add tenant manager",
              style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 23.spMin,
                  fontWeight: FontWeight.w500,
                  color: theme.primaryColor),
            ),
            4.verticalSpace,
            Text(
                "this manager module is used if you do not use the leasing software, but only prefer to use concierge CRM only."),
            24.verticalSpace,
            Divider(
              color: Theme.of(context).colors.primaryColor,
              thickness: 1,
            ),
            24.verticalSpace,
            Row(
              children: [
                Image.asset(
                  Assets.imagesScanParcle,
                  height: 32.r,
                  width: 32.r,
                ),
                20.horizontalSpace,
                Expanded(
                  child: Text(
                    "add new parcels to the \nsystem the fast way.",
                    style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 14.spMin,
                        fontWeight: FontWeight.w500,
                        color: theme.primaryColor),
                    maxLines: 2,
                  ),
                )
              ],
            ),
            21.verticalSpace,
            PrimaryButton(
              text: "scan entire parcel label",
              onPressed: showImageSourceSheet,
            ),
            24.verticalSpace,
            Divider(
              color: Theme.of(context).colors.primaryColor,
              thickness: 1,
            ),
            18.verticalSpace,
            Container(
              width: 0.5.sw,
              child: AppTextField(
                controller: _addPropertyController,
                label: 'add property',
                hintText: 'property name..',
                textInputAction: TextInputAction.next,
              ),
            ),
            18.verticalSpace,
            GestureDetector(
              onTap: () {
                var request = {"name": _addPropertyController.text};
                conciergeStore.conciergePropertyAdd(request);
              },
              child: Row(
                children: [
                  Image.asset(
                    Assets.imagesAdd,
                    height: 24.r,
                    width: 24.r,
                  ),
                  6.horizontalSpace,
                  Text("add to dropdown",
                      style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 13.spMin,
                          fontWeight: FontWeight.w500,
                          color: theme.primaryColor))
                ],
              ),
            ),
            24.verticalSpace,
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                border: Border.all(color: Colors.black.withOpacity(.25)),
              ),
              child: Observer(builder: (context) {
                var tenants = conciergeStore
                    .conciergeTenantAllResponse?.tenants?.conciergeTenants;
                return Column(
                  children: [
                    // Header Row
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.r),
                            topRight: Radius.circular(12.r)),
                        color: Colors.grey[200],
                      ),
                      padding:
                      EdgeInsets.symmetric(vertical: 8.r, horizontal: 0.r),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Checkbox(
                              value: false,
                              onChanged: (value) {},
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              'tenant\'s name',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Center(
                              child: PrimaryButton(
                                text: "add",
                                onPressed: () {
                                  context.router.push(TenantFormRoute()).then((value) {
                                    conciergeStore.conciergeTenantAll();
                                  },);
                                },
                              ),
                            ),
                          ),
                          10.horizontalSpace
                        ],
                      ),
                    ),
                    conciergeStore.isLoading
                        ? Padding(
                      padding: EdgeInsets.all(20.r),
                      child: const CircularProgressIndicator(),
                    )
                        : tenants?.isNotEmpty == true
                        ? ListView.separated(
                      itemCount: tenants?.length ?? 0,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return TenantRowWidget(
                          onInfo: () {
                            context.router.push(ConciergeTenantDetailsRoute(conciergeTenant: tenants?[index])).then((value) {
                                 conciergeStore.conciergeTenantAll();
                            },);
                          },
                          conciergeTenant: tenants?[index],
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                        height: 1.h,
                        color: Colors.black26,
                      ),
                    )
                        : Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.r),
                        child: const Text('no tenant available.'),
                      ),
                    )
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void showImageSourceSheet() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      builder: (BuildContext context) {
        final items = ['Camera', 'Gallery'];

        return ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Icon(
                index == 0 ? Icons.camera_alt_outlined : Icons.photo_library_outlined,
              ),
              title: Text(items[index]),
              onTap: () async {
                await performOCR(index == 0 ? ImageSource.camera : ImageSource.gallery);
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  Future<void> performOCR(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image == null) return;
      await getRecognizer(image, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OCR failed: $e")),
      );
    }
  }

  Future<void> getRecognizer(XFile img, bool? isList) async {
    final selectedImage = InputImage.fromFilePath(img.path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    RecognizedText recognizedText = await textRecognizer.processImage(selectedImage);
    await textRecognizer.close();
    setState(() {
      scannedTextList = [];
      _selectedTenantId = null;

      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          debugPrint("Scanned..${line}");
          scannedTextList.addAll(line.text.split(" "));
        }
      }

      for (String text in scannedTextList) {

        debugPrint("Scanned..${text}");
        for (var tenant in tenants!) {
       //   debugPrint("Scanned..${tenant.info?.firstName}");
          if (text.toLowerCase().contains(tenant.info?.firstName?.toLowerCase() ?? "Null")) {
            _selectedTenantId = tenant.Id;
            break;
          }
        }
        if (_selectedTenantId != null) break;
      }
    });

    if (_selectedTenantId != null) {
      conciergeStore.parcelAdd("concierge-tenant", _selectedTenantId??"Null");
     debugPrint("Scanned..");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No match found with predefined tenants.")),
      );
    }
  }
}

class TenantRowWidget extends StatefulWidget {
  final ConciergeTenant? conciergeTenant;
  final VoidCallback onInfo;

  const TenantRowWidget({
    Key? key,
    required this.onInfo,
    required this.conciergeTenant,
  }) : super(key: key);

  @override
  State<TenantRowWidget> createState() => _TenantRowWidgetState();
}

class _TenantRowWidgetState extends State<TenantRowWidget> {
  final conciergeStore = ConciergeStore();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Checkbox(
          value: false,
          onChanged: (value) {},
        ),
        Expanded(
          flex: 3,
          child: Text(
         "${widget.conciergeTenant?.info?.firstName} ${widget.conciergeTenant?.info?.lastName}" ,
            style: theme.textTheme.bodyLarge,
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: widget.onInfo,
            child: Text(
              "•••",
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 8.spMin,
                color: Colors.black54,
              ),
            ),
          ),
        ),
        20.horizontalSpace
      ],
    );
  }


}
