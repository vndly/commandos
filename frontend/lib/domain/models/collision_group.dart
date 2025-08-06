class CollisionGroup {
  final bool isSensor;
  final int category;
  final int mask;
  final int group;

  static final CollisionGroup AGENT = CollisionGroup(
    isSensor: false,
    category: Groups.AGENT,
    mask: Groups.WALL | Groups.TURRET | Groups.SOLDIER,
  );

  static final CollisionGroup TURRET = CollisionGroup(
    isSensor: false,
    category: Groups.TURRET,
    mask: Groups.WALL | Groups.AGENT,
  );

  static final CollisionGroup SOLDIER = CollisionGroup(
    isSensor: false,
    category: Groups.SOLDIER,
    mask: Groups.WALL | Groups.AGENT,
  );

  static final CollisionGroup ITEM = CollisionGroup(
    isSensor: false,
    category: Groups.ITEM,
    mask: Groups.AGENT,
  );

  static final CollisionGroup DOOR = CollisionGroup(
    isSensor: false,
    category: Groups.DOOR,
    mask: Groups.AGENT | Groups.TURRET | Groups.SOLDIER,
  );

  static final CollisionGroup DOOR_DETECTOR = CollisionGroup(
    isSensor: true,
    category: Groups.DOOR_DETECTOR,
    mask: Groups.AGENT | Groups.TURRET | Groups.SOLDIER,
  );

  static final CollisionGroup WALL = CollisionGroup(
    isSensor: false,
    category: Groups.WALL,
    mask: Groups.AGENT | Groups.TURRET | Groups.SOLDIER,
  );

  CollisionGroup({
    required this.isSensor,
    required this.category,
    required this.mask,
  }) : group = -category;
}

class Groups {
  static const int NONE = 0x0000; // 0000 0000 0000 0000
  static const int AGENT = 0x0001; // 0000 0000 0000 0001
  static const int TURRET = 0x0002; // 0000 0000 0000 0010
  static const int SOLDIER = 0x0004; // 0000 0000 0000 0100
  static const int WALL = 0x0008; // 0000 0000 0000 1000
  static const int DOOR = 0x0008; // 0000 0000 0000 1000
  static const int DOOR_DETECTOR = 0x0008; // 0000 0000 0000 1000
  static const int ITEM = 0x0010; // 0000 0000 0001 0000
}
