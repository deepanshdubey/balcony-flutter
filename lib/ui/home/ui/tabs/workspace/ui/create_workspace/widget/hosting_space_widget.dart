import 'package:balcony/ui/home/ui/tabs/workspace/ui/create_workspace/widget/workspace_photos_widget.dart';
import 'package:balcony/values/extensions/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HostingSpaceWidget extends StatefulWidget {
  const HostingSpaceWidget({super.key});

  @override
  HostingSpaceWidgetState createState() => HostingSpaceWidgetState();
}

class HostingSpaceWidgetState extends BaseState<HostingSpaceWidget> {
  bool hostingSpaceIndoor = false;
  bool hostingSpaceOutdoor = false;
  bool workspaceStyle = false;

  @override
  bool validate() {
    return hostingSpaceIndoor || hostingSpaceOutdoor;
  }

  @override
  String? getError() {
    return validate() ? null : 'please select workspace type';
  }

  @override
  dynamic getApiData() {
    return {
      'hostingSpaceIndoor': hostingSpaceIndoor,
      'hostingSpaceOutdoor': hostingSpaceOutdoor,
      'workspaceStyle': workspaceStyle,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          border: Border.all(
              color: Theme.of(context).primaryColor.withOpacity(.25))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.h.verticalSpace,
          Text(
            "hosting space*",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 24.spMin,
                ),
          ),
          16.h.verticalSpace,
          Row(
            children: [
              Checkbox(
                value: hostingSpaceIndoor,
                onChanged: (value) {
                  setState(
                      () => hostingSpaceIndoor = value ?? hostingSpaceIndoor);
                },
              ),
              Expanded(
                child: Text(
                  "indoor (ex: office, dining area, great room, etc.)",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: hostingSpaceOutdoor,
                onChanged: (value) {
                  setState(
                      () => hostingSpaceOutdoor = value ?? hostingSpaceOutdoor);
                },
              ),
              Expanded(
                child: Text(
                  "outdoor (ex: backyard, patio, terrace, homework, etc. )",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                ),
              ),
            ],
          ),
          16.h.verticalSpace,
          Text(
            "workspace style",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 24.spMin,
                ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: workspaceStyle,
                onChanged: (value) {
                  setState(() => workspaceStyle = value ?? workspaceStyle);
                },
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      """co-working workspaces would be shared by multiple people within the same date & time frame.""",
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                      style:
                          Theme.of(context).textTheme.titleMedium?.copyWith(),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '  •  ',
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(),
                        ),
                        Expanded(
                          child: Text(
                            """if not checked, then only one user can book the workspace for a date/time at a time. Its highly advised that this is checked so multiple people can take advantage of the workspace specially if coworking is offered.""",
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          16.h.verticalSpace,
        ],
      ),
    );
  }

  @override
  bool isIndoor() {
    return hostingSpaceIndoor;
  }

  @override
  bool isOutdoor() {
    return hostingSpaceOutdoor;
  }

  @override
  bool isWorkspaceStyle() {
    return workspaceStyle;
  }
}


