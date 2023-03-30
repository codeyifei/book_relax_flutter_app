import 'package:book_relax_flutter_app/api/books.dart';
import 'package:book_relax_flutter_app/component/can_back.dart';
import 'package:book_relax_flutter_app/entity/model/book.dart';
import 'package:book_relax_flutter_app/entity/vo/book.dart';
import 'package:book_relax_flutter_app/utils/debug.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReaderScreen extends StatefulWidget {
  const ReaderScreen({Key? key}) : super(key: key);

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  bool _headerShown = false;

  final int _bookId = Get.arguments;

  BookDetailResponse? _book;

  @override
  void initState() {
    super.initState();

    _getBook();
  }

  Future<void> _getBook() async {
    var book = await BookClient.getDetail(_bookId);
    setState(() {
      _book = book;
    });
  }

  Widget _buildReadContainer() {
    if (_book == null) return const Placeholder();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.grey,
      ),
      child: Text(_book?.title ?? ''),
    );
  }

  Widget _buildHeaderStack() {
    return Column(
      children: [
        AppBar(),
        const Expanded(child: SizedBox.shrink()),
        Container(
          color: Theme.of(context).appBarTheme.backgroundColor,
          child: Container(
            height: 100,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillBack(
      canBack: _headerShown,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: SafeArea(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _headerShown = !_headerShown;
                    });
                  },
                  child: _buildReadContainer(),
                ),
              ),
            ),
            if (_headerShown) _buildHeaderStack(),
          ],
        ),
      ),
    );
  }
}
