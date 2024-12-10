import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/core/locator/locator.dart';
import 'package:homework/data/model/response/support_ticket_data.dart';
import 'package:homework/ui/home/ui/tabs/more/ui/support_tickets/store/support_ticket_store.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/widget/app_back_button.dart';
import 'package:homework/widget/app_outlined_button.dart';
import 'package:homework/widget/app_text_field.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

class ReplySupportTicketPage extends StatefulWidget {
  final SupportTicketData ticket;

  const ReplySupportTicketPage({super.key, required this.ticket});

  @override
  _ReplySupportTicketPageState createState() => _ReplySupportTicketPageState();
}

class _ReplySupportTicketPageState extends State<ReplySupportTicketPage> {
  final TextEditingController summaryController = TextEditingController();
  final TextEditingController workspaceController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  List<ReactionDisposer>? disposers;
  String? selectedId;

  ThemeData get theme => Theme.of(context);

  @override
  void initState() {
    addDisposer();
    super.initState();
  }

  @override
  void dispose() {
    removeDisposer();
    super.dispose();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => supportTicketStore.replySupportTicketResponse,
          (response) {
        if (response != null) {
          setState(() {
            var context = summaryController.text.trim();
            summaryController.clear();
            widget.ticket.conversation?.add(Conversation(
              from: "host",
              context: context,
              sendOn: DateTime.now().toString(),
            ));
          });
        }
      }),
      reaction((_) => supportTicketStore.closeSupportTicketResponse,
          (response) {
        if (response != null) {
          alertManager.showSuccess(
            context,
            'ticket closed successfully',
            afterAlert: () {
              supportTicketStore.getSupportTickets();
              Navigator.of(context).pop();
            },
          );
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
              Container(
                width: context.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(.25),
                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 24.h),
                        child: Text(
                          "Support #: ${widget.ticket.id}",
                          maxLines: 1,
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleLarge,
                        ),
                      ),
                    ),
                    if (widget.ticket.status == 'active')
                      Container(
                        width: 1.w,
                        height: 60,
                        margin: EdgeInsets.symmetric(horizontal: 8.w),
                        color: theme.primaryColor,
                      ),
                    if (widget.ticket.status == 'active')
                      Expanded(
                        child: Observer(builder: (context) {
                          var isLoading = supportTicketStore.isLoading;
                          return isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : AppOutlinedButton(
                                  text: "close ticket",
                                  backgroundColor: Colors.white,
                                  //isLoading: isLoading,
                                  onPressed: () {
                                    logger.i(widget.ticket.id);
                                    supportTicketStore.closeSupportTicket(
                                        widget.ticket.id ?? "");
                                  },
                                );
                        }),
                      ),
                    16.w.horizontalSpace,
                  ],
                ),
              ),
              16.h.verticalSpace,
              if (widget.ticket.status == 'active')
                Form(
                  key: formKey,
                  child: Container(
                    width: context.width,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12.r)),
                        border: Border.all(
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(.25))),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        16.h.verticalSpace,
                        Text(
                          'support context',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
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
                                  supportTicketStore.replySupportTicket({
                                    "ticketId": widget.ticket.id,
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
                ),
              Container(
                height: 1.h,
                width: context.width,
                color: theme.primaryColor,
                margin: EdgeInsets.symmetric(vertical: 16.h),
              ),
              if (widget.ticket.status != 'active')
                Text(
                  "Completed",
                  style: theme.textTheme.titleLarge,
                ),
              if (widget.ticket.status != 'active') 8.h.verticalSpace,
              Column(
                children: (widget.ticket.conversation ?? [])
                    .map(
                      (e) => conservationItem(e),
                    )
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget conservationItem(Conversation e) {
    return Container(
      width: context.width,
      margin: EdgeInsets.symmetric(vertical: 4.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
        border: Border.all(color: theme.primaryColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                "${e.from!} response",
                style: theme.textTheme.titleMedium,
              )),
              Text(
                DateFormat("MMMM dd, yyyy").format(DateTime.parse(e.sendOn!)),
                style: theme.textTheme.titleMedium,
              )
            ],
          ),
          Container(
            width: context.width,
            height: 1.h,
            margin: EdgeInsets.only(top: 8.h, bottom: 16.h),
            color: theme.primaryColor,
          ),
          Text(
            e.context!,
            style: theme.textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}
