import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test_project/widgets/custom_listTile.dart';
import 'package:http/http.dart' as http;

import 'details_Page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final _baseUrl = 'https://jsonplaceholder.typicode.com/posts';
  final _baseUrl = 'https://picsum.photos/v2/list';

  int _page = 0;
  final int _limit = 20;

  bool _hasNextPage = true;

  bool _isFirstLoadRunning = false;

  bool _isLoadMoreRunning = false;

  List _posts = [];

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res =
          //  await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));
          await http
              .get(Uri.parse("$_baseUrl?pageNumber=$_page&limit=$_limit"));
      setState(() {
        _posts = json.decode(res.body);
      });
    } catch (err) {
      print('Something went wrong');
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });
      _page += 1;
      try {
        final res =
            await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));

        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _posts.addAll(fetchedPosts);
          });
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        print('Something went wrong!');
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: const Text('List of Data'),
      ),
      body: _isFirstLoadRunning
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
                strokeWidth: 2,
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: _posts.length,
                    itemBuilder: (_, index) => Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      // child: ListTile(
                      //   title: InkWell(
                      //     onTap: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => DetailsPage(
                      //                     text: _posts[index]['url'],
                      //                   )));
                      //     },
                      //     child: Text(
                      //       _posts[index]['url'],
                      //       style: const TextStyle(
                      //           fontSize: 15.0,
                      //           fontWeight: FontWeight.bold,
                      //           color: Colors.teal),
                      //     ),
                      //   ),
                      //   subtitle: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //
                      //       const SizedBox(
                      //         height: 10,
                      //       ),
                      //       Text(
                      //         _posts[index]['download_url'],
                      //         style: const TextStyle(
                      //             fontSize: 12.0,
                      //             fontWeight: FontWeight.bold,
                      //             color: Colors.black),
                      //       ),
                      //       const SizedBox(
                      //         height: 10,
                      //       ),
                      //       Text(
                      //         _posts[index]['author'],
                      //         style: const TextStyle(
                      //             fontSize: 10.0,
                      //             fontWeight: FontWeight.bold,
                      //             color: Colors.grey),
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      child: CustomListTile(
                        title: _posts[index]['url'],
                        subTitle: _posts[index]['download_url'],
                        anotherSubTitle: _posts[index]['author'],
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                        text: _posts[index]['url'],
                                      )));
                        },
                      ),
                    ),
                  ),
                ),
                if (_isLoadMoreRunning == true)
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                if (_hasNextPage == false)
                  Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 40),
                    color: Colors.amber,
                    child: const Center(
                      child: Text('You have fetched all of the content'),
                    ),
                  ),
              ],
            ),
    );
  }
}
