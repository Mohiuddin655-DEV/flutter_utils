enum ReplacerType {
  none(15000),
  delete(15001),
  insert(15002),
  reload(15003),
  update(15004),
  recent(16001);

  final num value;

  const ReplacerType(this.value);
}
