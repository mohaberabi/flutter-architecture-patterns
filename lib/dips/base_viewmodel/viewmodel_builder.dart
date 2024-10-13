import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_patterns_manual/dips/base_viewmodel/base_viewmodel.dart';
import 'package:flutter_architecture_patterns_manual/dips/base_viewmodel/viewmodel_provider.dart';

class ViewmodelBuilder<VM extends BaseViewModel<S>, S> extends StatelessWidget {
  final Widget Function(BuildContext, S) builder;

  const ViewmodelBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final viewmodel = context.read<VM>();
    return ListenableBuilder(
      listenable: viewmodel,
      builder: (context, child) {
        return builder(context, viewmodel.state);
      },
    );
  }
}
