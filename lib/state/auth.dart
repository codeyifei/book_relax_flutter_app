import 'package:book_relax_flutter_app/constants/route.dart';
import 'package:book_relax_flutter_app/entity/types.dart';
import 'package:book_relax_flutter_app/state/cache.dart';
import 'package:book_relax_flutter_app/utils/debug.dart';
import 'package:get/get.dart';

class AuthState extends GetxController with CacheMixin {
  int _userId = 0;
  String _nickname = '';
  String _accessToken = '';
  String _refreshToken = '';
  DateTime? _expiration;

  String get nickname => _nickname;

  String get accessToken => _accessToken;

  bool get isLoggedIn =>
      _userId > 0 &&
      _accessToken.isNotEmpty &&
      _expiration!.isAfter(DateTime.now());

  String? _lastPath;

  @override
  void onInit() {
    super.onInit();

    DebugUtil.dump(toJson());
  }

  void save(
    int userId,
    String nickname,
    String accessToken,
    String refreshToken,
    DateTime expiration,
  ) {
    _userId = userId;
    _nickname = nickname;
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    _expiration = expiration;

    refresh();

    cache();
  }

  void clear() {
    _userId = 0;
    _nickname = '';
    _accessToken = '';
    _refreshToken = '';
    _expiration = null;

    refresh();

    removeCache();
  }

  toLogin() {
    _lastPath = Get.currentRoute;
    Get.offNamed(AppPath.login.path);
  }

  backLastPage() {
    Get.offNamed(_lastPath ?? AppPath.home.path);
  }

  @override
  String cacheKey() => 'auth';

  @override
  JsonData toJson() => {
        'userId': _userId,
        'nickname': _nickname,
        'accessToken': _accessToken,
        'refreshToken': _refreshToken,
        'expiration': _expiration.toString(),
      };

  @override
  initFromJson(JsonData json) {
    _userId = json['userId'] ?? 0;
    _nickname = json['nickname'] ?? '';
    _accessToken = json['accessToken'] ?? '';
    _refreshToken = json['refreshToken'] ?? '';
    var expirationValue = json['expiration'];
    if (expirationValue != null) _expiration = DateTime.parse(expirationValue);
  }
}
