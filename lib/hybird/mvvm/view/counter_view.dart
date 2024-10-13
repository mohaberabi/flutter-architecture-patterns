import 'package:flutter/material.dart';
import 'package:flutter_architecture_patterns_manual/dips/base_viewmodel/viewmodel_builder.dart';
import 'package:flutter_architecture_patterns_manual/dips/base_viewmodel/viewmodel_provider.dart';
import 'package:flutter_architecture_patterns_manual/dips/channel/channel_listener.dart';
import 'package:flutter_architecture_patterns_manual/hybird/mvvm/viewmodel/counter_state.dart';
import 'package:flutter_architecture_patterns_manual/hybird/mvvm/viewmodel/counter_viewmodel.dart';

class CounterViewRoot extends StatelessWidget {
  const CounterViewRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewmodelProvider<CounterViewmodel>(
      viewmodel: CounterViewmodel()..getCounter(),
      child: const CounterView(),
    );
  }
}

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    print("build from counter view");
    final viewmodel = context.read<CounterViewmodel>();
    return ChannelListener(
      stream: viewmodel.channel,
      listener: (context, event) {
        switch (event) {
          case ShowSnackBar():
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(event.message)));
          case PopScreen():
            Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () => viewmodel.showSnackBar(),
                  child: Text("Show snackbar")),
              Row(
                children: [
                  IconButton(
                      onPressed: () => viewmodel.incrementCounter(),
                      icon: const Icon((Icons.add))),
                  ViewmodelBuilder<CounterViewmodel, CounterState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const CircularProgressIndicator();
                      } else {
                        return Text(state.count.toString());
                      }
                    },
                  ),
                  IconButton(
                      onPressed: () => viewmodel.decrementCounter(),
                      icon: const Icon((Icons.remove))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
