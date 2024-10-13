import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_patterns_manual/plain/mvvm/viemwodel/quote_view_model.dart';

class QuoteViewModelProvider extends InheritedWidget {
  final QuoteViewModel quoteViewModel;

  const QuoteViewModelProvider({
    super.key,
    required this.quoteViewModel,
    required super.child,
  });

  @override
  bool updateShouldNotify(QuoteViewModelProvider oldWidget) =>
      oldWidget.quoteViewModel != quoteViewModel;

  static QuoteViewModel of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<QuoteViewModelProvider>();

    if (provider == null) {
      throw 'No QuoteViewModel  found in context';
    }

    return provider.quoteViewModel;
  }

  static QuoteViewModel read(BuildContext context) {
    final provider =
        context.getInheritedWidgetOfExactType<QuoteViewModelProvider>();

    if (provider == null) {
      throw Exception('No QuoteViewModelProvider found in context');
    }

    return (provider).quoteViewModel;
  }
}
