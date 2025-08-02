enum Priority {
  map_0(0),
  laser(1),
  vision(1),
  door_top(1),
  door_bottom(1),
  map_1(1),
  agent(2),
  turret(2),
  soldier(2),
  light(4),
  map_2(5);

  final int value;

  const Priority(this.value);
}
