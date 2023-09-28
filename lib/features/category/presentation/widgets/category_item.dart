import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../domain/entities/category.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: InkWell(
        onTap: () {
          context.push('/category/${category.id}');
        },
        child: Stack(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.12,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: category.categoryColor.darkColor.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Card(
                color: Colors.grey.shade100,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: BorderSide(
                    color: category.categoryColor.darkColor,
                    width: 1.4,
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: category.categoryColor.darkColor,
                                  width: 1,
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundColor: category.categoryColor.color,
                                child: Icon(
                                  category.icon,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Text(
                              category.name,
                              style: TextStyle(
                                color: category.categoryColor.darkColor
                                    .withOpacity(0.8),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '4 Pending Tasks',
                              style: TextStyle(
                                color: category.categoryColor.darkColor
                                    .withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '2 Completed Tasks',
                              style: TextStyle(
                                color: category.categoryColor.darkColor
                                    .withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
            Positioned(
              bottom: 0,
              right: MediaQuery.sizeOf(context).width * 0.1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: category.categoryColor.color,
                  boxShadow: [
                    BoxShadow(
                      color: category.categoryColor.darkColor.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const SizedBox(
                  height: 10,
                  width: 80,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerCategoryItemWidget extends StatelessWidget {
  const ShimmerCategoryItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!, // Shimmer base color
        highlightColor: Colors.grey[100]!, // Shimmer highlight color
        child: Card(
          color: Colors.white, // Background color for the card
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(
              color: Colors.grey, // Border color
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey[100], // Icon background color
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                SizedBox(
                  height: 16.0, // Height of the shimmering text
                  child: Container(
                    color: Colors.grey[100], // Text background color
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
