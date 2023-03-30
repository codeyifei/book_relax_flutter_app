import 'package:book_relax_flutter_app/entity/types.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wrapper.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ResponseWrapper<T> {
  int code;
  String message;
  T data;

  ResponseWrapper(this.code, this.message, this.data);

  factory ResponseWrapper.fromJson(
          JsonData json, FromJsonGenericFunction<T> fromJsonT) =>
      _$ResponseWrapperFromJson(json, fromJsonT);

  JsonData toJson(ToJsonGenericFunction toJsonT) =>
      _$ResponseWrapperToJson(this, toJsonT);

  @override
  String toString() {
    return 'ResponseWrapper{code: $code, message: $message, data: $data}';
  }
}

@JsonSerializable(genericArgumentFactories: true)
class PaginationWrapper<T> {
  List<T> list;
  PaginationMeta meta;

  PaginationWrapper(this.list, this.meta);

  factory PaginationWrapper.fromJson(
          JsonData json, FromJsonGenericFunction<T> fn) =>
      _$PaginationWrapperFromJson(json, fn);

  JsonData toJson(ToJsonGenericFunction<T> fn) =>
      _$PaginationWrapperToJson(this, fn);

  @override
  String toString() {
    return 'PaginationWrapper{list: $list, meta: $meta}';
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PaginationMeta {
  int total;
  int page;
  int pageSize;
  int pages;

  PaginationMeta(this.total, this.page, this.pageSize, this.pages);

  factory PaginationMeta.fromJson(JsonData json) =>
      _$PaginationMetaFromJson(json);

  JsonData toJson() => _$PaginationMetaToJson(this);

  @override
  String toString() {
    return 'PaginationMeta{total: $total, page: $page, pageSize: $pageSize, pages: $pages}';
  }
}
