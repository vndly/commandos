enum Priority {
  map(0),
  wall(1),
  laser(2),
  vision(3),
  door(4),
  agent(5),
  turret(6),
  soldier(7),
  item(8),
  backpack(9),
  alarm(10);

  final int value;

  const Priority(this.value);
}
