import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:help_isko/presentation/bloc/shared/notification/notification_bloc.dart';
import 'package:help_isko/presentation/cards/shared/notification_card.dart';
import 'package:help_isko/presentation/widgets/loading_indicator/my_posted_duties_see_all_loading_indicator.dart';
import 'package:help_isko/repositories/api_repositories.dart';
import 'package:help_isko/repositories/global.dart';
import 'package:ionicons/ionicons.dart';

class NotificationPage extends StatelessWidget {
  final String role;
  const NotificationPage({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final NotificationBloc notificationBloc =
        NotificationBloc(apiRepositories: ApiRepositories(apiUrl: baseUrl))
          ..add(FetchNotification(role: role));
    return BlocConsumer<NotificationBloc, NotificationState>(
      bloc: notificationBloc,
      listener: (context, state) {
        if (state is NotificationFailedState) {
          log('The error in notif is: ${state.error}');
        } else if (state is NotificationSuccessState) {
          log('The notif fetching is success');
        }
      },
      builder: (context, state) {
        List<Widget> slivers = [];

        if (state is NotificationLoadingState) {
          slivers.add(
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return const MyPostedDutiesSeeAllLoadingIndicator();
              }, childCount: 15),
            ),
          );
        } else if (state is NotificationSuccessState) {
          if (state.today.isNotEmpty) {
            slivers.add(
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  child: Text(
                    'Today',
                    style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3B3B3B)),
                  ),
                ),
              ),
            );
            slivers.add(
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final notification = state.today[index];
                    return NotificationCard(
                      title: notification.title,
                      message: notification.message,
                      date: notification.date,
                    );
                  },
                  childCount: state.today.length,
                ),
              ),
            );
          }
          if (state.yesterday.isNotEmpty) {
            slivers.add(
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  child: Text(
                    'Yesterday',
                    style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3B3B3B)),
                  ),
                ),
              ),
            );
            slivers.add(
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final notification = state.yesterday[index];
                    return NotificationCard(
                      title: notification.title,
                      message: notification.message,
                      date: notification.date,
                    );
                  },
                  childCount: state.yesterday.length,
                ),
              ),
            );
          }
          if (state.byDate.isNotEmpty) {
            slivers.add(
              const SliverToBoxAdapter(),
            );
            slivers.addAll(
              state.byDate.entries.map((entry) {
                final dateKey = entry.key;
                final notifications = entry.value;
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 8),
                          child: Text(
                            dateKey,
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3B3B3B),
                            ),
                          ),
                        );
                      } else {
                        final notificationIndex = index - 1;
                        if (notificationIndex < notifications.length) {
                          final notification = notifications[notificationIndex];
                          return NotificationCard(
                            title: notification.title,
                            message: notification.message,
                            date: notification.date,
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }
                    },
                    childCount: notifications.length + 1,
                  ),
                );
              }).toList(),
            );
          }
        } else if (state is NotificationFailedState) {
          slivers.add(
            SliverToBoxAdapter(
              child: Center(
                child: Text('Error: ${state.error}'),
              ),
            ),
          );
        }

        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverLayoutBuilder(
                  builder: (context, constraints) {
                    final scrolled = constraints.scrollOffset > 0;
                    return SliverAppBar(
                      pinned: true,
                      automaticallyImplyLeading: false,
                      collapsedHeight: 70,
                      flexibleSpace: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              boxShadow: scrolled
                                  ? [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          offset: const Offset(0.0, 10.0),
                                          blurRadius: 10.0,
                                          spreadRadius: -6.0)
                                    ]
                                  : []),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color: const Color(0x1AA3D9A5),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(
                                        Ionicons.chevron_back_outline),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Center(
                                  child: Text(
                                    'Notification',
                                    style: GoogleFonts.nunito(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF3B3B3B)),
                                  ),
                                ),
                              )
                            ],
                          )),
                    );
                  },
                ),
                ...slivers,
              ],
            ),
          ),
        );
      },
    );
  }
}
