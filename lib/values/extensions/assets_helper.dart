import 'package:balcony/data/model/response/workspace_data.dart';
import 'package:balcony/generated/assets.dart';
import 'package:flutter/material.dart';

class AssetHelper {
  static final Map<String, String> amenityAssetMap = {
    'commercial': Assets.imagesCommercial,
    'residential': Assets.imagesResidential,
    'co-workspace, office': Assets.imagesHome,
    'chairs': Assets.imagesTable1,
    'wi-fi': Assets.imagesWifi,
    'conference room': Assets.imagesHome,
    'tv / television, presentation': Assets.imagesGalaTv,
    'printer': Assets.imagesPrinter,
    'terrace': Assets.imagesStays,
    'break room, cafe': Assets.imagesCoffee,
    'natural light': Assets.imagesCoffee,
    'waterfront views': Assets.imagesCoffee,
    'landscape views': Assets.imagesCoffee,
  };

  static String getAssetForAmenity(String amenity) {
    String normalizedAmenity = amenity.toLowerCase().trim();
    return amenityAssetMap[normalizedAmenity] ?? Assets.imagesCommercial;
  }
}


class TimesHelper {
  static List<Map<String, dynamic>> mapTimesToDropdownItems(Times? times) {
    final List<Map<String, dynamic>> items = [];
    if (times?.sunday != null) {
      items.add({
        'title': '${formatDayTime(times?.sunday)} Sunday',
        'icon': Icons.watch_later,
      });
    }
    if (times?.monday != null) {
      items.add({
        'title': '${formatDayTime(times?.monday)} Monday',
        'icon': Icons.watch_later,
      });
    }
    if (times?.tuesday != null) {
      items.add({
        'title': '${formatDayTime(times?.tuesday)} Tuesday',
        'icon': Icons.watch_later,
      });
    }
    if (times?.wednesday != null) {
      items.add({
        'title': '${formatDayTime(times?.wednesday)} Wednesday',
        'icon': Icons.watch_later,
      });
    }
    if (times?.thursday != null) {
      items.add({
        'title': '${formatDayTime(times?.thursday)} Thursday',
        'icon': Icons.watch_later,
      });
    }
    if (times?.friday != null) {
      items.add({
        'title': '${formatDayTime(times?.friday)} Friday',
        'icon': Icons.watch_later,
      });
    }
    if (times?.saturday != null) {
      items.add({
        'title': '${formatDayTime(times?.saturday)} Saturday',
        'icon': Icons.watch_later,
      });
    }

    return items;
  }

  static String formatDayTime(DayTime? dayTime) {
    if (dayTime == null || dayTime.startTime == null || dayTime.endTime == null) {
      return 'Closed';
    }
    return '${dayTime.startTime} - ${dayTime.endTime} EST';
  }
}

