import 'package:balcony/values/extensions/theme_ext.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  final bool? backgroundTransparent;
  final String? message;
  final bool? status;
  final Widget? child;

  const LoadingWidget(
      {super.key,
      this.status,
      this.child,
      this.message,
      this.backgroundTransparent});

  @override
  LoadingWidgetState createState() => LoadingWidgetState();
}

class LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.child!,
        _loading(widget.status!),
      ],
    );
  }

  Widget _loading(bool loading) {
    var theme = Theme.of(context);
    return loading == true
        ? Container(
            alignment: Alignment.center,
            color: widget.backgroundTransparent == true
                ? Colors.transparent
                : Theme.of(context).colors.primaryColor.withOpacity(.0),
            child: const CircularProgressIndicator(),
          )
        : Container();
  }
}
