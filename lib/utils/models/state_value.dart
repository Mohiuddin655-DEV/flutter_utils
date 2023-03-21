class StateValue<T> {
  final T active, inactive;

  const StateValue({
    required this.active,
    T? inactive,
  }) : inactive = inactive ?? active;

  T detect(bool activated) => activated ? active : inactive;
}
