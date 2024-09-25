import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyAnnouncementLoadingIndicator extends StatelessWidget {
  const MyAnnouncementLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Shimmer.fromColors(
            baseColor: const Color(0x1A3B3B3B),
            highlightColor: Colors.white.withOpacity(0.3),
            child: const CircleAvatar(
              radius: 30,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Shimmer.fromColors(
                      baseColor: const Color(0x4C3B3B3B),
                      highlightColor: Colors.white.withOpacity(0.3),
                      child: Container(
                        height: 15,
                        decoration: BoxDecoration(
                            color: const Color(0x4C3B3B3B),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    )),
                    const SizedBox(width: 8),
                    Shimmer.fromColors(
                      baseColor: const Color(0x4C3B3B3B),
                      highlightColor: Colors.white.withOpacity(0.3),
                      child: Container(
                        height: 15,
                        width: 50,
                        decoration: BoxDecoration(
                            color: const Color(0x4C3B3B3B),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Shimmer.fromColors(
                  baseColor: const Color(0x4C3B3B3B),
                  highlightColor: Colors.white.withOpacity(0.3),
                  child: Container(
                    height: 15,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0x4C3B3B3B),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Shimmer.fromColors(
                  baseColor: const Color(0x4C3B3B3B),
                  highlightColor: Colors.white.withOpacity(0.3),
                  child: Container(
                    height: 15,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0x4C3B3B3B),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Shimmer.fromColors(
                  baseColor: const Color(0x4C3B3B3B),
                  highlightColor: Colors.white.withOpacity(0.3),
                  child: Container(
                    height: 15,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0x4C3B3B3B),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
