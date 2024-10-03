import 'dart:developer';
import 'dart:io';

import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/employee/comment/add/add_comment_bloc.dart';
import 'package:help_isko/presentation/bloc/employee/comment/fetch/fetch_comment_bloc.dart';
import 'package:help_isko/presentation/cards/comment_card.dart';
import 'package:help_isko/repositories/api_repositories.dart';
import 'package:help_isko/repositories/global.dart';
import 'package:ionicons/ionicons.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:uicons/uicons.dart';

class ReviewsStudent extends StatefulWidget {
  final String id;
  const ReviewsStudent({super.key, required this.id});

  @override
  State<ReviewsStudent> createState() => _ReviewsStudentState();
}

class _ReviewsStudentState extends State<ReviewsStudent> {
  final TextEditingController comment = TextEditingController();
  final GlobalKey<FormState> _formKeyComment = GlobalKey<FormState>();
  final scrollController = ScrollController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        log('The keyboard is open');
        Future.delayed(const Duration(milliseconds: 700), () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (scrollController.hasClients) {
              double scrollFactor = Platform.isAndroid ? 2.5 : 1.5;
              final position =
                  scrollController.position.maxScrollExtent * scrollFactor;
              scrollController.animateTo(position,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut);
            }
          });
        });
      } else {
        log('The keyboard is remove');
      }
    });
  }

  @override
  void dispose() {
    comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FetchCommentBloc fetchCommentBloc =
        FetchCommentBloc(apiRepositories: ApiRepositories(apiUrl: baseUrl))
          ..add(FetchCommentsEvent(id: widget.id));
    final AddCommentBloc addCommentBloc =
        AddCommentBloc(apiRepositories: ApiRepositories(apiUrl: baseUrl));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => addCommentBloc,
        ),
        BlocProvider(
          create: (context) => fetchCommentBloc,
        ),
      ],
      child: Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverLayoutBuilder(
                  builder: (BuildContext context, constraints) {
                    final scrolledFirst = constraints.scrollOffset > 0;
                    return SliverAppBar(
                      automaticallyImplyLeading: false,
                      expandedHeight: 426,
                      collapsedHeight: 272,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      flexibleSpace: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(
                            top: scrolledFirst ? 16 : 48,
                            left: 16,
                            right: 16,
                            bottom: 16),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                        5,
                                        (index) {
                                          return AnimatedSize(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
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
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: AnimatedDefaultTextStyle(
                                        style: GoogleFonts.nunito(
                                            fontSize: scrolledFirst ? 16 : 24,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xCC3B3B3B)),
                                        duration:
                                            const Duration(milliseconds: 300),
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
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: AnimatedDefaultTextStyle(
                                        style: GoogleFonts.nunito(
                                            fontSize: scrolledFirst ? 56 : 64,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xCC3B3B3B)),
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: const Text('4.3'),
                                      ),
                                    ),
                                  ),
                                  AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
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
                                          progressColor:
                                              const Color(0xFF6ABF69),
                                          backgroundColor:
                                              const Color(0xFFD9D9D9),
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
                                          progressColor:
                                              const Color(0xFFA3C79A),
                                          backgroundColor:
                                              const Color(0xFFD9D9D9),
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
                                          progressColor:
                                              const Color(0xFFD8D47F),
                                          backgroundColor:
                                              const Color(0xFFD9D9D9),
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
                                          progressColor:
                                              const Color(0xFFE3B878),
                                          backgroundColor:
                                              const Color(0xFFD9D9D9),
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
                                          progressColor:
                                              const Color(0xFFE08C85),
                                          backgroundColor:
                                              const Color(0xFFD9D9D9),
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
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, left: 16),
                    child: Text(
                      'Comments',
                      style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3B3B3B)),
                    ),
                  ),
                ),
                BlocConsumer<FetchCommentBloc, FetchCommentState>(
                  bloc: fetchCommentBloc,
                  listener: (context, state) {
                    if (state is FetchCommentFailedState) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.error)));
                    }
                  },
                  builder: (context, state) {
                    if (state is FetchCommentLoadingState) {
                      return const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state is FetchCommentSuccessState) {
                      if (state.comment.isEmpty) {
                        return SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: Text(
                              'You are the first to comment here',
                              style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF3B3B3B)),
                            ),
                          ),
                        );
                      } else {
                        final reversedComment = state.comment.reversed.toList();
                        return LiveSliverList(
                          controller: scrollController,
                          showItemDuration: const Duration(milliseconds: 300),
                          itemCount: reversedComment.length,
                          itemBuilder: (context, index, animation) {
                            final comment = reversedComment[index];
                            return FadeTransition(
                              opacity: Tween<double>(
                                begin: 0,
                                end: 1,
                              ).animate(animation),
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, -0.1),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: CommentCard(
                                  comment: comment.comment,
                                  firstName: comment.commenterFirstName,
                                  lastName: comment.commenterLastName,
                                  time: comment.formattedTime,
                                  profile: comment.commenterProfileImg,
                                ),
                              ),
                            );
                          },
                        );
                      }
                    } else if (state is FetchCommentFailedState) {
                      return SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text(
                            'Failed to load',
                            style: GoogleFonts.nunito(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF3B3B3B)),
                          ),
                        ),
                      );
                    } else {
                      return SliverToBoxAdapter(
                        child: Container(),
                      );
                    }
                  },
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 106),
                )
              ],
            ),
            BlocConsumer<AddCommentBloc, AddCommentState>(
              bloc: addCommentBloc,
              listener: (context, state) {},
              builder: (context, state) {
                return Positioned(
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
                              key: _formKeyComment,
                              child: TextFormField(
                                controller: comment,
                                focusNode: focusNode,
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
                              onTap: () {
                                final validatedComment =
                                    _formKeyComment.currentState!.validate();
                                if (validatedComment) {
                                  context.read<AddCommentBloc>().add(
                                        AddCommentClickedEvent(
                                          addComment: comment.text,
                                          studId: widget.id,
                                          context.read<FetchCommentBloc>(),
                                        ),
                                      );
                                  comment.clear();
                                }
                              },
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
