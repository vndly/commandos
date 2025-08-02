enum Priority {
  map_0(0),
  laser(1),
  vision(1),
  door(1),
  agent(2),
  turret(3),
  soldier(3),
  light(4),
  map_1(5);

  final int value;

  const Priority(this.value);
}
