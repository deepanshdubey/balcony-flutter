import 'package:balcony/core/alert/alert_manager.dart';
import 'package:balcony/ui/home/ui/tabs/more/ui/support_tickets/store/support_ticket_store.dart';
import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/widget/app_back_button.dart';
import 'package:balcony/widget/app_text_field.dart';
import 'package:balcony/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';

class CreateSupportTicketPage extends StatefulWidget {
  const CreateSupportTicketPage({super.key});

  @override
  _CreateSupportTicketPageState createState() =>
      _CreateSupportTicketPageState();
}

class _CreateSupportTicketPageState extends State<CreateSupportTicketPage> {
  final TextEditingController summaryController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  List<ReactionDisposer>? disposers;

  @override
  void initState() {
    addDisposer();
    supportTicketStore.getOnGoingWorkspaces();
    super.initState();
  }

  @override
  void dispose() {
    removeDisposer();
    super.dispose();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => supportTicketStore.createSupportTicketResponse,
          (response) {
        if (response != null) {
          alertManager.showSuccess(context, 'ticket created successfully');
        }
      }),
      reaction((_) => supportTicketStore.errorMessage, (String? errorMessage) {
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
          padding: const EdgeInsets.all(16.0).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBackButton(
                text: 'back to support page',
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              16.h.verticalSpace,
              Form(
                key: formKey,
                child: Container(
                  width: context.width,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.r)),
                      border: Border.all(
                          color:
                              Theme.of(context).primaryColor.withOpacity(.25))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.h.verticalSpace,
                      Text(
                        'support context',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 24.spMin,
                            ),
                      ),
                      16.h.verticalSpace,
                      AppTextField(
                        controller: summaryController,
                        label: '',
                        showLabelAboveField: false,
                        minLines: 4,
                        maxLines: 4,
                        hintText: 'Type your message here.',
                        keyboardType: TextInputType.text,
                        validator: (p0) {
                          if ((p0?.length ?? 0) < 20) {
                            return 'write a few words';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      16.h.verticalSpace,
                      SizedBox(
                        width: context.width - 40.w,
                        child: Observer(builder: (context) {
                          var isLoading = supportTicketStore.isLoading;
                          return PrimaryButton(
                            text: 'add to request',
                            isLoading: isLoading,
                            onPressed: () {
                              if (formKey.currentState?.validate() == true) {
                                supportTicketStore.createSupportTicket({
                                  /*"workspaceId": "60e3b5f3c7a1f98f8a3d3a75",
                                  "propertyId": "60e3b5f3c7a1f98f8a3d3a76",*/
                                  "context": summaryController.text.trim(),
                                });
                              }
                            },
                          );
                        }),
                      ),
                      16.h.verticalSpace,
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
