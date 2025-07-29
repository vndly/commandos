enum Priority {
  floor(0),
  laser(1),
  vision(1),
  agent(2),
  turret(3),
  soldier(3),
  light(4);

  final int value;

  const Priority(this.value);
}
