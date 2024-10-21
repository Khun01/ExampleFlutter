import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'orf_proof_pic_event.dart';
part 'orf_proof_pic_state.dart';

class OrfProofPicBloc extends Bloc<OrfProofPicEvent, OrfProofPicState> {
  final ImagePicker imagePicker;
  OrfProofPicBloc(this.imagePicker) : super(OrfProofPicInitial()) {
    on<OrfProofPicPickerEvent>(orfProofPicPickerEvent);
  }

  FutureOr<void> orfProofPicPickerEvent(
      OrfProofPicPickerEvent event, Emitter<OrfProofPicState> emit) async {
    emit(OrfProofPicStateLoading());
    try {
      final XFile? pickedFile =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final String imageUrl = pickedFile.path;
        log('The image url is: $imageUrl');
        emit(OrfProofPicStateSuccess(File(pickedFile.path), imageUrl));
      } else {
        emit(const OrfProofPicStateError(
            errorMessage: 'Please select an image first'));
      }
    } catch (e) {
      emit(OrfProofPicStateError(errorMessage: e.toString()));
    }
  }
}
