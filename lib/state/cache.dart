import 'dart:convert';

import 'package:book_relax_flutter_app/entity/types.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin CacheMixin on GetxController {
  SharedPreferences get sp => Get.find();

  String cacheKey();

  initFromJson(JsonData json);

  JsonData toJson();

  @override
  void onInit() {
    super.onInit();

    var json = getFromCache();
    if (json != null) initFromJson(json);
  }

  void cache() {
    sp.setString(cacheKey(), jsonEncode(toJson()));
  }

  JsonData? getFromCache() {
    var data = sp.getString(cacheKey());
    if (data == null) return null;

    return jsonDecode(data);
  }

  Future<bool> removeCache() => sp.remove(cacheKey());
}
