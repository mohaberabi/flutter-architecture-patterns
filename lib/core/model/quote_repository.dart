import 'dart:math';

import 'package:flutter_architecture_patterns_manual/core/model/quote_model.dart';

class QuoteRepository {
  Future<QuoteModel> getQuote() async {
    await Future.delayed(const Duration(seconds: 2));
    if (Random().nextBool()) {
      const quote = QuoteModel(id: "id", name: "Flutter is not that bad");
      return quote;
    } else {
      throw Exception("Error getting quote try again");
    }
  }

  Future<void> addQuote(QuoteModel quote) async {
    await Future.delayed(const Duration(seconds: 2));
    if (!Random().nextBool()) {
      throw Exception("Error saving  quote try again");
    }
  }
}
