import 'package:auto_route/auto_route.dart';
import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/core/locator/locator.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/data/model/response/property_data.dart';
import 'package:homework/data/model/response/tenant_details.dart';
import 'package:homework/router/app_router.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/store/property_store.dart';
import 'package:homework/ui/home/ui/tabs/stay/rant_payment_details_page.dart';
import 'package:homework/values/colors.dart';
import 'package:homework/values/extensions/theme_ext.dart';
import 'package:homework/widget/app_image.dart';
import 'package:homework/widget/app_text_field.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../../../../widget/app_outlined_button.dart';

class ReviewTenantApplication extends StatefulWidget {

  
  final PropertyData? propertyData;
  final Tenants? tenant;
  final bool? isUpdate;
  final bool? onlyShowData;

   ReviewTenantApplication(
      {super.key, this.propertyData, this.tenant, this.isUpdate, this.onlyShowData});

  @override
  State<ReviewTenantApplication> createState() =>
      _ReviewTenantApplicationState();
      
      
}

class _ReviewTenantApplicationState extends State<ReviewTenantApplication> {
  List<ReactionDisposer>? disposers;
  late final GlobalKey<FormState> _formKey = GlobalKey();
  final ValueNotifier<bool> isAgreedNotifier = ValueNotifier(true);
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController emailController;
  late TextEditingController anticipateController;
  late TextEditingController socialSecurityController;
  late TextEditingController countryResidenceController;
  late TextEditingController countryIdController;
  late TextEditingController adnFristNameController;
  late TextEditingController adnLastNameController;
  late TextEditingController adnEmailController;
  late TextEditingController emNameController;
  late TextEditingController emContactController;
  late TextEditingController rsStreetController;
  late TextEditingController rsUnitController;
  late TextEditingController rsCityController;
  late TextEditingController rsStateController;
  late TextEditingController rscontryController;
  late FocusNode firstNameNode;
  late FocusNode lastNameNode;
  late FocusNode phoneNumberNode;
  late FocusNode emailNode;
  late FocusNode countryResidenceNode;
  late FocusNode countryIdNode;
  late FocusNode socialSecurityNode;
  late FocusNode emNameNode;
  late FocusNode emcontactNode;
  late FocusNode rsStateNode;
  late FocusNode rsContryNode;
  late FocusNode rsCityNode;
  late FocusNode rsUnitNode;
  late FocusNode rsStreetNode;

  String? selectedTitle;
  String? leaseStartDate;
  String? leaseEndDate;
  String? selectedUnit;
  String? selectedMoveInDate;
  bool isSecurityDepositChecked = false;
  bool isSameAsRent = false;
  int depositFeeAmount = 0;
  bool leaseAgreement=false;

  var propertyStore = PropertyStore();

  List<Map<String, String>> additionalPeople = [
    {
      "p_first_name": "Alice",
      "p_last_name": "Johnson",
      "p_email": "alice.johnson@example.com",
      "view_application": "https://example.com/files/application_alice.pdf"
    },
    {
      "p_first_name": "Bob",
      "p_last_name": "Smith",
      "p_email": "bob.smith@example.com",
      "view_application": "" // Incomplete
    },
    {
      "p_first_name": "Carol",
      "p_last_name": "Williams",
      "p_email": "carol.williams@example.com",
      "view_application": "https://example.com/files/application_carol.pdf"
    },
  ];

  //todo residential history list....
   List<Map<String, dynamic>> prospectList = [];
  int editableIndex = -1;
  //todo list emergency contact list....
  List<EmergencyContact> emegencyContactList=[];
  List<ResidentialHistory> residentialHistorytList=[];
  List<AdditionalPerson> additionalPeopleList=[];

  final List<String> countries = ['USA', 'Canada', 'India', 'Germany', 'UK'];
  // This is your pre-filled data
  final List<Map<String, String>> initialData = [
    {
      'street': '124 Main St',
      'unit': 'Apt 101',
      'city': 'New York',
      'state': 'NY',
      'country': 'USA',
    },
  ];
  void _loadInitialProspects() {
    for (var data in initialData) {
      prospectList.add({
        'street': TextEditingController(text: data['street']),
        'unit': TextEditingController(text: data['unit']),
        'city': TextEditingController(text: data['city']),
        'state': TextEditingController(text: data['state']),
        'country': data['country'] ?? 'USA',
      });
      
    }
    editableIndex = 0; // First one is editable
  }
   
 
  @override
  void initState() {
    addDisposer();
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    emailController = TextEditingController();
    anticipateController = TextEditingController();
    socialSecurityController = TextEditingController();
    countryResidenceController=TextEditingController();
    countryIdController=TextEditingController();
    adnFristNameController=TextEditingController();
    adnLastNameController=TextEditingController();
    adnEmailController=TextEditingController();
    emNameController=TextEditingController();
    emContactController=TextEditingController();
    rsStreetController=TextEditingController();
    rsStateController=TextEditingController();
    rsCityController=TextEditingController();
    rsUnitController=TextEditingController();
    rscontryController=TextEditingController();
  
    
    firstNameNode = FocusNode();
    lastNameNode = FocusNode();
    phoneNumberNode = FocusNode();
    emailNode = FocusNode();
    socialSecurityNode = FocusNode();
    countryResidenceNode=FocusNode();
    countryIdNode=FocusNode();
    emNameNode=FocusNode();
    emcontactNode=FocusNode();
    rsCityNode=FocusNode();
    rsStateNode=FocusNode();
    rsContryNode=FocusNode();
    rsUnitNode=FocusNode();
    rsStreetNode=FocusNode();
    firstNameController.text = widget.tenant?.info?.firstName ?? "";
    lastNameController.text = widget.tenant?.info?.lastName ?? "";
    phoneNumberController.text = widget.tenant?.info?.phone ?? "";
    emailController.text = widget.tenant?.info?.email ?? "";
    countryResidenceController.text = widget.tenant?.info?.country ?? "";
    countryIdController.text =  "-- left blank by applicant --";
    adnFristNameController.text = widget.tenant?.info?.firstName ?? "";
    adnLastNameController.text = widget.tenant?.info?.lastName ?? "";
    adnEmailController.text = widget.tenant?.info?.email ?? "";
    emegencyContactList=widget.tenant?.emergencyContacts ?? [];
    residentialHistorytList=widget.tenant?.residentialHistories ?? [];
    //additionalPeopleList=widget.tenant?.additionalPeople ?? [];
    additionalPeopleList = (widget.tenant?.additionalPeople ?? []).cast<AdditionalPerson>();
    print('addition people list lentgh:${additionalPeopleList.length}');

    //_loadInitialProspects();
    
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    countryResidenceController.dispose();
    countryIdController.dispose();
    firstNameNode.dispose();
    lastNameNode.dispose();
    phoneNumberNode.dispose();
    emailNode.dispose();
    countryResidenceNode.dispose();
    countryIdNode.dispose();
    removeDisposer();
    super.dispose();
  }

  void approveTenant() {
    if (!isAgreedNotifier.value) {
      alertManager.showError(
          context, "Please agree to all terms and conditions");
      return;
    }
    var request = {
    if(!isSameAsRent)  "securityDepositFee": depositFeeAmount,
      "isSameAsRent": isSameAsRent,
      "leaseStartDate": leaseStartDate,
      "leaseEndDate": leaseEndDate
    };
    propertyStore.approveTenant(widget.tenant?.Id ?? "", request);
  }

  void rejectTenant() {
    if (!isAgreedNotifier.value) {
      alertManager.showError(
          context, "Please agree to all terms and conditions");
      return;
    }

    propertyStore.rejectTenant(widget.tenant?.Id ?? "");
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => propertyStore.errorMessage, (String? errorMessage) {
        if (errorMessage != null) {
          alertManager.showError(context, errorMessage);
        }
      }),
      reaction((_) => propertyStore.approveTenantResponse,
          (CommonData? response) {
        if (response?.success ?? false) {
          context.router.maybePop();
        }
      }),
      reaction((_) => propertyStore.rejectTenantResponse,
          (CommonData? response) {
        if (response?.success ?? false) {
     context.router.maybePop();
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

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
              child: Text(
                "Info*",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 28.spMin,
                      fontWeight: FontWeight.w800,
                      color: appColor.primaryColor,
                    ),
              ),
            ),
            24.verticalSpace,
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                border: Border.all(color: Colors.black.withOpacity(.25)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.verticalSpace,
                  AppTextField(
                    readOnly: true,
                    controller: firstNameController,
                    focusNode: firstNameNode,
                    label: 'First Name*',
                    hintText: "Enter your first name",
                    textInputAction: TextInputAction.next,
                  ),
                  16.h.verticalSpace,
                  AppTextField(
                    readOnly: true,
                    controller: lastNameController,
                    focusNode: lastNameNode,
                    label: 'Last Name*',
                    hintText: "Enter your last name",
                    textInputAction: TextInputAction.next,
                  ),
                  16.h.verticalSpace,
                  AppTextField(
                    readOnly: true,
                    controller: phoneNumberController,
                    focusNode: phoneNumberNode,
                    label: 'Phone Number*',
                    hintText: "Enter your phone number",
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                  ),
                  16.h.verticalSpace,
                  AppTextField(
                    readOnly: true,
                    controller: emailController,
                    focusNode: emailNode,
                    label: 'Email*',
                    hintText: "Enter your email address",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  16.verticalSpace,
                  Text(
                    "Building",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 14.spMin,
                          fontWeight: FontWeight.w500,
                          color: appColor.primaryColor,
                        ),
                  ),
                  16.verticalSpace,
                  Text(
                    widget.tenant?.selectedUnit?.property?.info?.city ?? "",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 14.spMin,
                          fontWeight: FontWeight.w500,
                          color: appColor.primaryColor,
                        ),
                  ),
                  16.h.verticalSpace,
                  Text(
                    "apt. of interest",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 14.spMin,
                          fontWeight: FontWeight.w500,
                          color: appColor.primaryColor,
                        ),
                  ),
                  10.h.verticalSpace,
                  Text(
                    widget.tenant?.selectedUnit?.unit.toString() ?? "",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 14.spMin,
                          fontWeight: FontWeight.w400,
                          color: appColor.primaryColor,
                        ),
                  ),
                  16.verticalSpace,
                  AppTextField(
                    controller: anticipateController,
                    focusNode: emailNode,
                    label: 'Anticipated Move-in Request',
                    hintText: formatDate(widget.tenant?.info?.moveInRequest),
                    keyboardType: TextInputType.none,
                    readOnly: true,
                  ),
                  16.verticalSpace
                ],
              ),
            ),
            24.verticalSpace,
           
            if(widget.onlyShowData ??true) Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                border: Border.all(color: Colors.black.withOpacity(.25)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.verticalSpace,
                  Text(
                    "credit report check",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 24.spMin,
                          fontWeight: FontWeight.w500,
                          color: appColor.primaryColor,
                        ),
                  ),
                  16.verticalSpace,
                  AppTextField(
                    readOnly: true,
                    keyboardType: TextInputType.none,
                    controller: countryResidenceController,
                    focusNode: countryResidenceNode,
                    label: 'country of residence*',
                    hintText: "select country of residence",
                    //textInputAction: TextInputAction.next,
                  ),
                  16.h.verticalSpace,
                  AppTextField(
                    readOnly: true,
                    controller: countryIdController,
                    focusNode: countryIdNode,
                    label: 'country id # (SSN, NIN, etc.)',
                    hintText: "",
                    textInputAction: TextInputAction.next,
                  ),
                  16.h.verticalSpace,
                  Container(
                   margin: EdgeInsets.only(top: 12.h),
                   width: double.infinity,
                   height: 1.h,
                   color: appColor.primaryColor,
                  ),
                  16.h.verticalSpace,
                  Text(
                    "credit report chart analysis",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 18.spMin,
                          fontWeight: FontWeight.w500,
                          color: appColor.primaryColor,
                        ),
                  ),
                  16.h.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
              Expanded(
                
                child: Text(
                    "300",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 7.spMin,
                          fontWeight: FontWeight.w600,
                          color: appColor.primaryColor,
                        ),
                  ),
              ),
              
              Expanded(
                flex: 1,
                child: Text(
                    "620",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 14.32.spMin,
                          fontWeight: FontWeight.w600,
                          color: appColor.primaryColor,
                        ),
                  ),
              ),
              16.w.horizontalSpace,
              Expanded(
                flex: 1,
                child: Text(
                    "700",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 14.32.spMin,
                          fontWeight: FontWeight.w600,
                          color: appColor.primaryColor,
                        ),
                  ),
              ),
              Expanded(
                flex: 0,
                child: Text(
                    "850",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 7.spMin,
                          fontWeight: FontWeight.w600,
                          color: appColor.primaryColor,
                        ),
                  ),
              ),
            ],
                    ),
                  AppImage(
                    assetPath: theme.assets.chart,
                    height: 30.r,
                    width: double.infinity,
                  ),
                  2.h.verticalSpace,
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
        
                    _buildTextWithSuffix("failed", Icons.close, Colors.white, Colors.red),
        
                    _buildTextWithSuffix("passed(w/ conditions)", Icons.check, Colors.black, Colors.yellow),
        
                   _buildTextWithSuffix("passed (excellent)", Icons.close, Colors.white, appColor.greenColor),
                ],
              ),
              16.h.verticalSpace,
              AppImage(
                    assetPath: theme.assets.equifax,
                    height: 30.r,
                    width: 126.r,
                  ),
              8.h.verticalSpace,
              _buildTextWithPrefix('credit status : ',Icons.check, Colors.white, Colors.yellow,'passed (excellent)'),
              8.h.verticalSpace,
              
             _buildTextWithPrefix('background check / record : ',Icons.check, Colors.white, appColor.greenColor,'passed'),
             8.h.verticalSpace,
              _buildTextWithPrefix('collections : ',Icons.check, Colors.white, appColor.greenColor,'passed'),
              
              16.h.verticalSpace,
              AppImage(
                    assetPath: theme.assets.experian,
                    height: 30.r,
                    width: 126.r,
                  ),
              8.h.verticalSpace,
              _buildTextWithPrefix('credit status : ',Icons.check, Colors.white, Colors.yellow,'passed (w/conditions)'),
              8.h.verticalSpace,
              
             _buildTextWithPrefix('background check / record : ',Icons.close, Colors.white, Colors.red,'failed'),
             8.h.verticalSpace,
              _buildTextWithPrefix('collections : ',Icons.check, Colors.white, appColor.greenColor,'passed'),
               
               16.h.verticalSpace,
              AppImage(
                    assetPath: theme.assets.transuniun,
                    height: 30.r,
                    width: 126.r,
                  ),
              8.h.verticalSpace,
              _buildTextWithPrefix('credit status : ',Icons.check, Colors.white, Colors.yellow,'passed (w/conditions)'),
              8.h.verticalSpace,
              
             _buildTextWithPrefix('background check / record : ',Icons.check, Colors.white, appColor.greenColor,'passed'),
             8.h.verticalSpace,
              _buildTextWithPrefix('collections : ',Icons.check, Colors.white, Colors.yellow,'passed (w/conditions)'),
               
               16.h.verticalSpace,
                  Container(
                   margin: EdgeInsets.only(top: 12.h),
                   width: double.infinity,
                   height: 1.h,
                   color: appColor.primaryColor,
                  ),
                  16.h.verticalSpace,
                  
             AppImage(
                    assetPath: theme.assets.plaid,
                    height: 30.r,
                    width: 63.53.r,
                  ),
                  16.h.verticalSpace,
                  _buildTextWithPrefix('id verification : ',Icons.check, Colors.white, appColor.greenColor,'passed'),
                 16.h.verticalSpace,
                 Text(
                    "statements : doc.pdf",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 14.spMin,
                          fontWeight: FontWeight.w500,
                          color: appColor.primaryColor,
                        ),
                  ),
                  16.h.verticalSpace,
                
                ],
              ),
            ),
            16.h.verticalSpace,
            
            if(widget.onlyShowData ??true) Container(
  width: double.infinity,
  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
  margin: EdgeInsets.symmetric(horizontal: 20.w),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(12.r)),
    border: Border.all(color: Colors.black.withOpacity(.25)),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'add additional people',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 24.spMin,
            ),
      ),
      4.h.verticalSpace,
      Text(
        "Please note: Most U.S. property teams require a background check for all additional occupants aged 18 or older. If the property team requests that you add them, kindly provide their information below. They are expected to receive an email with a link to complete their application. After adding & send, please request them to check their email inbox, spam, etc.. Application fee applies.",
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: theme.primaryColor,
          fontSize: 8.spMin,
        ),
      ),
      10.h.verticalSpace, 

      ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: additionalPeopleList.length,
        shrinkWrap: true, 
        physics: NeverScrollableScrollPhysics(), 
        itemBuilder: (context, index) {
          
          final person = additionalPeopleList[index];

          final pfirstNameController = TextEditingController(text: person.firstName!);
         final plastNameController = TextEditingController(text: person.lastName!);
         final pemailController = TextEditingController(text: person.email!);
          return Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Row(
             children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     AppTextField(
                    readOnly: true,
                    controller: pfirstNameController,
                    //focusNode: phoneNumberNode,
                    label: 'First Name',
                    hintText: "Enter your First Name",
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                   ),
                    
                  ],
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    AppTextField(
                    readOnly: true,
                    controller: plastNameController,
                    //focusNode: phoneNumberNode,
                    label: 'Last Name',
                    hintText: "Enter your First Name",
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                  ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),

          
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     // Email Field
          //     Expanded(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           AppTextField(
          //           readOnly: true,
          //           controller: pemailController,
          //           //focusNode: phoneNumberNode,
          //           label: 'eMail',
          //           hintText: "Enter your First Name",
          //           keyboardType: TextInputType.phone,
          //           textInputAction: TextInputAction.next,
          //         ),
          //         ],
          //       ),
          //     ),
          //     10.horizontalSpace,

          //     // View Application Section
          //     // Expanded(
          //     //   child: Padding(
          //     //     padding: const EdgeInsets.only(top: 24.0), // align with TextField
          //     //     child: Row(
          //     //       children: [
          //     //         if (person.status!= null &&
          //     //             person.status!.isNotEmpty) ...[
          //     //           Icon(Icons.link, size: 16, color:appColor.primaryColor),
          //     //           SizedBox(width: 4),
          //     //           GestureDetector(
          //     //             onTap: () async {
          //     //               // final url = person['view_application']!;
          //     //               // if (await canLaunchUrl(Uri.parse(url))) {
          //     //               //   await launchUrl(Uri.parse(url));
          //     //               // }
          //     //             },
          //     //             child: Text(
          //     //               'View Application',
          //     //               style: TextStyle(
          //     //                 color: appColor.primaryColor,
          //     //                 decoration: TextDecoration.underline,
          //     //               ),
          //     //             ),
          //     //           )
          //     //         ] else ...[
          //     //           Icon(Icons.hourglass_empty, size: 16, color: Colors.grey),
          //     //           SizedBox(width: 4),
          //     //           Text(
          //     //             'Not Complete Yet',
          //     //             style: TextStyle(color: Colors.grey),
          //     //           )
          //     //         ]
          //     //       ],
          //     //     ),
          //     //   ),
          //     // ),
          //   ],
          // ),

          Divider(thickness: 1, height: 32),
              ],
            ),
          );
        },
      ),

    ],
  ),
),

    16.h.verticalSpace,

            
  if(widget.onlyShowData ??true) Container(
  width: double.infinity,
  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
  margin: EdgeInsets.symmetric(horizontal: 20.w),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(12.r)),
    border: Border.all(color: Colors.black.withOpacity(.25)),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'additional notes by applicant',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 24.spMin,
            ),
      ),
      4.h.verticalSpace,
      Text(
        "This section was left blank by the prospect applicant.",
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: theme.primaryColor,
          fontSize: 8.spMin,
        ),
      ),
      10.h.verticalSpace, 

     

    ],
  ),
),

    16.h.verticalSpace,

    if(widget.onlyShowData ??true) Container(
  width: double.infinity,
  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
  margin: EdgeInsets.symmetric(horizontal: 20.w),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(12.r)),
    border: Border.all(color: Colors.black.withOpacity(.25)),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'personal documents*',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 24.spMin,
            ),
      ),
      4.h.verticalSpace,
      _buildFileLink('john_id.pdf'),
      _buildFileLink('janessc.pdf'),
      _buildFileLink('paystub.doc'),
      
      10.h.verticalSpace, 

     

    ],
  ),
),

    16.h.verticalSpace,

    

   //todo for residential history container....          
  if (widget.onlyShowData ?? true)
   Container(
  width: double.infinity,
  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
  margin: EdgeInsets.symmetric(horizontal: 20.w),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(12.r)),
    border: Border.all(color: Colors.black.withOpacity(.25)),
  ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
        'residential history*',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 24.spMin,
            ),
      ),
          4.h.verticalSpace,
          ListView.builder(
              itemCount: residentialHistorytList.length, // +2 for Divider and Add button/text
              padding: const EdgeInsets.only(bottom: 16),
               shrinkWrap: true, 
               physics: NeverScrollableScrollPhysics(), 
              itemBuilder: (context, index) {
              return _buildResidenceForm(index);
           
              },
            ),

        ],
      ),
    ),



    16.h.verticalSpace,

     //todo for employment container....          
  if (widget.onlyShowData ?? true)
   Container(
  width: double.infinity,
  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
  margin: EdgeInsets.symmetric(horizontal: 20.w),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(12.r)),
    border: Border.all(color: Colors.black.withOpacity(.25)),
  ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
        'employment details',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 24.spMin,
            ),
      ),
         16.verticalSpace,
                  AppTextField(
                    readOnly: true,
                    controller: countryIdController,
                    focusNode: countryIdNode,
                    label: 'employer name (company name)',
                    hintText: "",
                    textInputAction: TextInputAction.next,
                  ),
                  10.h.verticalSpace,
                  AppTextField(
                    readOnly: true,
                    controller: countryIdController,
                    focusNode: countryIdNode,
                    label: 'company address',
                    hintText: "",
                    textInputAction: TextInputAction.next,
                  ),
                  10.h.verticalSpace,
                  
                  AppTextField(
                    readOnly: true,
                    keyboardType: TextInputType.none,
                    controller: countryResidenceController,
                    focusNode: countryResidenceNode,
                    label: 'company phone #',
                    hintText: "select country of residence",
                    //textInputAction: TextInputAction.next,
                  ),
                  10.h.verticalSpace,
                  AppTextField(
                    readOnly: true,
                    controller: countryIdController,
                    focusNode: countryIdNode,
                    label: 'your job title',
                    hintText: "",
                    textInputAction: TextInputAction.next,
                  ),
                  10.verticalSpace

        ],
      ),
    ),

    
 16.h.verticalSpace,
      //todo for emergency contact container....          
  if (widget.onlyShowData ?? true)
   Container(
  width: double.infinity,
  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
  margin: EdgeInsets.symmetric(horizontal: 20.w),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(12.r)),
    border: Border.all(color: Colors.black.withOpacity(.25)),
  ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
        'emergency contact',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 24.spMin,
            ),
      ),
          4.h.verticalSpace,
          ListView.builder(
              itemCount: emegencyContactList.length+2, // +2 for Divider and Add button/text
              padding: const EdgeInsets.only(bottom: 16),
               shrinkWrap: true, 
               physics: NeverScrollableScrollPhysics(), 
              itemBuilder: (context, index) {
          if (index < emegencyContactList.length) {
            return _buildProspectForm(index);
          } else if (index == emegencyContactList.length) {
            return const Divider();
          } else {
            // index == prospectList.length + 1
            return Column(
              children: [
                if (emegencyContactList.length < 4)
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: _addProspect,
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: appColor.primaryColor, width: 2),
              ),
              child:  Icon(Icons.add, color:appColor.primaryColor, size: 20),
            ),
            const SizedBox(width: 8),
            
               Text(
        'add more',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 16.spMin,
            ),
      ),
          ],
        ),
      ),
      const SizedBox(height: 4),
      const Text(
        "(up to 3 prior addresses if applicable)",
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
    ],
  ),

              ],
            );
          }
              },
            ),

        ],
      ),
    ),



    16.h.verticalSpace,
   
   if (widget.onlyShowData ?? true)
   Container(
  width: double.infinity,
  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
  margin: EdgeInsets.symmetric(horizontal: 20.w),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(12.r)),
    border: Border.all(color: Colors.black.withOpacity(.25)),
  ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
        'security deposit already paid',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 24.spMin,
            ),
      ),
      8.verticalSpace,
        Text(
        'This just an acknowledgement.Tenant does not repay another deposit fee.',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14.spMin,
            ),
      ),
      
         16.verticalSpace,
                  AppTextField(
                    readOnly: true,
                    controller: countryIdController,
                    focusNode: countryIdNode,
                    label: 'deposit fee amount paid',
                    hintText: "",
                    textInputAction: TextInputAction.next,
                  ),
                  10.h.verticalSpace,
        ],
      ),
    ),

    16.h.verticalSpace,

    if (widget.onlyShowData ?? true)
   Container(
  width: double.infinity,
  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
  margin: EdgeInsets.symmetric(horizontal: 20.w),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(12.r)),
    border: Border.all(color: Colors.black.withOpacity(.25)),
  ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
        'lease agreement*',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 24.spMin,
            ),
      ),
             _buildLeaseBlock(),
              const Divider(height: 40),
              _buildLeaseBlock(),
      
      10.h.verticalSpace,
        ],
      ),
    ),

    16.h.verticalSpace,

            if(widget.onlyShowData ??true)   Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                border: Border.all(color: Colors.black.withOpacity(.25)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.verticalSpace,
                  Text(
                    "prospect tenant agreed to the following:",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 28.spMin,
                          fontWeight: FontWeight.w800,
                          color: appColor.primaryColor,
                        ),
                  ),
                  16.verticalSpace,
                  ValueListenableBuilder<bool>(
                    valueListenable: isAgreedNotifier,
                    builder: (context, isAgreed, _) {
                      return AgreementCheckboxes(
                        onAllChecked: () {
                          isAgreedNotifier.value = true;
                        },
                      );
                    },
                  ),
                  16.h.verticalSpace,
                ],
              ),
            ),
            if(widget.onlyShowData ??true)     24.verticalSpace,
            if(widget.onlyShowData ??true)      Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                border: Border.all(color: Colors.black.withOpacity(.25)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Do you charge security deposit?*",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 24.spMin,
                          fontWeight: FontWeight.w800,
                          color: appColor.primaryColor,
                        ),
                  ),
                  16.verticalSpace,
                  Row(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: isSecurityDepositChecked,
                            onChanged: (value) {
                              setState(() {
                                isSecurityDepositChecked = value ?? false;
                                isSameAsRent = false;
                              });
                            },
                          ),
                          Text(
                            "yes",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: 14.spMin,
                                ),
                          ),
                        ],
                      ),
                      20.horizontalSpace,
                      Row(
                        children: [
                          Checkbox(
                            value: !isSecurityDepositChecked,
                            onChanged: (value) {
                              setState(() {
                                isSecurityDepositChecked = !(value ?? false);
                                isSameAsRent = false;
                              });
                            },
                          ),
                          Text(
                            "no",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: 14.spMin,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (isSecurityDepositChecked) ...[
                    16.verticalSpace,
                    Text(
                      "deposit fee amount",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 14.spMin,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    8.verticalSpace,
                    TextField(
                      decoration: InputDecoration(
                        hintText: "1000",
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 10.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          depositFeeAmount = int.parse(value);
                        });
                      },
                    ),
                  ],
                  16.verticalSpace,
                  Row(
                    children: [
                      Checkbox(
                        value: isSameAsRent,
                        onChanged: (value) {
                          setState(() {
                            isSameAsRent = value ?? false;
                            if (isSameAsRent) {
                              isSecurityDepositChecked = true;
                              depositFeeAmount = 0; // Example value
                            }
                          });
                        },
                      ),
                      Text(
                        "same amount as rent",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 14.spMin,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if(widget.onlyShowData ??true)      25.verticalSpace,
            if(widget.onlyShowData ??true)    LeaseDurationWidget(onDateChanged: (DateTime? startDate, DateTime? endDate) {
              leaseStartDate = startDate?.toIso8601String() ;
              leaseEndDate = endDate?.toIso8601String() ;
            },),
            if(widget.onlyShowData ??true)   25.verticalSpace,
            if(widget.onlyShowData ??true)   Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              child: PrimaryButton(
                text: "proceed to next phase",
                onPressed: approveTenant,
              ),
            ),
            if(widget.onlyShowData ??true)   Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              child: Text(
                "**Note: If application is approved by you, then the tenant would see an approved for signing lease user interface where they can now make the deposit.ß",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 11.spMin,
                      fontWeight: FontWeight.w800,
                      color: appColor.primaryColor,
                    ),
              ),
            ),
            if(widget.onlyShowData ??true)  16.verticalSpace,
            if(widget.onlyShowData ??true)   Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              child: AppOutlinedButton(
                  text: "disapprove application", onPressed: () {
                    propertyStore.rejectTenant(widget.tenant?.Id ?? "");
                context.router.maybePop();
              }),
            ),
            if(widget.onlyShowData ??false)   Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              child: Text(
                "**Note: Disapproving an application would disqualify this applicant from renting this unit. The prospect would have to reapply if they are ever interested in inquiring about the unit.",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 11.spMin,
                      fontWeight: FontWeight.w800,
                      color: appColor.primaryColor,
                    ),
              ),
            ),
            if(widget.onlyShowData ??false)   30.verticalSpace
          ],
        ),
      ),
    );
  }

 String formatDate(String? date) {
    if (date == null || date.isEmpty) return "";
    try {
      return DateFormat('MM/dd/yyyy').format(DateTime.parse(date));
    } catch (e) {
      print("Error parsing date: $e");
      return "";
    }
  }
 Widget _buildTextWithSuffix(String text, IconData icon, Color iconColor, Color backgroundColor) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 16,
        height: 16,
        
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 14,
          color: iconColor,
        ),
      ),
       SizedBox(width: 4),
      Text(
        text,
        style: TextStyle(
          fontSize: 8.spMin,
          fontWeight: FontWeight.w500,
          color: appColor.primaryColor,
        ),
      ),
     
      
    ],
  );
}
 Widget _buildTextWithPrefix(String title,IconData icon, Color iconColor, Color backgroundColor,String text) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        title ,
        style: TextStyle(
          fontSize: 12.spMin,
          fontWeight: FontWeight.w500,
          color: appColor.primaryColor,
        ),
      ),
      SizedBox(width: 4),
      Container(
        width: 16,
        height: 16,
        
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 14,
          color: iconColor,
        ),
      ),
       SizedBox(width: 4),
      Text(
        text,
        style: TextStyle(
          fontSize: 8.spMin,
          fontWeight: FontWeight.w500,
          color: appColor.primaryColor,
        ),
      ),
     
      
    ],
  );
}

 Widget _buildFileLink(String fileName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () {
          // Handle file open or download
        },
        child:Text(
        fileName ,
        style: TextStyle(
          fontSize: 12.spMin,
          fontWeight: FontWeight.w500,
          color: appColor.primaryColor,
          decoration: TextDecoration.underline,
        ),
      ),
      ),
    );
  }

//todo for residential history.....
void _addProspect() {
    setState(() {
      prospectList.add({
        'street': TextEditingController(),
        'unit': TextEditingController(),
        'city': TextEditingController(),
        'state': TextEditingController(),
        'country': 'USA', // default selected
      });
      editableIndex = prospectList.length - 1;
    });
  }

Widget _buildTextField(String label, TextEditingController controller, bool readOnly) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: AppTextField(
        controller: controller,
        label: label,
        hintText: 'Enter $label',
        readOnly: readOnly,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
      ),
    );
  }

Widget _buildCountryDropdown(int index, bool readOnly) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: DropdownButtonFormField<String>(
      value: residentialHistorytList[index].country?.isNotEmpty == true
          ? residentialHistorytList[index].country
          : null,
      onChanged: readOnly
          ? null
          : (val) {
              setState(() {
                residentialHistorytList[index].country = val!;
              });
            },
      decoration: InputDecoration(
        labelText: 'Country',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelStyle: const TextStyle(fontSize: 16, color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: readOnly ? Colors.grey.shade200 : Colors.white,
        isDense: true,
      ),
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      isExpanded: true,
      style: const TextStyle(fontSize: 16, color: Colors.black),
      dropdownColor: Colors.white,
      hint: const Text('Select Country', style: TextStyle(fontSize: 16)),
      items: residentialHistorytList
          .map((country) => DropdownMenuItem<String>(
                value: residentialHistorytList[index].country,
                child: Text(residentialHistorytList[index].country.toString()),
              ))
          .toList(),
    ),
  );
}

Widget _buildProspectForm(int index) {
    final readOnly = editableIndex != index;
    emNameController.text=emegencyContactList[index].name!;
    emContactController.text=emegencyContactList[index].phone!;

    return GestureDetector(
      onTap: () {
        setState(() {
          editableIndex = index;
        });
      },
      child: Column(
        children: [
          _buildTextField("name", emNameController, readOnly),
           
          10.verticalSpace,
           _buildTextField("contact", emContactController, readOnly),
          
         
         
        ],
      ),
    );
  }

Widget _buildResidenceForm(int index) {
    final readOnly = editableIndex != index;
    rsStreetController.text=residentialHistorytList[index].street!;
    rsUnitController.text=residentialHistorytList[index].unit!;
    rsStateController.text=residentialHistorytList[index].state!;
    rsCityController.text=residentialHistorytList[index].city!;
    rscontryController.text=residentialHistorytList[index].country!;

    return GestureDetector(
      onTap: () {
        setState(() {
          editableIndex = index;
        });
      },
      child: Column(
        children: [
          _buildTextField("street", rsStreetController, readOnly),
          10.h.verticalSpace,
           Row(
            children: [
             
           Expanded(child: _buildTextField("apt/unit", rsUnitController, readOnly)),
           8.w.horizontalSpace,
           Expanded(child: _buildTextField("city", rsCityController, readOnly)),
           
            ],
           ),
            10.h.verticalSpace,
           Row(
            children: [
              Expanded(child: _buildTextField("state", rsStateController, readOnly)),
              8.w.horizontalSpace,
              Expanded(child: _buildTextField("country", rscontryController, readOnly)),
            ],
           ),
        ],
      ),
    );
  }

Widget _buildLeaseBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            // Handle PDF open/download
          },
          child: Text(
        'full lease agreement.pdf' ,
        style: TextStyle(
          fontSize: 12.spMin,
          fontWeight: FontWeight.w500,
          color: appColor.primaryColor,
          decoration: TextDecoration.underline,
        ),
      ),
        ),
        16.verticalSpace,
        Text(
        'signed:' ,
        style: TextStyle(
          fontSize: 12.spMin,
          fontWeight: FontWeight.w500,
          color: appColor.primaryColor,
          //decoration: TextDecoration.underline,
        ),
      ),
        8.verticalSpace,
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            border: Border.all(color: appColor.primaryColor),
            borderRadius: BorderRadius.circular(6),
          ),
          child:  Text(
            "John Doe",
            style: TextStyle(
              fontFamily: 'Cursive',
              fontSize: 24.spMin,
             fontWeight: FontWeight.w500,
             color: appColor.primaryColor,
            ),
          ),
        ),
        12.verticalSpace,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(value: leaseAgreement, onChanged: (val) {
                               setState(() {
                                leaseAgreement = val ?? false;
                                
                              });
            }),
             Expanded(
              child: Text(
                "I confirm that I have read and accept the terms of the lease agreement.",
                style: TextStyle(
                  fontSize: 14.spMin,
                  fontWeight: FontWeight.w500,
                  color: appColor.primaryColor,),
              ),
            ),
          ],
        ),
      ],
    );
  }  
}


class LeaseDurationWidget extends StatefulWidget {
  final Function(DateTime? startDate, DateTime? endDate) onDateChanged;

  const LeaseDurationWidget({Key? key, required this.onDateChanged}) : super(key: key);

  @override
  _LeaseDurationWidgetState createState() => _LeaseDurationWidgetState();
}

class _LeaseDurationWidgetState extends State<LeaseDurationWidget> {
  DateTime? leaseStartDate;
  DateTime? leaseEndDate;

  String formatDate(DateTime? date) {
    return date != null ? "${date.month}/${date.day}" : "";
  }

  Future<void> pickDate(BuildContext context, bool isStartDate) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(2000);
    DateTime lastDate = DateTime(2100);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? leaseStartDate ?? initialDate
          : leaseEndDate ?? initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          leaseStartDate = pickedDate;
        } else {
          leaseEndDate = pickedDate;
        }
      });

      // Call the callback to notify the parent widget
      widget.onDateChanged(leaseStartDate, leaseEndDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.black.withOpacity(.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What’s the lease duration?*",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 24.spMin,
              fontWeight: FontWeight.w800,
              color: appColor.primaryColor,
            ),
          ),
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "lease start date",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14.spMin,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  8.verticalSpace,
                  GestureDetector(
                    onTap: () => pickDate(context, true),
                    child: Container(
                      width: 120.w,
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        border:
                        Border.all(color: Colors.black.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.calendar_today,
                              size: 16.spMin, color: Colors.grey),
                          Text(
                            formatDate(leaseStartDate),
                            style: TextStyle(fontSize: 14.spMin),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "lease end date",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14.spMin,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  8.verticalSpace,
                  GestureDetector(
                    onTap: () => pickDate(context, false),
                    child: Container(
                      width: 120.w,
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        border:
                        Border.all(color: Colors.black.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.calendar_today,
                              size: 16.spMin, color: Colors.grey),
                          Text(
                            formatDate(leaseEndDate),
                            style: TextStyle(fontSize: 14.spMin),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
  

}

