import 'package:flutter/material.dart';
import 'package:flutter_architecture_patterns_manual/dips/channel/channel.dart';

class ChannelListener<T> extends StatefulWidget {
  final Channel<T> stream;

  final void Function(BuildContext context, T) listener;
  final Widget child;

  const ChannelListener({
    super.key,
    required this.listener,
    required this.child,
    required this.stream,
  });

  @override
  State<ChannelListener<T>> createState() => _ChannelListenerState<T>();
}

class _ChannelListenerState<T> extends State<ChannelListener<T>> {
  @override
  void dispose() {
    super.dispose();
    widget.stream.close();
  }

  @override
  Widget build(BuildContext context) {
    print("build from listener");
    return StreamBuilder(
      stream: widget.stream.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            widget.listener(context, snapshot.data as T);
          });
        }
        return widget.child;
      },
    );
  }
}
