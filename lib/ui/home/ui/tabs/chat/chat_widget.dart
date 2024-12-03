import 'package:balcony/ui/home/ui/tabs/chat/ui/chat_details_page.dart';
import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/widget/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatWidget extends StatelessWidget {
  final String image, name, lastMessage, time ;

  const ChatWidget({
    super.key,
    required this.image,
    required this.name,
    required this.lastMessage,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        showAppBottomSheet(context, ChatDetailsPage());
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
                      width: context.width * .15,
                      child: Text(
                        lastMessage,
                        textAlign: TextAlign.center,
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
