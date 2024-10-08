import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyRecentActivityLoadingIndicator extends StatelessWidget {
  const MyRecentActivityLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
      child: Row(
        children: [
          Shimmer.fromColors(
            baseColor: const Color(0x1A3B3B3B),
            highlightColor: Colors.white.withOpacity(0.3),
            child: const CircleAvatar(
              radius: 28,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                      baseColor: const Color(0x1A3B3B3B),
                      highlightColor: Colors.white.withOpacity(0.3),
                      child: Container(
                        width: 150,
                        height: 15,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: const Color(0x1A3B3B3B),
                      highlightColor: Colors.white.withOpacity(0.3),
                      child: Container(
                        width: 50,
                        height: 15,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Shimmer.fromColors(
                  baseColor: const Color(0x1A3B3B3B),
                  highlightColor: Colors.white.withOpacity(0.3),
                  child: Container(
                    width: 100,
                    height: 15,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
