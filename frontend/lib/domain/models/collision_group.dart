class CollisionGroup {
  final bool isSensor;
  final int category;
  final int mask;
  final int group;

  static final CollisionGroup AGENT = CollisionGroup(
    false,
    Groups.AGENT,
    Groups.TURRET | Groups.WALL,
  );

  static final CollisionGroup TURRET = CollisionGroup(
    false,
    Groups.TURRET,
    Groups.AGENT | Groups.WALL,
  );

  static final CollisionGroup WALL = CollisionGroup(
    false,
    Groups.WALL,
    Groups.AGENT | Groups.TURRET,
  );

  CollisionGroup(
    this.isSensor,
    this.category,
    this.mask,
  ) : group = -category;
}

class Groups {
  static const int AGENT = 0x0001; // 0000 0000 0000 0001
  static const int TURRET = 0x0002; // 0000 0000 0000 0010
  static const int WALL = 0x0004; // 0000 0000 0000 0100
}
