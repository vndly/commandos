import 'package:commandos/environments/environment.dart';

class LocalEnvironment extends Environment {
  @override
  String get name => 'local';

  @override
  Future configure() async {}
}
