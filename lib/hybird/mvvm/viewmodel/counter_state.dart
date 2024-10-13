class CounterState {
  final int count;
  final bool isLoading;

  const CounterState({this.count = 0, this.isLoading = false});

  CounterState copyWith({
    int? count,
    bool? isLoading,
  }) {
    return CounterState(
      count: count ?? this.count,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
