import 'package:book_relax_flutter_app/api/books.dart';
import 'package:book_relax_flutter_app/constants/route.dart';
import 'package:book_relax_flutter_app/constants/theme.dart';
import 'package:book_relax_flutter_app/entity/model/book.dart';
import 'package:book_relax_flutter_app/state/auth.dart';
import 'package:book_relax_flutter_app/utils/debug.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Book> _books = [];

  @override
  void initState() {
    super.initState();

    _getBooks();
  }

  Future<void> _getBooks() async {
    var resp = await BookClient.getBooks();

    var books = <Book>[];
    for (var item in resp.list) {
      books.add(Book(item.id, item.title, item.cover));
    }
    setState(() {
      _books = books;
    });
  }

  Widget _buildBookshelf() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 3 / 5,
        ),
        itemCount: _books.length,
        itemBuilder: (context, index) {
          var book = _books[index];
          return InkWell(
            onTap: () {
              Get.toNamed(AppPath.reader.path, arguments: book.id);
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: book.cover.isNotEmpty
                        ? Image.network(book.cover)
                        : Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: const Center(
                              child: Text('假装我是一个封面图'),
                            ),
                          ),
                  ),
                  Text(
                    book.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('书悠'),
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
        ),
      ),
      drawer: const _HomeDrawer(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _getBooks,
          child: _buildBookshelf(),
        ),
      ),
    );
  }
}

class _HomeDrawer extends StatefulWidget {
  const _HomeDrawer({Key? key}) : super(key: key);

  @override
  State<_HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<_HomeDrawer> {
  AuthState get _authState => Get.find();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: ThemeConstant.overlayStyle,
      child: Drawer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: _authState.isLoggedIn
                          ? null
                          : () {
                              Get.toNamed(AppPath.login.path);
                            },
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                  'assets/images/default_avatar.png'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _authState.isLoggedIn ? _authState.nickname : '请登录',
                            style: const TextStyle(
                              fontSize: 24.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
              FractionallySizedBox(
                widthFactor: 1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  onPressed: () {},
                  child: const Text('退出'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
