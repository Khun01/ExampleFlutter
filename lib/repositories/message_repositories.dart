import 'package:help_isko/models/message/existing_chat.dart';
import 'package:help_isko/models/message/user.dart';
import 'package:help_isko/services/message_service.dart';

class MessageRepository {
  final MessageService _messageService;
  MessageRepository(this._messageService);

  Future<String> getToken() async {
    return await _messageService.getToken();
  }

  Future<List<ExistingChat>> getExistingChats(String token) async {
    try {
      return await _messageService.getExistingChats(token);
    } catch (e) {
      rethrow;
    }
  }
}
