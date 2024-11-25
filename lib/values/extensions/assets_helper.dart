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

    // Helper function to add items conditionally
    void addItem(String day, DayTime? dayTime) {
      if (dayTime != null && dayTime.startTime != null && dayTime.endTime != null) {
        items.add({
          'title': '${formatDayTime(dayTime)} $day',
          'icon': Icons.watch_later,
        });
      }
    }

    // Add items for each day
    addItem('Sunday', times?.sunday);
    addItem('Monday', times?.monday);
    addItem('Tuesday', times?.tuesday);
    addItem('Wednesday', times?.wednesday);
    addItem('Thursday', times?.thursday);
    addItem('Friday', times?.friday);
    addItem('Saturday', times?.saturday);

    return items;
  }

  static String formatDayTime(DayTime? dayTime) {
    if (dayTime == null || dayTime.startTime == null || dayTime.endTime == null) {
      return 'Closed';
    }
    return '${dayTime.startTime} - ${dayTime.endTime} EST';
  }
}


