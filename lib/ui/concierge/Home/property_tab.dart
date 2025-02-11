import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/ui/concierge/store/concierge_store.dart';
import 'package:homework/values/extensions/theme_ext.dart';
import 'package:mobx/mobx.dart';

class PropertyTab extends StatefulWidget {
  const PropertyTab({Key? key}) : super(key: key);

  @override
  _PropertyTabState createState() => _PropertyTabState();
}

class _PropertyTabState extends State<PropertyTab> {
  int currentIndex = 0;
  final conciergeStore = ConciergeStore();
  List<ReactionDisposer>? disposers;
  List<String?>? propertyNames;

  void _incrementIndex() {
    if (currentIndex < propertyNames!.length - 2) {
      setState(() {
        currentIndex++;
      });
    }
  }

  void _decrementIndex() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  @override
  void initState() {
    addDisposer();
    conciergeStore.conciergePropertyAll();
    super.initState();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => conciergeStore.conciergePropertyResponse, (response) {
        propertyNames = response?.properties?.leasingProperties
            ?.map((property) => property.name)
            .toList();
        setState(() {});
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
    if (propertyNames == null) {
      // Loading state: show CircularProgressIndicator
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (propertyNames!.isEmpty) {
      // Empty state: show a placeholder Container
      return Center(
        child: Container(
          width: 1.sw,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12).r,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Text(
            "No properties available",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 14.spMin,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      // Data loaded: show the main UI
      return Container(
        width: 1.sw,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12).r,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: currentIndex > 0 ? _decrementIndex : null,
              icon: Icon(Icons.arrow_back),
              color: currentIndex > 0
                  ? Theme.of(context).colors.primaryColor
                  : Colors.grey,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            Spacer(),
            Text(
              propertyNames?[currentIndex] ?? "Null",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 14.spMin,
                fontWeight: FontWeight.w500,
              ),
            ),
            10.horizontalSpace,
            if (propertyNames!.length > 1)
              Container(
                height: 15.h,
                width: 1.5.w,
                color: Colors.black,
              ),
            if (propertyNames!.length > 1) 10.horizontalSpace,
            if (propertyNames!.length > 1)
              Text(
                propertyNames?[currentIndex + 1] ?? "",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 14.spMin,
                  fontWeight: FontWeight.w500,
                ),
              ),
            Spacer(),
            IconButton(
              onPressed: currentIndex < propertyNames!.length - 2
                  ? _incrementIndex
                  : null,
              icon: Icon(Icons.arrow_forward),
              color: currentIndex < propertyNames!.length - 2
                  ? Theme.of(context).colors.primaryColor
                  : Colors.grey,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
          ],
        ),
      );
    }
  }

}
