import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_patterns_manual/plain/mvi/viewmodel/quote_viemwodel_intent.dart';
import 'package:flutter_architecture_patterns_manual/plain/mvvm/viemwodel/quote_view_model.dart';

class QuoteViewModelWithIntentProvider extends InheritedWidget {
  final QuoteViewModelWithIntent quoteViewModel;

  const QuoteViewModelWithIntentProvider({
    super.key,
    required this.quoteViewModel,
    required super.child,
  });

  @override
  bool updateShouldNotify(QuoteViewModelWithIntentProvider oldWidget) =>
      oldWidget.quoteViewModel != quoteViewModel;

  static QuoteViewModelWithIntent of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<QuoteViewModelWithIntentProvider>();

    if (provider == null) {
      throw 'No QuoteViewModel  found in context';
    }

    return provider.quoteViewModel;
  }

  static QuoteViewModelWithIntent read(BuildContext context) {
    final provider = context
        .getInheritedWidgetOfExactType<QuoteViewModelWithIntentProvider>();

    if (provider == null) {
      throw Exception('No QuoteViewModelProvider found in context');
    }

    return (provider).quoteViewModel;
  }
}
