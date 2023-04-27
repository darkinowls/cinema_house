import 'package:hive/hive.dart';

class LightModeRepository {
  final Box<bool> _lightModeBox;
  final String _key = "lightMode";

  LightModeRepository(this._lightModeBox);

  Future<bool> getDarkMode() async {
    return _lightModeBox.get(_key) ?? false;
  }

  bool saveDarkMode(bool lightMode) {
    _lightModeBox.put(_key, lightMode); // async
    return lightMode;
  }
}
