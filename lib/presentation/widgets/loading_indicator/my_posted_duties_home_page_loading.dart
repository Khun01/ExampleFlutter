import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyPostedDutiesHomePageLoading extends StatelessWidget {
  const MyPostedDutiesHomePageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 128,
      padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.only(bottom: 16, left: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: const Color(0x1A3B3B3B),
                highlightColor: Colors.white.withOpacity(0.3),
                child: const CircleAvatar(
                  radius: 25,
                ),
              ),
              const Spacer(),
              Column(
                children: [
                  Shimmer.fromColors(
                    baseColor: const Color(0x4C3B3B3B),
                    highlightColor: Colors.white.withOpacity(0.3),
                    child: Container(
                      width: 64,
                      height: 24,
                      decoration: const BoxDecoration(
                          color: Color(0x4C3B3B3B),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(18),
                              bottomLeft: Radius.circular(18),
                              bottomRight: Radius.circular(5))),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Shimmer.fromColors(
                    baseColor: const Color(0x4C3B3B3B),
                    highlightColor: Colors.white.withOpacity(0.3),
                    child: Container(
                      width: 64,
                      height: 16,
                      decoration: BoxDecoration(
                          color: const Color(0x4C3B3B3B),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 8),
          Shimmer.fromColors(
            baseColor: const Color(0x4C3B3B3B),
            highlightColor: Colors.white.withOpacity(0.3),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: MediaQuery.of(context).size.width,
              height: 16,
              decoration: BoxDecoration(
                color: const Color(0x4C3B3B3B),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Shimmer.fromColors(
            baseColor: const Color(0x4C3B3B3B),
            highlightColor: Colors.white.withOpacity(0.3),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: MediaQuery.of(context).size.width * 0.25,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0x4C3B3B3B),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
