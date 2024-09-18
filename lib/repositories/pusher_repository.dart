import 'package:pusher_client/pusher_client.dart';

class PusherRepository {
  static PusherRepository? _instance;
  late PusherClient _pusher;
  late Channel _channel;

  PusherRepository._();

  factory PusherRepository() {
    if (_instance == null) {
      _instance = PusherRepository._();
      return _instance!;
    } else {
      return _instance!;
    }
  }

  void pusherConnect() {
    _pusher =
        PusherClient("0496f1badaa049846379", PusherOptions(cluster: "ap1"));
  }

  void subscribeChannel(int id) {
    _channel = _pusher.subscribe('message.$id');
  }

  void listenEvents(void Function(dynamic event) onEvent) async {
    _channel.bind('message.event', (event) {
      onEvent(event);
    });
  }

  void disconnect(int id) async {
    if (_pusher != null) {
      await _pusher.unsubscribe('message.$id');
    }
  }
}
