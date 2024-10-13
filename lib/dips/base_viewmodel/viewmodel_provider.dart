import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_patterns_manual/dips/base_viewmodel/base_viewmodel.dart';

class ViewmodelProvider<VM extends BaseViewModel> extends StatefulWidget {
  final VM viewmodel;
  final Widget child;

  const ViewmodelProvider({
    super.key,
    required this.child,
    required this.viewmodel,
  });

  @override
  State<ViewmodelProvider<VM>> createState() => _ViewmodelProviderState();
}

class _ViewmodelProviderState<VM extends BaseViewModel>
    extends State<ViewmodelProvider<VM>> {
  @override
  Widget build(BuildContext context) {
    return InheritedViewModelProvider<VM>(
      child: widget.child,
      viewmodel: widget.viewmodel,
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.viewmodel.dispose();
  }
}

class InheritedViewModelProvider<VM extends BaseViewModel>
    extends InheritedWidget {
  final VM viewmodel;

  const InheritedViewModelProvider({
    super.key,
    required super.child,
    required this.viewmodel,
  });

  static VIEWMODEL of<VIEWMODEL extends BaseViewModel>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<
        InheritedViewModelProvider<VIEWMODEL>>();
    if (provider == null) {
      throw Exception("Provider not found ");
    }
    return provider.viewmodel;
  }

  @override
  bool updateShouldNotify(InheritedViewModelProvider oldWidget) =>
      oldWidget.viewmodel != viewmodel;
}

extension Read on BuildContext {
  VM read<VM extends BaseViewModel>() =>
      InheritedViewModelProvider.of<VM>(this);
}
