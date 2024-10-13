import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_patterns_manual/dips/state/viewmodel_state.dart';

abstract class BaseViewModel<S> extends ChangeNotifier {
  final S initialState;

  BaseViewModel(this.initialState) : _state = ViewModelState(initialState);

  late final ViewModelState<S> _state;

  S get state => _state.value;

  Stream<S> get stream => _state.stream;

  void close() {
    super.dispose();
  }

  void emit(S s) {
    _state.update(s);
    notifyListeners();
  }
}
