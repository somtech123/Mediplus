import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  SharedPreferences? prefs;

  Future _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future setRecentSearch(Set<String> allSearches) async {
    await _initPrefs();
    prefs!.setStringList("recentSearches", allSearches.toList());
  }

  Future<List<String>> getrecentSearch() async {
    await _initPrefs();
    return prefs!.getStringList("recentSearches") ?? [];
  }

  Future<void> clearStorage() async {
    await _initPrefs();

    prefs!.clear();
  }
}
