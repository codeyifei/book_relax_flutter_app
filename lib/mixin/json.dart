import 'package:book_relax_flutter_app/entity/types.dart';

mixin JsonSerializableMixin<T> {
  T fromJson(JsonData json);

  JsonData toJson(T obj);
}
