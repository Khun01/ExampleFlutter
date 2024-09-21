import 'package:help_isko/models/message/existing_chat.dart';
import 'package:help_isko/models/message/message.dart';
import 'package:help_isko/models/message/user.dart';
import 'package:help_isko/services/messenger_service.dart';

class MessengerRepository {
  final MessengerService _messengerService;
  MessengerRepository(this._messengerService);

  Future<String> getToken() async {
    return await _messengerService.getToken();
  }

  Future<List<ExistingChat>> getExistingChats(String token) async {
    try {
      return await _messengerService.getExistingChats(token);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Message>> getChats(String token, int targetUserId) async {
    try {
      return await _messengerService.getChats(token, targetUserId);
    } catch (e) {
      rethrow;
    }
  }

  Future<Message> sendMessage(
      String token, int targetUserId, String message) async {
    try {
      return await _messengerService.sendMessage(token, targetUserId, message);
    } catch (e) {
      rethrow;
    }
  }
}
