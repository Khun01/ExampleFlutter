part of 'image_picker_bloc.dart';

sealed class ImagePickerState extends Equatable {
  const ImagePickerState();
  
  @override
  List<Object> get props => [];
}

final class ImagePickerInitial extends ImagePickerState {}

class ImagePickerSuccess extends ImagePickerState {
  final File image;
  final String imageUrl;

  const ImagePickerSuccess(this.image, this.imageUrl);
}

class ImagePickerError extends ImagePickerState {
  final String error;

  const ImagePickerError({required this.error});
}

class ImagePickerLoading extends ImagePickerState {}