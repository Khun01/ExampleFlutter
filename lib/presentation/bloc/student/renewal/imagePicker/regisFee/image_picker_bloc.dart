import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePicker imagePicker;
  ImagePickerBloc(this.imagePicker) : super(ImagePickerInitial()) {
    on<ImagePickerRequestedEvent>(imagePickerRequestedEvent);
    on<ImagePickerRemovedRequestedEvent>(imagePickerRemovedRequestedEvent);
  }

  FutureOr<void> imagePickerRequestedEvent(
      ImagePickerRequestedEvent event, Emitter<ImagePickerState> emit) async {
    emit(ImagePickerLoading());
    try {
      final XFile? pickedFile =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final String imageUrl = pickedFile.path;
        log('The image url is: $imageUrl');
        emit(ImagePickerSuccess(File(pickedFile.path), imageUrl));
      } else {
        emit(const ImagePickerError(error: 'Please select an image first'));
      }
    } catch (e) {
      emit(ImagePickerError(error: e.toString()));
    }
  }

  FutureOr<void> imagePickerRemovedRequestedEvent(
      ImagePickerRemovedRequestedEvent event, Emitter<ImagePickerState> emit) {
    emit(ImagePickerInitial());
  }
}
