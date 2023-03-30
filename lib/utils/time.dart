class TimeUtil {
  /// 根据当前时间返回早上、上午、中午、下午或晚上
  static String getPeriodOfDay() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 8) {
      return '早上';
    } else if (hour >= 9 && hour < 11) {
      return '上午';
    } else if (hour >= 11 && hour < 14) {
      return '中午';
    } else if (hour >= 14 && hour < 18) {
      return '下午';
    } else {
      return '晚上';
    }
  }
}
