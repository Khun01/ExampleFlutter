import 'dart:developer';
import 'dart:io';

import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/employee/comment/add/addComment/add_comment_bloc.dart';
import 'package:help_isko/presentation/bloc/employee/comment/add/addRating/add_rating_bloc.dart';
import 'package:help_isko/presentation/bloc/employee/comment/fetch/fetchComment/fetch_comment_bloc.dart';
import 'package:help_isko/presentation/bloc/employee/comment/fetch/fetchRating/fetch_rating_bloc.dart';
import 'package:help_isko/presentation/cards/comment_card.dart';
import 'package:help_isko/presentation/widgets/my_rating_dialog.dart';
import 'package:help_isko/repositories/global.dart';
import 'package:help_isko/services/employee/comment_services.dart';
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
    final AddRatingBloc addRatingBloc =
        AddRatingBloc(commentRepository: CommentServices(baseUrl: baseUrl));
    final FetchRatingBloc fetchRatingBloc =
        FetchRatingBloc(commentRepository: CommentServices(baseUrl: baseUrl))
          ..add(FetchRatingsEvent(id: widget.id));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FetchCommentBloc(
              commentRepository: CommentServices(baseUrl: baseUrl))
            ..add(FetchCommentsEvent(id: widget.id)),
        ),
        BlocProvider(
          create: (context) => AddCommentBloc(
              commentRepository: CommentServices(baseUrl: baseUrl),
              fetchCommentBloc: context.read<FetchCommentBloc>()),
        ),
        BlocProvider(create: (context) => addRatingBloc),
        BlocProvider(create: (context) => fetchRatingBloc),
      ],
      child: Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              controller: scrollController,
              slivers: [
                BlocConsumer<FetchRatingBloc, FetchRatingState>(
                  listener: (context, state) {
                    if (state is FetchRatingFailedState) {
                      log('The error in fetching rating is: ${state.error}');
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.error)));
                    }
                  },
                  builder: (context, state) {
                    if (state is FetchRatingFailedState) {
                      return SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text(
                            'Network Error',
                            style: GoogleFonts.nunito(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF3B3B3B)),
                          ),
                        ),
                      );
                    } else if (state is FetchRatingSuccessState) {
                      return SliverLayoutBuilder(
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
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  border: const Border(
                                      bottom: BorderSide(
                                          color: Color(0x1A3B3B3B)))),
                              child: SingleChildScrollView(
                                child: Stack(
                                  children: [
                                    AnimatedPositioned(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      top: scrolledFirst ? 32 : 136,
                                      left: scrolledFirst ? 70 : 0,
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
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 2),
                                                    child: Builder(
                                                      builder: (context) {
                                                        if (index ==
                                                                state.rating
                                                                    .averageRating
                                                                    ?.floor() &&
                                                            state.rating
                                                                    .averageRating !=
                                                                null &&
                                                            state.rating.averageRating! %
                                                                    1 !=
                                                                0) {
                                                          return Icon(
                                                            Icons
                                                                .star_half_rounded,
                                                            color: Colors.amber,
                                                            size: scrolledFirst
                                                                ? 40
                                                                : 50,
                                                          );
                                                        } else {
                                                          return Icon(
                                                            index.toDouble() <
                                                                    (state.rating
                                                                            .averageRating ??
                                                                        0.0)
                                                                ? Icons
                                                                    .star_rounded
                                                                : Icons
                                                                    .star_border_rounded,
                                                            color: Colors.amber,
                                                            size: scrolledFirst
                                                                ? 40
                                                                : 50,
                                                          );
                                                        }
                                                      },
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
                                      top: scrolledFirst ? 68 : 190,
                                      left: scrolledFirst ? -20 : 0,
                                      right: scrolledFirst ? 0 : 0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Center(
                                        child: Text(
                                          'Based on ${state.rating.totalUser ?? 0} reviews',
                                          style: GoogleFonts.nunito(
                                              fontSize: 12,
                                              color: const Color(0xCC3B3B3B)),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: AnimatedAlign(
                                            alignment: scrolledFirst
                                                ? Alignment.centerLeft
                                                : Alignment.topCenter,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            child: AnimatedDefaultTextStyle(
                                              style: GoogleFonts.nunito(
                                                  fontSize:
                                                      scrolledFirst ? 16 : 24,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      const Color(0xCC3B3B3B)),
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              child:
                                                  const Text('Overall Rating'),
                                            ),
                                          ),
                                        ),
                                        AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          padding: EdgeInsets.only(
                                              top: scrolledFirst ? 0 : 16),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: AnimatedAlign(
                                            alignment: scrolledFirst
                                                ? Alignment.centerLeft
                                                : Alignment.topCenter,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            child: AnimatedDefaultTextStyle(
                                              style: GoogleFonts.nunito(
                                                  fontSize:
                                                      scrolledFirst ? 56 : 64,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      const Color(0xCC3B3B3B)),
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              child: Text(
                                                  '${state.rating.averageRating}'),
                                            ),
                                          ),
                                        ),
                                        AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            height: scrolledFirst ? 16 : 100),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Excellent',
                                                style: GoogleFonts.nunito(
                                                    fontSize: 12,
                                                    color: const Color(
                                                        0x803B3B3B)),
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              flex: 3,
                                              child: LinearPercentIndicator(
                                                lineHeight: 10,
                                                percent:
                                                    (state.rating.excellent ??
                                                            0.0) /
                                                        100,
                                                animation: true,
                                                animationDuration: 2000,
                                                progressColor:
                                                    const Color(0xFF6ABF69),
                                                backgroundColor:
                                                    const Color(0xFFD9D9D9),
                                                barRadius:
                                                    const Radius.circular(20),
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
                                                    color: const Color(
                                                        0x803B3B3B)),
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              flex: 3,
                                              child: LinearPercentIndicator(
                                                lineHeight: 10,
                                                percent:
                                                    (state.rating.good ?? 0.0) /
                                                        100,
                                                animation: true,
                                                animationDuration: 2000,
                                                progressColor:
                                                    const Color(0xFFA3C79A),
                                                backgroundColor:
                                                    const Color(0xFFD9D9D9),
                                                barRadius:
                                                    const Radius.circular(20),
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
                                                    color: const Color(
                                                        0x803B3B3B)),
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              flex: 3,
                                              child: LinearPercentIndicator(
                                                lineHeight: 10,
                                                percent:
                                                    (state.rating.average ??
                                                            0.0) /
                                                        100,
                                                animation: true,
                                                animationDuration: 2000,
                                                progressColor:
                                                    const Color(0xFFD8D47F),
                                                backgroundColor:
                                                    const Color(0xFFD9D9D9),
                                                barRadius:
                                                    const Radius.circular(20),
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
                                                    color: const Color(
                                                        0x803B3B3B)),
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              flex: 3,
                                              child: LinearPercentIndicator(
                                                lineHeight: 10,
                                                percent: (state.rating
                                                            .belowAverage ??
                                                        0.0) /
                                                    100,
                                                animation: true,
                                                animationDuration: 2000,
                                                progressColor:
                                                    const Color(0xFFE3B878),
                                                backgroundColor:
                                                    const Color(0xFFD9D9D9),
                                                barRadius:
                                                    const Radius.circular(20),
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
                                                    color: const Color(
                                                        0x803B3B3B)),
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              flex: 3,
                                              child: LinearPercentIndicator(
                                                lineHeight: 10,
                                                percent:
                                                    (state.rating.poor ?? 0.0) /
                                                        100,
                                                animation: true,
                                                animationDuration: 2000,
                                                progressColor:
                                                    const Color(0xFFE08C85),
                                                backgroundColor:
                                                    const Color(0xFFD9D9D9),
                                                barRadius:
                                                    const Radius.circular(20),
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
                      );
                    } else if (state is FetchRatingLoadingState) {
                      return const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else {
                      return const SliverToBoxAdapter(
                        child: SizedBox.shrink(),
                      );
                    }
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
                  listener: (context, state) {
                    if (state is FetchCommentFailedState) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.error)));
                    }
                  },
                  buildWhen: (previous, current) =>
                      current is FetchCommentSuccessState,
                  builder: (context, state) {
                    log('The state is: $state');
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
                        return LiveSliverList(
                          controller: scrollController,
                          showItemDuration: const Duration(milliseconds: 300),
                          itemCount: state.comment.length,
                          itemBuilder: (context, index, animation) {
                            final comment = state.comment[index];
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
                                  comment: comment.comment ?? '',
                                  firstName: comment.commenterFirstName!,
                                  lastName: comment.commenterLastName!,
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
            Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: addRatingBloc,
                        ),
                        BlocProvider.value(
                          value: fetchRatingBloc,
                        ),
                      ],
                      child: MyRatingDialog(id: widget.id),
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFCFCFC),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0x303B3B3B)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(0.0, 10.0),
                        blurRadius: 10.0,
                        spreadRadius: -6.0,
                      )
                    ],
                  ),
                  child: const Icon(
                    Icons.star_rounded,
                    size: 35,
                    color: Color(0xFFFFD872),
                  ),
                ),
              ),
            ),
            BlocConsumer<AddCommentBloc, AddCommentState>(
              listenWhen: (previous, current) =>
                  current is AddCommentSuccessState ||
                  current is AddCommentLoadingState,
              listener: (context, state) {
                if (state is AddCommentSuccessState) {
                  context
                      .read<FetchCommentBloc>()
                      .add(FetchCommentsEvent(id: widget.id));
                  Future.delayed(const Duration(milliseconds: 300), () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (scrollController.hasClients) {
                        double scrollFactor = Platform.isAndroid ? 2.5 : 1.5;
                        final position =
                            scrollController.position.maxScrollExtent *
                                scrollFactor;
                        scrollController.animateTo(position,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeInOut);
                      }
                    });
                  });
                }
              },
              buildWhen: (previous, current) =>
                  current is AddCommentSuccessState ||
                  current is AddCommentLoadingState,
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
