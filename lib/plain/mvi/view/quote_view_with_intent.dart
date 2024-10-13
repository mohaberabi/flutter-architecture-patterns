import 'package:flutter/material.dart';
import 'package:flutter_architecture_patterns_manual/plain/mvi/view/quote_viewmodel_provider.dart';
import 'package:flutter_architecture_patterns_manual/plain/mvi/viewmodel/quote_intent.dart';
import 'package:flutter_architecture_patterns_manual/plain/mvi/viewmodel/quote_viemwodel_intent.dart';
import 'package:flutter_architecture_patterns_manual/plain/mvvm/viemwodel/quote_view_model.dart';
import 'package:flutter_architecture_patterns_manual/plain/mvvm/viemwodel/quote_viewmodel_provider.dart';

import '../../../core/model/quote_repository.dart';

class QuoteViewWithItnentRoot extends StatelessWidget {
  const QuoteViewWithItnentRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return QuoteViewModelWithIntentProvider(
        quoteViewModel: QuoteViewModelWithIntent(
          quoteRepository: QuoteRepository(),
        ),
        child: const QuoteViewWithItnent());
  }
}

class QuoteViewWithItnent extends StatefulWidget {
  const QuoteViewWithItnent({super.key});

  @override
  State<QuoteViewWithItnent> createState() => _QuoteViewState();
}

class _QuoteViewState extends State<QuoteViewWithItnent> {
  late final QuoteViewModelWithIntent quoteViewModel;

  @override
  void initState() {
    super.initState();
    quoteViewModel = QuoteViewModelWithIntentProvider.read(context)
      ..processIntent(const GetQuote())
      ..addListener(_addViewModelListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ListenableBuilder(
          listenable: quoteViewModel,
          builder: (context, widget) {
            final state = quoteViewModel.state;
            if (state.isLoading) {
              return const CircularProgressIndicator();
            } else {
              return state.quote == null
                  ? Text("Something went wrong")
                  : Text(state.quote!.name);
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    quoteViewModel.dispose();
  }

  void _addViewModelListener() {
    if (quoteViewModel.state.error != null) {
      quoteViewModel.processIntent(const ClearError());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(quoteViewModel.state.error!)),
      );
    }
  }
}
