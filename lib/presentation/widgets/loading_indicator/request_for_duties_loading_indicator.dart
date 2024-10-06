import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RequestForDutiesLoadingIndicator extends StatelessWidget {
  const RequestForDutiesLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x1A3B3B3B)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: const Color(0x1A3B3B3B),
                highlightColor: Colors.white.withOpacity(0.3),
                child: const CircleAvatar(
                  radius: 35,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: const Color(0x1A3B3B3B),
                    highlightColor: Colors.white.withOpacity(0.3),
                    child: Container(
                      height: 10,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Shimmer.fromColors(
                    baseColor: const Color(0x1A3B3B3B),
                    highlightColor: Colors.white.withOpacity(0.3),
                    child: Container(
                      height: 10,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          Shimmer.fromColors(
            baseColor: const Color(0x1A3B3B3B),
            highlightColor: Colors.white.withOpacity(0.3),
            child: Container(
              height: 10,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(20)),
            ),
          ),
          const SizedBox(height: 8),
          Shimmer.fromColors(
            baseColor: const Color(0x1A3B3B3B),
            highlightColor: Colors.white.withOpacity(0.3),
            child: Container(
              height: 10,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(20)),
            ),
          ),
          const SizedBox(height: 16),
          Shimmer.fromColors(
            baseColor: const Color(0x1A3B3B3B),
            highlightColor: Colors.white.withOpacity(0.3),
            child: Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(20)),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: const Color(0x1A3B3B3B),
                  highlightColor: Colors.white.withOpacity(0.3),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: const Color(0x1A3B3B3B),
                  highlightColor: Colors.white.withOpacity(0.3),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
