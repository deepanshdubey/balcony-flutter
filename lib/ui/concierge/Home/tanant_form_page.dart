import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/router/app_router.dart';
import 'package:homework/ui/concierge/store/concierge_store.dart';
import 'package:homework/widget/app_back_button.dart';
import 'package:homework/widget/app_text_field.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:mobx/mobx.dart';

@RoutePage()
class TenantFormPage extends StatefulWidget {
  const TenantFormPage({Key? key}) : super(key: key);

  @override
  State<TenantFormPage> createState() => _TenantFormPageState();
}

class _TenantFormPageState extends State<TenantFormPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();

  String? _selectedProperty;
  String? _selectedPropertyId;
   List<String?>? _properties;

  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedProperty != null) {
      final tenantData = {
        "firstName": _firstNameController.text,
        "lastName": _lastNameController.text,
        "email": _emailController.text,
        "phone": _phoneController.text,
        "unit": _unitController.text,
        "propertyId": _selectedPropertyId,
      };

      conciergeStore.conciergeTenantAdd(tenantData);

      print("Tenant Data: $tenantData");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields correctly")),
      );
    }
  }


  final conciergeStore = ConciergeStore();
  List<ReactionDisposer>? disposers;


  @override
  void initState() {
    addDisposer();
    conciergeStore.conciergePropertyAll();
    super.initState();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => conciergeStore.conciergePropertyResponse, (response) {
        _properties = response?.properties?.conciergeProperties
            ?.map((property) => property.name)
            .toList();
        setState(() {});
      }),
      reaction((_) => conciergeStore.errorMessage, (String? errorMessage) {
        if (errorMessage != null) {
          alertManager.showError(context, errorMessage);
        }
      }),
      reaction((_) => conciergeStore.conciergeTenantAddResponse, (response) {
      if(response?.success ?? false){
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              25.verticalSpace,
              AppBackButton(
                text: "Back",
              ),
              20.verticalSpace,
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.black.withOpacity(.25)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextField(
                          controller: _firstNameController,
                          label: "First Name",
                          hintText: "Enter first name",
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "First name is required";
                            }
                            return null;
                          },
                        ),
                        16.verticalSpace,
                        AppTextField(
                          controller: _lastNameController,
                          label: "Last Name",
                          hintText: "Enter last name",
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Last name is required";
                            }
                            return null;
                          },
                        ),
                        16.verticalSpace,
                        AppTextField(
                          controller: _emailController,
                          label: "Email",
                          hintText: "Enter email",
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email is required";
                            }
                            if (!RegExp(
                                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}")
                                .hasMatch(value)) {
                              return "Enter a valid email";
                            }
                            return null;
                          },
                        ),
                        16.verticalSpace,
                        AppTextField(
                          controller: _phoneController,
                          label: "Phone",
                          hintText: "Enter phone number",
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Phone number is required";
                            }
                            if (!RegExp(r"^\+?[0-9]{7,15}").hasMatch(value)) {
                              return "Enter a valid phone number";
                            }
                            return null;
                          },
                        ),
                        16.verticalSpace,
                        AppTextField(
                          controller: _unitController,
                          label: "Unit",
                          hintText: "Enter unit number",
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Unit number is required";
                            }
                            return null;
                          },
                        ),
                        16.verticalSpace,
                        Text(
                          "Property",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontSize: 14.spMin, fontWeight: FontWeight.w500),
                        ),
                        8.verticalSpace,
                        Observer(
                          builder: (context) {
                            return Container(
                              height: 40.h,
                              child: DropdownButtonFormField<String>(
                                value: _selectedProperty,
                                items: _properties
                                    ?.map((property) => DropdownMenuItem(
                                          value: property,
                                          child: Text(property ?? "Null"),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedProperty = value; // Store the selected property ID
                                    _selectedPropertyId = conciergeStore.conciergePropertyResponse?.properties?.conciergeProperties?.firstWhere(
                                          (property) => property.name == value, // Match ID
                                    ).Id; // Get property name for additional use
                                  });
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 20).r,
                                  labelText: "Select Property",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Property selection is required";
                                  }
                                  return null;
                                },
                              ),
                            );
                          }
                        ),
                        32.verticalSpace,
                        PrimaryButton(
                          text: "Submit",
                          onPressed: _submitForm,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
