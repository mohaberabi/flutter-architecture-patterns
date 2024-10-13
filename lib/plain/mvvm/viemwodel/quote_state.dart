import '../../../core/model/quote_model.dart';

class QuoteState {
  final String? error;

  final QuoteModel? quote;
  final bool isLoading;

  const QuoteState({
    this.quote,
    this.error,
    this.isLoading = false,
  });

  QuoteState copyWith({
    String? error,
    QuoteModel? quote,
    bool? isLoading,
  }) {
    return QuoteState(
      error: error ?? this.error,
      quote: quote ?? this.quote,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
