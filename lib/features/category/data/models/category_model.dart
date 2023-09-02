// category_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/category.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
class CategoryModel extends Category with _$CategoryModel {
  const factory CategoryModel({
    required String id,
    required String name,
    required String color, // Store color as a hex string
    required String icon, // Store icon name or identifier
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}
