import 'package:homework/core/alert/alert_manager_impl.dart';
import 'package:homework/generated/assets.dart';
import 'package:homework/ui/home/ui/tabs/chat/ui/chat_details_page.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/values/extensions/theme_ext.dart';
import 'package:homework/widget/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatWidget extends StatelessWidget {
  final String image, name, lastMessage, time;

  final String? senderId;
  final String? receiverId;
  final String? conversationId;

  const ChatWidget({
    super.key,
    required this.image,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.senderId,
    this.receiverId,
    this.conversationId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        showAppBottomSheet(
            context,
            ChatDetailsPage(
              receiverId: receiverId,
              conversationId: conversationId,
              name: name,
              image: image,
            ));
      },
      child: Column(
        children: [
          8.h.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              image == ""
                  ? Container(
                      width: 60.r, // Diameter (2 * radius)
                      height: 60.r, // Diameter (2 * radius)
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).primaryColor, // Border color
                          width: 2.0, // Border width
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ClipOval(
                          child: Image.asset(
                            Assets.imagesProfile, // Your image asset path
                            fit: BoxFit
                                .cover, // Ensure the image fits within the circle
                          ),
                        ),
                      ),
                    )
                  : AppImage(
                      url: image,
                      radius: 30.r,
                      placeholder: Image.asset(Assets.imagesProfile),
                    ),
              25.w.horizontalSpace,
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  8.verticalSpace,
                  Text(
                    name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 20.spMin,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  5.h.verticalSpace,
                  SizedBox(
                      width: context.width * .30,
                      child: Text(
                        lastMessage,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 14.spMin,
                          color: Theme.of(context).colors.grayBorder,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                ],
              )),
              Column(
                children: [
                  8.verticalSpace,
                  Text(
                    time,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 12.spMin,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            ],
          ),
          8.h.verticalSpace,
          Container(
            height: 1.h,
            color: theme.primaryColor.withOpacity(.12),
          )
        ],
      ),
    );
  }
}
