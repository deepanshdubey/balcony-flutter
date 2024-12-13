import 'dart:io';
import 'dart:ui';

import 'package:homework/values/extensions/int_ext.dart';
import 'package:homework/widget/app_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppImage extends StatefulWidget {
  final String? url;
  final String? file;
  final String? assetPath;
  final String? initial;
  final double radius;
  final Color? backgroundColor;
  final Color? color;
  final Color borderColor;
  final double borderWidth;
  final TextStyle? textStyle;
  final double? height;
  final double? width;
  final double? roundedCorner;
  final Widget? placeholder;
  final BoxFit? boxFit;
  final Alignment alignment;
  final bool shouldCache;

  const AppImage({
    this.url,
    this.boxFit,
    this.file,
    this.height,
    this.width,
    this.assetPath,
    this.initial,
    this.radius = 1,
    this.placeholder,
    this.roundedCorner,
    this.backgroundColor,
    this.borderColor = Colors.transparent,
    this.borderWidth = 3.0,
    this.textStyle,
    this.alignment = Alignment.center,
    super.key,
    this.color,
    this.shouldCache = true,
  });

  @override
  State<AppImage> createState() => _AppImageState();
}

class _AppImageState extends State<AppImage> {
  @override
  Widget build(BuildContext context) {
    final double imageHeight = widget.height ?? widget.radius * 2;
    final double imageWidth = widget.width ?? widget.radius * 2;

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
      child: buildImage(imageHeight, imageWidth),
    );
  }

  Widget buildImage(double height, double width) {
    if (widget.url != null) {
      if (widget.shouldCache) {
        return CachedNetworkImage(
          imageUrl: !widget.url!.startsWith("http")
              ? "https://runners.ticketlab.com${widget.url}"
              : widget.url!,
          height: height,
          width: width,
          alignment: widget.alignment,
          fit: widget.boxFit ?? BoxFit.cover,
          placeholder: (context, url) => buildImageWithBlurEffect(),
          errorWidget: (context, url, error) => buildInitialPlaceholder(),
          imageBuilder: (context, imageProvider) =>
              buildImageWithBlurEffect(imageProvider),
        );
      } else {
        return Image.network(
          !widget.url!.startsWith("http")
              ? "https://runners.ticketlab.com${widget.url}"
              : widget.url!,
          height: height,
          width: width,
          alignment: widget.alignment,
          fit: widget.boxFit ?? BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return buildImageWithBlurEffect();
          },
          errorBuilder: (context, error, stackTrace) =>
              buildInitialPlaceholder(),
        );
      }
    } else if (widget.file != null) {
      return Image.file(
        File(widget.file!),
        fit: widget.boxFit,
        height: height,
        width: width,
        alignment: widget.alignment,
      );
    } else if (widget.assetPath != null) {
      return Image.asset(
        widget.assetPath!,
        fit: widget.boxFit ?? BoxFit.scaleDown,
        height: height,
        width: width,
        alignment: widget.alignment,
        color: widget.color,
      );
    } else {
      return buildInitialPlaceholder();
    }
  }

  Widget buildImageWithBlurEffect([ImageProvider? imageProvider]) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 10, end: 0),
      // Start with blur and end with no blur
      duration: 400.milliseconds,
      builder: (context, value, child) {
        return ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: value, sigmaY: value),
          child: imageProvider != null
              ? Image(
                  image: imageProvider,
                  fit: widget.boxFit ?? BoxFit.cover,
                  height: widget.height,
                  width: widget.width,
                  alignment: widget.alignment,
                )
              : buildInitialPlaceholder(),
        );
      },
    );
  }

  Widget buildInitialPlaceholder() {
    return Container(
      height: widget.radius * 2,
      width: widget.radius * 2,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(widget.radius),
        ).r,
        border: Border.all(
          width: widget.borderWidth,
          color: widget.borderColor,
        ),
      ),
      child: const Center(child: AppLoader()),
    );
  }

  String getInitialText() {
    if (widget.initial == null || widget.initial!.isEmpty) {
      return "A";
    }
    return widget.initial![0];
  }
}
