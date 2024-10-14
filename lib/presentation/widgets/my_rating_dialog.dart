import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/employee/comment/add/addRating/add_rating_bloc.dart';
import 'package:help_isko/presentation/bloc/employee/comment/fetch/fetchRating/fetch_rating_bloc.dart';

class MyRatingDialog extends StatefulWidget {
  final String id;
  const MyRatingDialog({super.key, required this.id});

  @override
  State<MyRatingDialog> createState() => _MyRatingDialogState();
}

class _MyRatingDialogState extends State<MyRatingDialog> {
  int selectedRate = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddRatingBloc, AddRatingState>(
      listener: (context, state) {
        if (state is AddRatingFailedState) {
          log('The error in rating student is: ${state.error}');
        } else if (state is AddRatingSuccessState) {
          Future.delayed(const Duration(milliseconds: 300), () {
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
            // ignore: use_build_context_synchronously
            context
                .read<FetchRatingBloc>()
                .add(FetchRatingsEvent(id: widget.id));
            // ignore: use_build_context_synchronously
            context.read<AddRatingBloc>().add(AddRatingResetEvent());
          });
        }
      },
      builder: (context, state) {
        return Dialog(
          backgroundColor: const Color(0xFFFCFCFC),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 180,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(26),
                        ),
                        child: Image.asset('assets/images/blob_bg.png',
                            fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(500),
                            border: Border.all(color: const Color(0x303B3B3B)),
                            color: const Color(0xFFFCFCFC),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(0.0, 10.0),
                                blurRadius: 10.0,
                                spreadRadius: -6.0,
                              )
                            ],
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(12),
                            child: Image.asset(
                              height: 70,
                              'assets/images/ratings_icon_image.png',
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    Text(
                      'How would you like to rate your experience with our student?',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3B3B3B),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedRate = index + 1;
                            });
                          },
                          child: Icon(
                            index < selectedRate
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,
                            size: 50,
                            color: const Color(0xFFFFD872),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                    state is AddRatingLoadingState
                        ? Center(
                            child: Container(
                              height: 45,
                              width: 45,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(500),
                                color: const Color(0xFF6BB577),
                              ),
                              child: const CircularProgressIndicator(
                                color: Color(0xFFFCFCFC),
                                strokeWidth: 3,
                              ),
                            ),
                          )
                        : state is AddRatingSuccessState
                            ? Center(
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(500),
                                    color: const Color(0xFF6BB577),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.check_rounded,
                                      size: 30,
                                      color: Color(0xFFFCFCFC),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF6BB577),
                                      elevation: 8),
                                  onPressed: () {
                                    context.read<AddRatingBloc>().add(
                                          AddRatingClickedEvent(
                                              addRating: selectedRate,
                                              studId: widget.id),
                                        );
                                  },
                                  child: Text(
                                    'Confirm',
                                    style: GoogleFonts.nunito(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFFFCFCFC)),
                                  ),
                                ),
                              ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'No, Thanks!',
                        style: GoogleFonts.nunito(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0x803B3B3B)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
