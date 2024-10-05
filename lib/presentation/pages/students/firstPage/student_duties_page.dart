import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help_isko/presentation/bloc/student/dutiespage/duties_bloc.dart';
import 'package:help_isko/presentation/widgets/my_app_bar.dart';

class StudentDutiesPage extends StatelessWidget {
  const StudentDutiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DutiesBloc, DutiesState>(
        listenWhen: (previous, current) =>
            current is DutiesAcceptLoading ||
            current is DutiesAcceptSuccess ||
            current is DutiesAcceptFailed || 
            current is DutiesFetchFailed,
        listener: (context, state) {
          if (state is DutiesAcceptSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Successfully Requested'),
              duration: Duration(seconds: 2),
            ));
          }
          if (state is DutiesAcceptFailed) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('You have already requested this duty or it has been processed.'),
              duration: Duration(seconds: 2),
            ));
          }
          if(state is DutiesFetchFailed){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errorMessage),
              duration: Duration(seconds: 2),
            ));
          }
        },
        buildWhen: (previous, current) =>
            current is DutiesFetchLoading || current is DutiesFetchSuccess,
        builder: (context, state) {
          switch (state.runtimeType) {
            case DutiesFetchLoading:
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: MyAppBar(role: 'Student'),
                  ),
                  SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              );
            case DutiesFetchSuccess:
              state as DutiesFetchSuccess;
              print('loli3');
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: MyAppBar(role: 'Student'),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Stack(children: [
                          Container(
                            // child: Text('hi'),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset('assets/images/profile_clicked.png',
                                    height: 30),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${state.availableDuties[index].employeeName}"),
                                    Text(
                                        "${state.availableDuties[index].message}"),
                                    Row(
                                      children: [
                                        Text(state.availableDuties[index].date),
                                        Text(
                                            "${state.availableDuties[index].startTime} - ${state.availableDuties[index].endTime}")
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  context.read<DutiesBloc>().add(
                                      DutiesAcceptEvent(
                                          id: state.availableDuties[index].id));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  color: Colors.green,
                                  child: Text(
                                    'Accept',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )),
                        ]);
                      },
                      childCount: state.availableDuties.length,
                    ),
                  ),
                ],
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
