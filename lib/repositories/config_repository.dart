import 'package:email_alarm/models/config_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigRepository {
  ConfigRepository();
  late SharedPreferences _prefs;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<Config> getConfig() async {
    final specificSenders = _prefs.getString('specificSenders');
    final intervalintervalInMinutes = _prefs.getInt('intervalInMinutes');
    if (specificSenders == null || intervalintervalInMinutes == null) {
      const newConfig = Config();
      await setConfig(newConfig);
      return newConfig;
    }
    return Config(
      specificSenders: specificSenders,
      intervalInMinutes: intervalintervalInMinutes,
    );
  }

  Future<void> setConfig(Config config) async {
    await _prefs.setString('specificSenders', config.specificSenders);
    await _prefs.setInt('intervalInMinutes', config.intervalInMinutes);
  }
}
