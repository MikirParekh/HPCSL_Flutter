import 'dart:async';
import 'package:flutter/material.dart';
import '../Model/State_model.dart';
import '../Repo/StateListReposistry.dart';

class StateList extends StatefulWidget {
  const StateList({Key? key}) : super(key: key);

  @override
  _StateList createState() => _StateList();
}

class _StateList extends State<StateList> {
  String selectedText = '';
  List<StateModel> users = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchStatecodes();
    searchController.addListener(() {
      // Debounce the search logic to prevent excessive API calls
      Timer(const Duration(milliseconds: 300), () {
        filterStates();
      });
    });
  }


  @override
  void dispose() {
    searchController.removeListener(filterStates);
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchStatecodes() async {
    setState(() => isLoading = true);
    try {
      final response = await StateApi().fetchStates(context ,'', '');  // Pass only context
// Fetch Postcode data
      if (mounted) {
        setState(() {
          users = response.value ?? [];
          debugPrint('Fetched States: ${users.length}');
        });
      }
    } catch (e) {
      if (mounted) {
        debugPrint('Error in Fetching States: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load data: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  // void filterStates() async {
  //   final searchText = searchController.text.trim().toLowerCase();
  //
  //   if (searchText.isEmpty) {
  //     // If the search field is empty, fetch all states
  //     await fetchStatecodes();
  //     return;
  //   }
  //
  //   setState(() => isLoading = true); // Show loader while searching
  //   try {
  //     // Call the API with search text
  //     final response = await StateApi().fetchStatesWithSearch(context, searchText);
  //     if (mounted) {
  //       setState(() {
  //         users = response.value ?? []; // Update the list with searched results
  //       });
  //     }
  //   } catch (e) {
  //     if (mounted) {
  //       debugPrint('Error in Searching States: $e');
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Failed to search: $e')),
  //       );
  //     }
  //   } finally {
  //     if (mounted) {
  //       setState(() => isLoading = false); // Stop loader
  //     }
  //   }
  // }

  void filterStates() async {
    final searchText = searchController.text.trim();
    debugPrint('Searching for: $searchText');

    setState(() => isLoading = true);

    try {
      if (searchText.isEmpty) {
        debugPrint('Empty search - fetching all states');
        await fetchStatecodes();
        return;
      }

      debugPrint('Fetching states with search term');
      final response = await StateApi().fetchStatesWithSearch(context, searchText);

      if (mounted) {
        setState(() {
          users = response.value ?? [];
          debugPrint('Search results count: ${users.length}');
        });
      }
    } catch (e) {
      if (mounted) {
        debugPrint('Error in filterStates: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Search failed: $e')),
        );
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
    var hight = size.height;
    var width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
            child: Container(
              height: hight * 85 / 100,
              width: width/.1,
              child: Padding(
              padding: const EdgeInsets.all(10),
               child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left:25,top:0),
                        child: Text(
                          'Select Item',
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
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
                          'Select State',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : users.isEmpty
                        ? const Center(
                      child: Text(
                        'No results found',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                        : ListView.separated(
                      itemCount: users.length,
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.grey, // Color of the divider
                        thickness: 1.0, // Thickness of the divider
                        height: 1.0, // Space before and after the divider
                      ),
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return ListTile(
                          title: Text(user.description ?? 'N/A'),
                          onTap: () async {
                            await SetStateCode.setStateCode(user.code);

                            Navigator.of(context).pop(user.description);
                          },
                        );
                      },
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
                            style: TextStyle(color: Colors.blue, // Set the text color to blue
                               fontSize: 16, // You can adjust the font size as needed
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )

                ],
              ),
                    ),
            ),

          ),
        ),

    );
  }
}

class SetStateCode {
  static String? _statecode; // Private variable to store postcode value

  // Static asynchronous method to get the postcode
  static Future<String?> getStateCode() async {
    return _statecode; // Return the stored postcode
  }

  // Static asynchronous method to set the postcode
  static Future<void> setStateCode(String? statecode) async {
    _statecode = statecode; // Store the new postcode value
  }
}
