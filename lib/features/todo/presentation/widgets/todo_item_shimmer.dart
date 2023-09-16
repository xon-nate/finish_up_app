import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TodoItemShimmer extends StatelessWidget {
  const TodoItemShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF006ED4).withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                border: Border.all(
                  color: const Color(0xFF006ED4),
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {},
                  tileColor: Colors.transparent,
                  trailing: const Icon(
                    Icons.check_box_outline_blank_outlined,
                    size: 30,
                    color: Color(0xFF7B8088),
                  ),
                  title: Container(
                    width: 60, // Adjust the width as needed
                    height: 20,
                    color: Colors.white,
                  ),
                  subtitle: Container(
                    width: 120, // Adjust the width as needed
                    height: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -10,
              right: MediaQuery.of(context).size.width * 0.05,
              child: Padding(
                padding: const EdgeInsets.all(4.0), // Add some spacing here
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Adjust the color as needed
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 2,
                          offset: Offset(0, 0),
                          color: Colors.black12,
                          spreadRadius: 1,
                        ),
                      ],
                      border: Border.all(
                        color: Colors.grey[300]!, // Adjust the color as needed
                        width: 1.6,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: Container(
                      width: 100, // Adjust the width as needed
                      height: 20, // Adjust the height as needed
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
