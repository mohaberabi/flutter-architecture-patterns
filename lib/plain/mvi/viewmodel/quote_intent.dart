import 'package:flutter_architecture_patterns_manual/core/model/quote_model.dart';

sealed class QuoteIntent {
  const QuoteIntent();
}

class GetQuote extends QuoteIntent {
  const GetQuote();
}

class ClearError extends QuoteIntent {
  const ClearError();
}

class AddQuote extends QuoteIntent {
  final QuoteModel quote;

  const AddQuote(this.quote);
}
