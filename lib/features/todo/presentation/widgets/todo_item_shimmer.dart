import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TodoItemShimmer extends StatelessWidget {
  const TodoItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFF006ED4),
                width: 2,
              ),
              color: const Color(0xFFD6EBFF),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {},
                tileColor: Colors.transparent,
                trailing: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: const Icon(
                    Icons.check_box,
                    size: 30,
                    color: Color(0xFF006ED4),
                  ),
                ),
                title: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.grey[300]!,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                subtitle: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.grey[300]!,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -10,
          right: MediaQuery.of(context).size.width * 0.05,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300]!,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
