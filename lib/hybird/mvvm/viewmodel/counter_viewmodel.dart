import 'dart:math';

import 'package:flutter_architecture_patterns_manual/dips/base_viewmodel/base_viewmodel.dart';
import 'package:flutter_architecture_patterns_manual/dips/channel/channel.dart';
import 'package:flutter_architecture_patterns_manual/hybird/mvvm/viewmodel/counter_state.dart';

class CounterViewmodel extends BaseViewModel<CounterState> {
  CounterViewmodel() : super(const CounterState());

  void getCounter() async {
    emit(state.copyWith(isLoading: true));

    await Future.delayed(const Duration(seconds: 2));
    final newCounter = Random().nextInt(100);
    emit(state.copyWith(isLoading: false, count: newCounter));
  }

  final _channel = StreamableChannel<CounterEvents>();

  StreamableChannel<CounterEvents> get channel => _channel;

  void incrementCounter() => emit(state.copyWith(count: state.count + 1));

  void decrementCounter() => emit(state.copyWith(count: state.count - 1));

  void showSnackBar() {
    _channel.send(ShowSnackBar("some message some message"));
  }

  void popScreen() {
    _channel.send(PopScreen());
  }

  @override
  void close() {
    super.close();
    _channel.close();
  }
}

sealed class CounterEvents {
  const CounterEvents();
}

class ShowSnackBar extends CounterEvents {
  final String message;

  const ShowSnackBar(this.message);
}

class PopScreen extends CounterEvents {
  const PopScreen();
}
