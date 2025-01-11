import 'package:tension_tunnel_tools/generators/avatars_generator.dart';
import 'package:tension_tunnel_tools/generators/coins_generator.dart';
import 'package:tension_tunnel_tools/generators/debris_generator.dart';
import 'package:tension_tunnel_tools/generators/icons_generator.dart';
import 'package:tension_tunnel_tools/generators/level_generator.dart';
import 'package:tension_tunnel_tools/generators/portal_generator.dart';
import 'package:tension_tunnel_tools/generators/power_ups_generator.dart';
import 'package:tension_tunnel_tools/generators/spikes_generator.dart';
import 'package:tension_tunnel_tools/generators/trail_generator.dart';

void main() {
  const LevelGenerator().run();
  const PowerUpsGenerator().run();
  const SpikesGenerator().run();
  const PortalGenerator().run();
  const AvatarsGenerator().run();
  const TrailGenerator().run();
  const DebrisGenerator().run();
  const CoinsGenerator().run();
  const IconsGenerator().run();
}
