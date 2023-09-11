import 'package:flutter/material.dart';

import '../../../../core/utils/category_colors.dart';

class CategoryColors {
  static final List<ColorPair> categoryPairs = [
    ColorPair(
      color: const Color(0xFF86C02F),
      darkColor: const Color(0xFF1A8400),
    ),
    ColorPair(
      color: const Color(0xFFFF9680),
      darkColor: const Color(0xFFA31D00),
    ),
    ColorPair(
      color: const Color(0xFF80FFD9),
      darkColor: const Color(0xFF00A372),
    ),
    ColorPair(
      color: const Color(0xFF809CFF),
      darkColor: const Color(0xFF0055A3),
    ),
    ColorPair(
      color: const Color(0xFFFF80EB),
      darkColor: const Color(0xFFA30089),
    ),
    ColorPair(
      color: const Color(0xFF80FFA3),
      darkColor: const Color(0xFF00A3A3),
    ),
    ColorPair(
      color: const Color(0xFF80D1FF),
      darkColor: const Color(0xFF0069A3),
    ),
    ColorPair(
      color: const Color(0xFFFFD180),
      darkColor: const Color(0xFFA37500),
    ),
    ColorPair(
      color: const Color(0xFFFF80B3),
      darkColor: const Color(0xFFA30055),
    ),
    ColorPair(
      color: const Color(0xFFD180FF),
      darkColor: const Color(0xFF6900A3),
    ),
    ColorPair(
      color: const Color(0xFFD1FF80),
      darkColor: const Color(0xFF69A300),
    ),
  ];

  static final List<IconData> categoryIcons = [
    Icons.design_services,
    Icons.code,
    Icons.meeting_room,
    Icons.shopping_cart,
    Icons.airplanemode_active,
    Icons.book,
    Icons.work,
    Icons.home,
    Icons.health_and_safety,
    Icons.fastfood,
    Icons.celebration,
    Icons.sports_basketball,
    Icons.music_note,
    Icons.movie,
    Icons.sports_esports,
    Icons.book,
    Icons.palette,
    Icons.more_horiz,
  ];
}

class Category {
  final String id;
  final String name;
  final int iconIndex; // Store the icon index
  final int colorIndex; // Store the color index

  Category({
    required this.id,
    required this.name,
    required this.iconIndex,
    required this.colorIndex,
  });

  // Create functions to handle the icon and color
  IconData get icon => CategoryColors.categoryIcons[iconIndex];
  ColorPair get categoryColor => CategoryColors.categoryPairs[colorIndex];
}
