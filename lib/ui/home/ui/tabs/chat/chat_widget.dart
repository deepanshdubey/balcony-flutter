import 'package:homework/generated/assets.dart';
import 'package:homework/ui/home/ui/tabs/chat/ui/chat_details_page.dart';
import 'package:homework/values/extensions/context_ext.dart';
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
    return GestureDetector(
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
              AppImage(
                url: image,
                radius: 30.r,
                 placeholder: Image.asset(Assets.imagesProfile),
              ),
              25.w.horizontalSpace,
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 17.spMin,
                      fontWeight: FontWeight.bold,
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
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                ],
              )),
              Text(
                time,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 12.spMin,
                  fontWeight: FontWeight.w500,
                ),
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
