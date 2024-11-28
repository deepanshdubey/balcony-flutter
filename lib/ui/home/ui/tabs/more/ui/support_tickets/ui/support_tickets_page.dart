import 'package:balcony/generated/assets.dart';
import 'package:balcony/ui/home/ui/tabs/more/ui/support_tickets/create_support_ticket/ui/create_support_ticket_page.dart';
import 'package:balcony/ui/home/ui/tabs/more/ui/support_tickets/create_support_ticket/ui/reply_support_ticket_page.dart';
import 'package:balcony/ui/home/ui/tabs/more/ui/support_tickets/store/support_ticket_store.dart';
import 'package:balcony/ui/home/ui/tabs/more/ui/support_tickets/widget/section_title.dart';
import 'package:balcony/ui/home/ui/tabs/more/ui/support_tickets/widget/ticket_list_widget.dart';
import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/widget/app_back_button.dart';
import 'package:balcony/widget/app_image.dart';
import 'package:balcony/widget/app_outlined_button.dart';
import 'package:balcony/widget/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupportTicketsPage extends StatefulWidget {
  const SupportTicketsPage({super.key});

  @override
  _SupportTicketsPageState createState() => _SupportTicketsPageState();
}

class _SupportTicketsPageState extends State<SupportTicketsPage> {
  final ValueNotifier<int> rowsPerPageNotifier = ValueNotifier<int>(3);
  final List<int> rowOptions = [3, 5, 10];
  int currentPage = 1;
  final TextEditingController _filterController = TextEditingController();

  @override
  void initState() {
    supportTicketStore.getSupportTickets();
    super.initState();
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
                text: 'back to menu',
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              16.h.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 5,
                      child: AppTextField(
                          controller: _filterController,
                          hintText: "filter search...")),
                  20.horizontalSpace,
                  Expanded(
                      flex: 2,
                      child: AppOutlinedButton(
                        text: 'view',
                        onPressed: () {},
                      ))
                ],
              ),
              20.verticalSpace,
              const SectionTitle(
                  title: "support tickets", subtitle: " (active)"),
              20.verticalSpace,
              addNewSupportTicket(),
              16.h.verticalSpace,
              Observer(builder: (context) {
                var activeTickets = supportTicketStore.supportTicketsResponse
                    ?.where(
                      (element) => element.status == 'active',
                    )
                    .toList();
                var isLoading = supportTicketStore.isLoading;
                return TicketListWidget(
                  isLoading: isLoading,
                  tickets: activeTickets ?? [],
                  onViewReply: (ticket) {
                    showAppBottomSheet(
                        context, ReplySupportTicketPage(ticket: ticket));
                  },
                );
              }),
              16.h.verticalSpace,
              const SectionTitle(
                  title: "support tickets", subtitle: " (inactive)"),
              16.h.verticalSpace,
              Observer(builder: (context) {
                var isLoading = supportTicketStore.isLoading;
                var inActiveTickets = supportTicketStore.supportTicketsResponse
                    ?.where(
                      (element) => element.status != 'active',
                    )
                    .toList();
                return TicketListWidget(
                  isLoading: isLoading,
                  tickets: inActiveTickets ?? [],
                  onViewReply: (ticket) {
                    showAppBottomSheet(
                        context, ReplySupportTicketPage(ticket: ticket));
                  },
                );
              }),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget addNewSupportTicket() {
    return GestureDetector(
        onTap: () {
          showAppBottomSheet(context, CreateSupportTicketPage());
        },
        child: Row(
          children: [
            AppImage(
                height: 30.r, width: 30.r, assetPath: Assets.imagesLargePlus),
            16.w.horizontalSpace,
            Expanded(
              child: Text(
                "add new support request",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            )
          ],
        ));
  }
}
