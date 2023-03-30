import 'package:book_relax_flutter_app/entity/mixin.dart';
import 'package:book_relax_flutter_app/entity/types.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BookListItemResponse with ToJsonMixin {
  int id;
  String title;
  String cover;
  int chapterCount;
  String readingProgress;
  DateTime uploadTime;
  DateTime? lastReadTime;

  BookListItemResponse(
    this.id,
    this.title,
    this.cover,
    this.chapterCount,
    this.readingProgress,
    this.uploadTime,
    this.lastReadTime,
  );

  factory BookListItemResponse.fromJson(JsonData json) =>
      _$BookListItemResponseFromJson(json);

  @override
  JsonData toJson() => _$BookListItemResponseToJson(this);

  @override
  String toString() {
    return 'BookListItemResponse{id: $id, title: $title, cover: $cover, chapterCount: $chapterCount, readingProgress: $readingProgress, uploadTime: $uploadTime, lastReadTime: $lastReadTime}';
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class BookDetailResponse with ToJsonMixin {
  String title;
  int chapterCount;
  int chapterProgress;
  int chapterPercentage;
  String readingProgress;
  DateTime uploadTime;

  BookDetailResponse(
    this.title,
    this.chapterCount,
    this.chapterProgress,
    this.chapterPercentage,
    this.readingProgress,
    this.uploadTime,
  );

  factory BookDetailResponse.fromJson(JsonData json) =>
      _$BookDetailResponseFromJson(json);

  @override
  JsonData toJson() => _$BookDetailResponseToJson(this);

  @override
  String toString() {
    return 'BookDetailResponse{title: $title, chapterCount: $chapterCount, chapterProgress: $chapterProgress, chapterPercentage: $chapterPercentage, readingProgress: $readingProgress, uploadTime: $uploadTime}';
  }
}

@JsonSerializable()
class UpdateBookTitleRequest with ToJsonMixin {
  String title;

  UpdateBookTitleRequest(this.title);

  factory UpdateBookTitleRequest.fromJson(JsonData json) =>
      _$UpdateBookTitleRequestFromJson(json);

  @override
  JsonData toJson() => _$UpdateBookTitleRequestToJson(this);

  @override
  String toString() {
    return 'UpdateBookTitleRequest{title: $title}';
  }
}
