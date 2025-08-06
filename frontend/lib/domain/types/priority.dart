enum Priority {
  map(0),
  laser(1),
  vision(2),
  door(3),
  agent(4),
  turret(5),
  soldier(6),
  item(7);

  final int value;

  const Priority(this.value);
}
