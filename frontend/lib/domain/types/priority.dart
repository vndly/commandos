enum Priority {
  map_0(0),
  laser(1),
  vision(1),
  door_bottom(1),
  map_1(2),
  agent(3),
  turret(3),
  soldier(3),
  item(3),
  light(4),
  door_top(5),
  map_2(6);

  final int value;

  const Priority(this.value);
}
