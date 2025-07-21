import 'package:flutter/material.dart';
import 'package:hpcsl_1/colors.dart';

import 'Drawer.dart';
import 'TitleManager.dart';

class Accounts extends StatefulWidget {
  const Accounts({super.key});

  @override
  State<Accounts> createState() => _Accounts();
}

class _Accounts extends State<Accounts> {
  String title = '';
  final String subtitle = "Accounts Statements";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Variable to keep track of the selected item index
  int selectedIndex = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Added form key

  @override
  void initState() {
    super.initState();
    _loadDynamicTitle();
  }

  void _loadDynamicTitle() async {
    final fetchedTitle = await TitleManager.getTitle();
    setState(() {
      title = fetchedTitle;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white, // Set the background color of the body to white
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: AppColors.colorPrimary,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40), // Space for app bar content
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    color: AppColors.titlecolor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white),
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer(); // Open the drawer
                      },
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Image.asset(
                      'assets/images/sign_out.png',
                      width: 30,
                      height: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: CustomDrawer(
          selectedIndex: selectedIndex,
          onItemTap: (int index) {
            setState(() {
              selectedIndex = index;
            });
            _scaffoldKey.currentState?.openEndDrawer(); // Close the drawer on item tap
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Info List
              _buildInfoRow('Remaining Amount', '2745005'),
              _buildInfoRow('Remaining Amount (LCY)', '2745005'),

              // Add the "View Outstanding Details" button after the info rows
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.infinity, // This will make the button take up the full width
                  child: ElevatedButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.colorPrimary, // Text color
                      padding: const EdgeInsets.symmetric(vertical: 12.0), // Increase the button size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0), // Rounded corners for buttons
                      ),
                    ),
                    child: const Text('View Outstanding Details', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160, // Set a fixed width for the title
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16, // Set value text color to grey
              ),
              overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
              maxLines: 1, // Ensure value remains in one line
            ),
          ),
        ],
      ),
    );
  }
}
