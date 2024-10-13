import 'package:flutter/material.dart';
import 'package:flutter_architecture_patterns_manual/plain/mvvm/viemwodel/quote_view_model.dart';
import 'package:flutter_architecture_patterns_manual/plain/mvvm/viemwodel/quote_viewmodel_provider.dart';

import '../../../core/model/quote_repository.dart';

class QuoteViewRoot extends StatelessWidget {
  const QuoteViewRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return QuoteViewModelProvider(
        quoteViewModel: QuoteViewModel(
          quoteRepository: QuoteRepository(),
        ),
        child: const QuoteView());
  }
}

class QuoteView extends StatefulWidget {
  const QuoteView({super.key});

  @override
  State<QuoteView> createState() => _QuoteViewState();
}

class _QuoteViewState extends State<QuoteView> {
  late final QuoteViewModel quoteViewModel;

  @override
  void initState() {
    super.initState();
    quoteViewModel = QuoteViewModelProvider.read(context)
      ..getQuote()
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
      quoteViewModel.clearError();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(quoteViewModel.state.error!)),
      );
    }
  }
}
