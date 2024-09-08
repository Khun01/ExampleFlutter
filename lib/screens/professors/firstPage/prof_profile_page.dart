import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfProfilePage extends StatelessWidget {
  const ProfProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverLayoutBuilder(
              builder: (BuildContext context, constraints){
                final scrolled = constraints.scrollOffset > 50;
                return SliverAppBar(
                  pinned: true,
                  automaticallyImplyLeading: false,
                  expandedHeight: 250,
                  collapsedHeight: 65,
                  backgroundColor: const Color(0xFF6BB577),
                  flexibleSpace: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 250,
                    decoration: BoxDecoration(
                      color: scrolled ? Theme.of(context).scaffoldBackgroundColor : const Color(0xFF6BB577),
                      boxShadow: scrolled ? [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(0.0, 10.0),
                            blurRadius: 10.0,
                            spreadRadius: -6.0
                        )
                      ] : []
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 300),
                          left: scrolled ? 15 : 0,
                          bottom: scrolled ? 15 : 0,
                          child: AnimatedContainer(
                            height: scrolled ? 35 : 310,
                            width: scrolled ? 35 : MediaQuery.of(context).size.width,
                            duration: const Duration(milliseconds: 300),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(scrolled ? 550 : 0),
                                    image:  const DecorationImage(
                                      image: AssetImage('images/luffy.jpeg'),
                                      fit: BoxFit.cover
                                    ),
                                  )
                                ),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(scrolled ? 550 : 0),
                                    color: Colors.black.withOpacity(0.2)
                                  )
                                ),
                              ],
                            ),
                          ),
                        ),
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 500),
                          bottom: 15,
                          left: scrolled ? 65 : 15,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 500),
                                style: GoogleFonts.nunito(
                                  fontSize: scrolled ? 16 : 20,
                                  fontWeight: FontWeight.bold,
                                  color: scrolled ? const Color(0xFF3B3B3B) : const Color(0xFFFCFCFC)
                                ),
                                child: const Text(
                                  'John Brandon lambino'
                                ),
                              ),
                              AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 500),
                                style: GoogleFonts.nunito(
                                  fontSize: scrolled ? 11 : 14,
                                  color: scrolled ? const Color(0xCC3B3B3B) : const Color(0xCCFCFCFC)
                                ),
                                child: const Text(
                                  '01-3245-678910'
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          right: 15,
                          bottom: -30,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 500),
                                opacity: scrolled ? 0 : 1,
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF6BB577),
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: const Color(0xFFFCFCFC), width: 2)
                                  ),
                                ),
                              ),
                              AnimatedPositioned(
                                duration: const Duration(milliseconds: 500),
                                top: scrolled ? -55 : 10,
                                bottom: 10,
                                left: 10,
                                right: scrolled ? -35 : 10,
                                child: Icon(
                                  Icons.camera,
                                  size: scrolled ? 25 : 30,
                                  color: scrolled ? const Color(0xFF3B3B3B) : const Color(0xFFFCFCFC),
                                ),
                              )
                            ],
                          ), 
                        ),
                        Positioned(
                          top: 15,
                          left: 15,
                          right: 15,
                          child: AnimatedOpacity(
                            opacity: scrolled ? 0 : 1,
                            duration: const Duration(milliseconds: 300),
                            child: Row(
                              children: [
                                Text(
                                  'My Profile',
                                  style: GoogleFonts.nunito(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFFCFCFC)
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.only(top: 8, left: 15, right: 15),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Campus',
                      style: GoogleFonts.nunito(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: const Color(0x803B3B3B)
                      ),
                    ),
                    Text(
                      'Dagupan Campus',
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3B3B3B)
                      ),
                    ),
                    const Divider(color: Color(0x303B3B3B)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Course',
                              style: GoogleFonts.nunito(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: const Color(0x803B3B3B)
                              ),
                            ),
                            Text(
                              'Bachelor of\nScience-Information\nTechnology',
                              style: GoogleFonts.nunito(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF3B3B3B)
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Course',
                              style: GoogleFonts.nunito(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: const Color(0x803B3B3B)
                              ),
                            ),
                            Text(
                              'FLEX',
                              style: GoogleFonts.nunito(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF3B3B3B)
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const Divider(color: Color(0x303B3B3B)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Curriculum',
                              style: GoogleFonts.nunito(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: const Color(0x803B3B3B)
                              ),
                            ),
                            Text(
                              'CITE - Bachelor of\nScience in Information\nTechnology in Systems\nDevelopment 22 - 23',
                              style: GoogleFonts.nunito(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF3B3B3B)
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Semester',
                              style: GoogleFonts.nunito(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: const Color(0x803B3B3B)
                              ),
                            ),
                            Text(
                              'Y3S1',
                              style: GoogleFonts.nunito(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF3B3B3B)
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 125),
            ),
          ],
        ),
      ),
    );
  }
}