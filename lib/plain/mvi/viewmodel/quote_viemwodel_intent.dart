import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_patterns_manual/plain/mvi/viewmodel/quote_intent.dart';
import 'package:flutter_architecture_patterns_manual/plain/mvvm/viemwodel/quote_state.dart';

import '../../../../core/model/quote_model.dart';
import '../../../../core/model/quote_repository.dart';

class QuoteViewModelWithIntent extends ChangeNotifier {
  final QuoteRepository _quoteRepository;

  QuoteViewModelWithIntent({
    required QuoteRepository quoteRepository,
  }) : _quoteRepository = quoteRepository;

  QuoteState _state = const QuoteState();

  QuoteState get state => _state;

  void processIntent(QuoteIntent intent) {
    switch (intent) {
      case GetQuote():
        _getQuote();
      case AddQuote():
        _addQuote(intent.quote);
      case ClearError():
        _clearError();
    }
  }

  void _getQuote() async {
    try {
      _state = _state.copyWith(isLoading: true, error: null);
      notifyListeners();
      final quote = await _quoteRepository.getQuote();
      _state = _state.copyWith(isLoading: false, quote: quote, error: null);
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(isLoading: false, error: e.toString());
      notifyListeners();
    }
  }

  void _addQuote(QuoteModel quote) async {
    try {
      _state = _state.copyWith(isLoading: true, error: null);
      notifyListeners();
      await _quoteRepository.addQuote(quote);
      _state = _state.copyWith(isLoading: false, quote: quote, error: null);
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(isLoading: false, error: e.toString());
      notifyListeners();
    }
  }

  void _clearError() => _state = _state.copyWith(error: null);
}
