import 'dart:async';

abstract interface class Channel<T> {
  void send(T data);

  Stream<T> get stream;

  Future<void> close();
}

sealed class ChannelValue {
  const ChannelValue();
}

class Empty extends ChannelValue {
  const Empty();
}

class ChannelData<T> extends ChannelValue {
  final T data;

  const ChannelData(this.data);
}

class StreamableChannel<T> extends Channel<T> {
  StreamableChannel() : _controller = StreamController.broadcast();
  late final StreamController<ChannelValue> _controller;

  @override
  void send(T data) {
    _controller.add(ChannelData<T>(data));
    _controller.add(const Empty());
  }

  @override
  Stream<T> get stream => _controller.stream.asyncExpand(
        (it) async* {
          switch (it) {
            case Empty():
              yield* Stream<T>.empty();
            case ChannelData():
              yield* Stream<T>.value(it.data);
          }
        },
      );

  @override
  Future<void> close() async {
    print("Closed");
    await _controller.close();
  }
}
