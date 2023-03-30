// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookListItemResponse _$BookListItemResponseFromJson(
        Map<String, dynamic> json) =>
    BookListItemResponse(
      json['id'] as int,
      json['title'] as String,
      json['cover'] as String,
      json['chapter_count'] as int,
      json['reading_progress'] as String,
      DateTime.parse(json['upload_time'] as String),
      json['last_read_time'] == null
          ? null
          : DateTime.parse(json['last_read_time'] as String),
    );

Map<String, dynamic> _$BookListItemResponseToJson(
        BookListItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'cover': instance.cover,
      'chapter_count': instance.chapterCount,
      'reading_progress': instance.readingProgress,
      'upload_time': instance.uploadTime.toIso8601String(),
      'last_read_time': instance.lastReadTime?.toIso8601String(),
    };

BookDetailResponse _$BookDetailResponseFromJson(Map<String, dynamic> json) =>
    BookDetailResponse(
      json['title'] as String,
      json['chapter_count'] as int,
      json['chapter_progress'] as int,
      json['chapter_percentage'] as int,
      json['reading_progress'] as String,
      DateTime.parse(json['upload_time'] as String),
    );

Map<String, dynamic> _$BookDetailResponseToJson(BookDetailResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'chapter_count': instance.chapterCount,
      'chapter_progress': instance.chapterProgress,
      'chapter_percentage': instance.chapterPercentage,
      'reading_progress': instance.readingProgress,
      'upload_time': instance.uploadTime.toIso8601String(),
    };

UpdateBookTitleRequest _$UpdateBookTitleRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateBookTitleRequest(
      json['title'] as String,
    );

Map<String, dynamic> _$UpdateBookTitleRequestToJson(
        UpdateBookTitleRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
    };
