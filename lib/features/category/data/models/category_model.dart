// category_model.dart
// import 'package:finish_up_app/core/utils/category_colors.dart';
// import 'package:flutter/material.dart';

import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel(
      {required super.id,
      required super.name,
      required super.iconIndex,
      required super.colorIndex});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'iconIndex': iconIndex, // Store the icon index
        'colorIndex': colorIndex, // Store the color index
      };

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'] as String,
        name: json['name'] as String,
        iconIndex: json['iconIndex'] as int, // Retrieve the icon index
        colorIndex: json['colorIndex'] as int, // Retrieve the color index
      );
  //create toMap func
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'iconIndex': iconIndex,
      'colorIndex': colorIndex,
    };
  }
}

// final Map<String, IconData> iconMap = {
  // 'design': Icons.design_services,
  // 'code': Icons.code,
  // 'meeting': Icons.meeting_room,
  // 'shopping': Icons.shopping_cart,
  // 'travel': Icons.airplanemode_active,
  // 'study': Icons.book,
  // 'work': Icons.work,
  // 'home': Icons.home,
  // 'health': Icons.health_and_safety,
  // 'food': Icons.fastfood,
  // 'party': Icons.celebration,
  // 'sport': Icons.sports_basketball,
  // 'music': Icons.music_note,
  // 'movie': Icons.movie,
  // 'game': Icons.sports_esports,
  // 'book': Icons.book,
  // 'art': Icons.palette,
  // 'other': Icons.more_horiz,
// };