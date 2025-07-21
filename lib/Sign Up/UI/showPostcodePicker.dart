import 'dart:async';
import 'package:flutter/material.dart';
import '../Model/Postcode_model.dart';
import '../Repo/PostCodeListReposistry.dart';
import 'Signup.dart'; // Ensure this contains the necessary UserApi definition

class PostcodeList extends StatefulWidget {
  const PostcodeList({Key? key}) : super(key: key);

  @override
  _PostcodeListState createState() => _PostcodeListState();
}

class _PostcodeListState extends State<PostcodeList> {
  final TextEditingController _textController = TextEditingController();

  List<Postcode1> users = [];
  bool isLoading = true;
  TextEditingController searchController1 = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    fetchPostcodes();
    searchController1.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), filterPostcode);
    });
  }

  @override
  void dispose() {
    searchController1.removeListener(filterPostcode);
    searchController1.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> fetchPostcodes() async {
    setState(() => isLoading = true);
    try {
      final response = await UserApi().fetchUser(context, '', ''); // Fetch Postcode data
      if (mounted) {
        setState(() {
          users = response.value ?? [];
        });
      }
    } catch (e) {
      if (mounted) {
        debugPrint('Error in Fetching Postcodes: $e');
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void filterPostcode() async {
    final searchText = searchController1.text.trim();

    if (searchText.isEmpty) {
      await fetchPostcodes();
      return;
    }

    setState(() => isLoading = true);
    try {
      final response = await UserApi().fetchPostCodeWithSearch(context, searchText);
      if (mounted) {
        setState(() {
          users = response.value ?? [];
        });
      }
    } catch (e) {
      if (mounted) {
        debugPrint('Error in Searching Postcodes: $e');
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    // Reorder the list so that postcodes with missing or null values are shown last
    List<Postcode1> sortedUsers = [
      ...users.where((user) => user.code != null && user.code!.isNotEmpty), // Valid postcodes first
      ...users.where((user) => user.code == null || user.code!.isEmpty), // Missing postcodes last
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            color: Colors.white,
            height: height * 85 / 100,
            width: width / 1.1,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 0),
                        child: Text(
                          'Select Item',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: searchController1,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        // hintText: 'Search Postcode...',
                      ),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.fromLTRB(25, 8, 8, 6),
                        child: Text(
                          'Select Postcode',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : sortedUsers.isEmpty
                        ? const Center(
                      child: Text(
                        '', // Remove "No results found" message
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                        : ListView.separated(
                      itemCount: sortedUsers.length,
                      itemBuilder: (context, index) {
                        final user = sortedUsers[index];
                        final code = user.code ?? 'N/A';

                        return ListTile(
                          title: Text(code),
                          onTap: () async {
                            print('Selected Postcode: $code');
                            print('City: ${user.city}');

                            final selectedPostcode = {
                              'postcode': code,
                              'city': user.city ?? 'Unknown',
                            };

                            // Pop the selected postcode back to the previous screen and set it in the TextFormField
                            Navigator.of(context).pop(selectedPostcode);

                            // Update the TextEditingController for the TextField with the selected postcode
                            _textController.text = code; // This will update the value of the TextFormField immediately
                          },

                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.grey,
                        height: 1.0,
                        thickness: 1.0,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Close',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SetPostCode {
  static String? _postcode;

  static Future<String?> getPostCode() async {
    return _postcode;
  }

  static Future<void> setPostCode(String? postcode) async {
    _postcode = postcode;
  }
}
