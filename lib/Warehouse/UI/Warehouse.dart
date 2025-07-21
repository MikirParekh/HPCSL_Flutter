import 'package:flutter/material.dart';
import 'package:hpcsl_1/Warehouse/Model/Warehouse_Model.dart';
import 'package:hpcsl_1/colors.dart';

import '../../Drawer.dart';
import '../../NoRecordFound.dart';
import '../../Sign In/UI/login.dart';
import '../../TitleManager.dart';
import '../Repo/WarehouseReposistry.dart';

class Warehouse extends StatefulWidget {
  const Warehouse({super.key});

  @override
  State<Warehouse> createState() => _Warehouse();
}

class WarehouseException implements Exception {
  final String message;
  const WarehouseException(this.message);

  @override
  String toString() => "WarehouseException: $message";
}


class _Warehouse extends State<Warehouse> {
  String title = '';
  final String subtitle = "Warehouse Inventory";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Added form key
  late List<WarehouseModel1> importDataList;

  List<WarehouseModel1> users = [];
  bool isLoading = true;
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _BlNo = TextEditingController();
  List<WarehouseModel1> filteredUsers = [];
  String? userid;

  WarehouseApi  warehouse = WarehouseApi ();

  @override
  void initState() {
    super.initState();
    fetchWarehouseData();
    _loadDynamicTitle();
  }


  Future<void> fetchWarehouseData() async {
    setState(() => isLoading = true);
    try {
      final response = await warehouse.fetchWarehouseData(context);

      if (mounted) {
        setState(() {
          users = response.value ?? [];
          debugPrint('Fetched Warehouse data: ${users.length}');
        });
      }
    } catch (e) {
      if (mounted) {
        debugPrint('Error in Fetching Warehouse data: $e');
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

  void _loadDynamicTitle() async {
    final fetchedTitle = await TitleManager.getTitle();
    setState(() {
      title = fetchedTitle;
    });
  }


  String getPreviousDayFormatted() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final formattedDate = "${yesterday.day.toString().padLeft(2, '0')}/"
        "${yesterday.month.toString().padLeft(2, '0')}/"
        "${yesterday.year}";
    return "$formattedDate at 23:59 hrs";
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
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              content: SizedBox(
                                width: 800, // Increase width of the dialog
                                child: const Text('Are You Sure You Want to Exit?',style:TextStyle(fontSize: 16) ,),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close dialog
                                  },
                                  child: const Text('CANCEL',style:TextStyle(color: Colors.blue),),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Add your logout logic here
                                    Navigator.of(context).pop(); // Close dialog
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                          (route) => false,
                                    );
                                  },
                                  child: const Text('CONFIRM',style:TextStyle(color: Colors.blue),),
                                ),
                              ],
                            );
                          },
                        );
                      },

                      child: Image.asset(
                        'assets/images/sign_out.png',
                        width: 30,
                        height: 30,
                      ),
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
            _scaffoldKey.currentState?.openEndDrawer();
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
              Center(// Title
                child: Text(
                  'As on ${getPreviousDayFormatted()}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Title and Info List

              const Divider(height: 20, thickness: 2,color: Colors.blue,),
              WareHousedata(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget WareHousedata(BuildContext context) {
    final dataToShow =
    (_controller.text.isNotEmpty || _BlNo.text.isNotEmpty)
        ? filteredUsers
        : users;
    return Expanded(
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : dataToShow.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ErrorScreen(
                errorImage: "assets/images/no_content.png",
                titleMsg: "No Record Found",
                msg: "",
              ),
            ),
          ],
        ),
      )
          : ListView.separated(
        itemCount: dataToShow.length,
        separatorBuilder: (context, index) => const Divider(
          color: Colors.grey,
          thickness: 1.0,
          height: 1.0,
        ),
        itemBuilder: (context, index) {
          final user = dataToShow[index];
          return ListTile(
            title: _buildInfoRow('Code', user.code ?? 'N/A'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Name', user.name ?? 'N/A'),

                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: SizedBox(
                    width: double.infinity, // This will make the button take up the full width
                    child:ElevatedButton.icon(
                      onPressed: () async {
                        debugPrint('Download button pressed');

                        // Show loading indicator
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Row(
                              children: [
                                CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                                SizedBox(width: 16),
                                Text('Downloading file...'),
                              ],
                            ),
                            duration: Duration(seconds: 30), // Long duration as we'll dismiss it manually
                          ),
                        );

                        try {
                          debugPrint('Attempting to download file for customer: C00002, Location: MHPL-SAU');

                          // Call the download method with the new parameters
                          await warehouse.downloadFileforWarehouse( locationCode: user.code ?? '', );
                          debugPrint('File downloaded successfully');

                          // Dismiss the loading snackbar
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();

                          // Show success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Row(
                                children: [
                                  Icon(Icons.check_circle, color: Colors.white),
                                  SizedBox(width: 16),
                                  Text('File downloaded and opened successfully!'),
                                ],
                              ),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 3),
                            ),
                          );
                        } catch (e) {
                          debugPrint('Error downloading file: $e');

                          // Dismiss the loading snackbar
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();

                          // Show error message with specific details
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  const Icon(Icons.error, color: Colors.white),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      'Download failed: ${e.toString().replaceAll('Exception:', '').trim()}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 5),
                            ),
                          );
                        }
                      },

                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.colorPrimary, // Text color
                        padding: const EdgeInsets.symmetric(vertical: 12.0), // Increase the button size
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0), // Rounded corners for buttons
                        ),
                      ),
                      icon: Image.asset(
                        'assets/images/download.png',
                        width: 22,
                        height: 22,
                      ),
                      label: const Text('Download', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
              ],
            ),
            isThreeLine: true,
            contentPadding: EdgeInsets.zero,
          );
        },


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
            width: 120, // Set a fixed width for the title
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
                color: Colors.black,
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
