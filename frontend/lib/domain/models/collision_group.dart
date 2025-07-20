class CollisionGroup {
  final bool isSensor;
  final int category;
  final int mask;
  final int group;

  static final CollisionGroup AGENT = CollisionGroup(
    isSensor: false,
    category: Groups.AGENT,
    mask: Groups.WALL | Groups.TURRET,
  );

  static final CollisionGroup TURRET = CollisionGroup(
    isSensor: false,
    category: Groups.TURRET,
    mask: Groups.WALL | Groups.AGENT,
  );

  static final CollisionGroup WALL = CollisionGroup(
    isSensor: false,
    category: Groups.WALL,
    mask: Groups.AGENT | Groups.TURRET,
  );

  CollisionGroup({
    required this.isSensor,
    required this.category,
    required this.mask,
  }) : group = -category;
}

class Groups {
  static const int AGENT = 0x0001; // 0000 0000 0000 0001
  static const int TURRET = 0x0002; // 0000 0000 0000 0010
  static const int WALL = 0x0004; // 0000 0000 0000 0100
}
