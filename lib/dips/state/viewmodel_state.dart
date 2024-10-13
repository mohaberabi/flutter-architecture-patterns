import 'dart:async';

class ViewModelState<T> {
  ViewModelState(T initial) {
    _value = initial;
    _controller = StreamController<T>.broadcast(onListen: () {
      _controller.add(initial);
    });
    _controller.add(_value);
  }

  late T _value;

  T get value => _value;
  late StreamController<T> _controller;

  Stream<T> get stream => _controller.stream;

  Future<void> close() async => _controller.close();

  void update(T t) {
    _value = t;
    _controller.add(t);
  }
}
