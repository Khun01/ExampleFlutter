part of 'image_picker_bloc.dart';

sealed class ImagePickerEvent extends Equatable {
  const ImagePickerEvent();

  @override
  List<Object> get props => [];
}

class ImagePickerRequestedEvent extends ImagePickerEvent {}

class ImagePickerRemovedRequestedEvent extends ImagePickerEvent {}