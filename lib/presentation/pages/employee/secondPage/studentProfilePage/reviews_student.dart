import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:uicons/uicons.dart';

class ReviewsStudent extends StatelessWidget {
  const ReviewsStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverLayoutBuilder(
                builder: (BuildContext context, constraints) {
                  final scrolledFirst = constraints.scrollOffset > 0;
                  return SliverAppBar(
                    automaticallyImplyLeading: false,
                    expandedHeight: 426,
                    collapsedHeight: 272,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    flexibleSpace: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(
                          top: scrolledFirst ? 16 : 48, left: 16, right: 16, bottom: 16),
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          border: const Border(
                              bottom: BorderSide(color: Color(0x1A3B3B3B)))),
                      child: SingleChildScrollView(
                        child: Stack(
                          children: [
                            AnimatedPositioned(
                              duration: const Duration(milliseconds: 300),
                              top: scrolledFirst ? 32 : 136,
                              left: scrolledFirst ? 16 : 0,
                              right: 0,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      5,
                                      (index) {
                                        return AnimatedSize(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 2),
                                            child: Icon(
                                              Ionicons.star_outline,
                                              color: Colors.amber,
                                              size: scrolledFirst ? 30 : 40,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AnimatedPositioned(
                              top: scrolledFirst ? 68 : 180,
                              left: scrolledFirst ? -20 : 0,
                              right: scrolledFirst ? 0 : 0,
                              duration: const Duration(milliseconds: 300),
                              child: Center(
                                child: Text(
                                  'Based on 23 reviews',
                                  style: GoogleFonts.nunito(
                                      fontSize: 12,
                                      color: const Color(0xCC3B3B3B)),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: AnimatedAlign(
                                    alignment: scrolledFirst
                                        ? Alignment.centerLeft
                                        : Alignment.topCenter,
                                    duration: const Duration(milliseconds: 300),
                                    child: AnimatedDefaultTextStyle(
                                      style: GoogleFonts.nunito(
                                          fontSize: scrolledFirst ? 16 : 24,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xCC3B3B3B)),
                                      duration: const Duration(milliseconds: 300),
                                      child: const Text('Overall Rating'),
                                    ),
                                  ),
                                ),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  padding: EdgeInsets.only(
                                      top: scrolledFirst ? 0 : 16),
                                  width: MediaQuery.of(context).size.width,
                                  child: AnimatedAlign(
                                    alignment: scrolledFirst
                                        ? Alignment.centerLeft
                                        : Alignment.topCenter,
                                    duration: const Duration(milliseconds: 300),
                                    child: AnimatedDefaultTextStyle(
                                      style: GoogleFonts.nunito(
                                          fontSize: scrolledFirst ? 56 : 64,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xCC3B3B3B)),
                                      duration: const Duration(milliseconds: 300),
                                      child: const Text('4.3'),
                                    ),
                                  ),
                                ),
                                AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    height: scrolledFirst ? 16 : 100),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Excellent',
                                        style: GoogleFonts.nunito(
                                            fontSize: 12,
                                            color: const Color(0x803B3B3B)),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      flex: 3,
                                      child: LinearPercentIndicator(
                                        lineHeight: 10,
                                        percent: 0.9,
                                        animation: true,
                                        animationDuration: 2000,
                                        progressColor: const Color(0xFF6ABF69),
                                        backgroundColor: const Color(0xFFD9D9D9),
                                        barRadius: const Radius.circular(20),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Good',
                                        style: GoogleFonts.nunito(
                                            fontSize: 12,
                                            color: const Color(0x803B3B3B)),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      flex: 3,
                                      child: LinearPercentIndicator(
                                        lineHeight: 10,
                                        percent: 0.7,
                                        animation: true,
                                        animationDuration: 2000,
                                        progressColor: const Color(0xFFA3C79A),
                                        backgroundColor: const Color(0xFFD9D9D9),
                                        barRadius: const Radius.circular(20),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Average',
                                        style: GoogleFonts.nunito(
                                            fontSize: 12,
                                            color: const Color(0x803B3B3B)),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      flex: 3,
                                      child: LinearPercentIndicator(
                                        lineHeight: 10,
                                        percent: 0.5,
                                        animation: true,
                                        animationDuration: 2000,
                                        progressColor: const Color(0xFFD8D47F),
                                        backgroundColor: const Color(0xFFD9D9D9),
                                        barRadius: const Radius.circular(20),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Below average',
                                        style: GoogleFonts.nunito(
                                            fontSize: 12,
                                            color: const Color(0x803B3B3B)),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      flex: 3,
                                      child: LinearPercentIndicator(
                                        lineHeight: 10,
                                        percent: 0.3,
                                        animation: true,
                                        animationDuration: 2000,
                                        progressColor: const Color(0xFFE3B878),
                                        backgroundColor: const Color(0xFFD9D9D9),
                                        barRadius: const Radius.circular(20),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Poor',
                                        style: GoogleFonts.nunito(
                                            fontSize: 12,
                                            color: const Color(0x803B3B3B)),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      flex: 3,
                                      child: LinearPercentIndicator(
                                        lineHeight: 10,
                                        percent: 0.1,
                                        animation: true,
                                        animationDuration: 2000,
                                        progressColor: const Color(0xFFE08C85),
                                        backgroundColor: const Color(0xFFD9D9D9),
                                        barRadius: const Radius.circular(20),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFCFCFC),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, -6),
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Form(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your message';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            fillColor: const Color(0x1A3B3B3B),
                            filled: true,
                            hintText: 'Send Message',
                            hintStyle: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              color: const Color(0x803B3B3B),
                            ),
                            prefixIcon: const Icon(Icons.comment),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0x1A3B3B3B),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          UIcons.solidRounded.paper_plane,
                          color: const Color(0xFF3B3B3B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
