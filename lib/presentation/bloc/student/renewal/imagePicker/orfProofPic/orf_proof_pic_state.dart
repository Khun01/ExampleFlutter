part of 'orf_proof_pic_bloc.dart';

sealed class OrfProofPicState extends Equatable {
  const OrfProofPicState();
  
  @override
  List<Object> get props => [];
}

final class OrfProofPicInitial extends OrfProofPicState {}


class OrfProofPicStateSuccess extends OrfProofPicState {
  final File image;
  final String imageOrfUrl;

  const OrfProofPicStateSuccess(this.image, this.imageOrfUrl);
}

class OrfProofPicStateError extends OrfProofPicState {
  final String errorMessage;

  const OrfProofPicStateError({ required this.errorMessage});
}

class OrfProofPicStateLoading extends OrfProofPicState {}