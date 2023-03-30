import 'package:book_relax_flutter_app/api/http.dart';
import 'package:book_relax_flutter_app/entity/vo/book.dart';
import 'package:book_relax_flutter_app/entity/vo/wrapper.dart';

class BookClient {
  static Future<PaginationWrapper<BookListItemResponse>> getBooks(
      {String keywords = ''}) async {
    var resp =
        await HttpClient().get('/books', queryParameters: {
      if (keywords.isNotEmpty) 'keywords': keywords,
    });

    return PaginationWrapper.fromJson(resp.data, (value) => BookListItemResponse.fromJson(value));
  }

  static Future<BookDetailResponse> getDetail(int id) async {
    var resp = await HttpClient().get('/books/$id');

    return BookDetailResponse.fromJson(resp.data);
  }
}
