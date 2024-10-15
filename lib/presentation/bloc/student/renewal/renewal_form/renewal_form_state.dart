import 'package:equatable/equatable.dart';

abstract class RenewalFormState extends Equatable {
  const RenewalFormState();

  @override
  List<Object?> get props => [];
}

class RenewalFormInitial extends RenewalFormState {}

class RenewalFormLoading extends RenewalFormState {}

class RenewalFormSuccess extends RenewalFormState {}

class RenewalFormFailure extends RenewalFormState {
  final String error;

  const RenewalFormFailure(this.error);

  @override
  List<Object?> get props => [error];
}
