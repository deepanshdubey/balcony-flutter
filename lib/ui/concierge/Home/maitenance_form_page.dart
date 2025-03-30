import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/ui/concierge/store/concierge_store.dart';
import 'package:homework/widget/app_back_button.dart';
import 'package:homework/widget/app_text_field.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:mobx/mobx.dart';

@RoutePage()
class MaintenanceFormPage extends StatefulWidget {
  const MaintenanceFormPage({Key? key}) : super(key: key);

  @override
  State<MaintenanceFormPage> createState() => _MaintenanceFormPageState();
}

class _MaintenanceFormPageState extends State<MaintenanceFormPage> {
  final TextEditingController _tenantIdController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final conciergeStore = ConciergeStore();
  List<ReactionDisposer>? disposers;

  String? _selectedTenant;
  String? _selectedTenantId;
  List<String?>? tenants;

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedTenant != null) {
      final formData = {
        "type": "concierge-tenant",
        "tenantId": _selectedTenantId,
        "note": _noteController.text,
      };

      conciergeStore.maintenanceAdd(formData);

      print("Form Data: $formData");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields correctly")),
      );
    }
  }

  @override
  void initState() {
    conciergeStore.conciergeTenantAll();
    addDisposer();
    super.initState();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => conciergeStore.conciergeTenantAllResponse, (response) {
        tenants = response?.tenants?.conciergeTenants
            ?.map((property) => property.info?.firstName)
            .toList();
        setState(() {});
      }),
      reaction((_) => conciergeStore.maintenanceAddResponse, (response) {
        if (response?.success ?? false) {
          context.router.maybePop();
        }
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
                        Text(
                          "tenant's name",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  fontSize: 14.spMin,
                                  fontWeight: FontWeight.w500),
                        ),
                        8.verticalSpace,
                        Observer(builder: (context) {
                          return Container(
                            height: 40.h,
                            child: DropdownButtonFormField<String>(
                              value: _selectedTenant,
                              items: tenants
                                  ?.map((property) => DropdownMenuItem(
                                        value: property,
                                        child: Text(property ?? "Null"),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedTenant =
                                      value; // Store the selected property ID
                                  _selectedTenantId = conciergeStore
                                      .conciergeTenantAllResponse
                                      ?.tenants
                                      ?.conciergeTenants
                                      ?.firstWhere(
                                        (tenant) =>
                                            tenant.info?.firstName ==
                                            value, // Match ID
                                      )
                                      .Id; // Get property name for additional use
                                });
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 20).r,
                                labelText: "Select Property",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Tenant selection is required";
                                }
                                return null;
                              },
                            ),
                          );
                        }),
                        16.verticalSpace,
                        AppTextField(
                          controller: _noteController,
                          label: "Note",
                          hintText: "Enter note",
                          textInputAction: TextInputAction.done,
                          maxLines: 3,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Note is required";
                            }
                            return null;
                          },
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
