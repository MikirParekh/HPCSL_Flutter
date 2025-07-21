import 'package:flutter/material.dart';
import 'package:hpcsl_1/colors.dart';
import '../../Drawer.dart';
import '../../NoRecordFound.dart';
import '../../SharedPreference.dart';
import '../../Sign In/UI/login.dart';
import '../../TitleManager.dart';
import '../Model/Outstanding_Model.dart';
import '../Repo/OutstandingRepository.dart';
import 'ViewOutstanding.dart';

class Accounts extends StatefulWidget {
  const Accounts({super.key});

  @override
  State<Accounts> createState() => _Accounts();
}

class AccountException implements Exception {
  final String message;
  const AccountException(this.message);

  @override
  String toString() => "AccountException: $message";
}

class _Accounts extends State<Accounts> {
  String title = '';
  final String subtitle = "Accounts Statements";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late List<OutStandingModel1> outstandingDataList;

  List<OutStandingModel1> users = [];
  bool isLoading = true;
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _BlNo = TextEditingController();
  List<OutStandingModel1> filteredUsers = [];
  String? userid;

  OutstandingApi accounts = OutstandingApi();

  @override
  void initState() {
    super.initState();
    _loadUserId();
    testAPIResponse();
    _loadDynamicTitle();
  }

  Future<void> _loadUserId() async {
    userid = await StorageManager.readData('userid') as String?;
    if (userid == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error: User ID is missing')),
        );
      }
    } else {
      fetchOutStandingData();
    }
  }

  void _loadDynamicTitle() async {
    final fetchedTitle = await TitleManager.getTitle();
    setState(() {
      title = fetchedTitle;
    });
  }


  void testAPIResponse() async {
    try {
      final response = await accounts.fetchAllOutstandingData(userid ?? '');
      debugPrint('API Test Response: $response');

      // Print the structure of the response
      if (response['outstanding'] != null) {
        debugPrint('Outstanding data: ${response['outstanding']}');
      }
      if (response['outstandingLCY'] != null) {
        debugPrint('Outstanding LCY data: ${response['outstandingLCY']}');
      }
    } catch (e) {
      debugPrint('API Test Error: $e');
    }
  }

  Future<void> fetchOutStandingData() async {
    setState(() => isLoading = true);
    try {
      final response = await accounts.fetchAllOutstandingData(userid ?? '');

      if (mounted) {
        setState(() {
          // Create a single OutStandingModel1 instance with the values
          final outstandingValue = response['outstanding']?['value'] as num;
          final outstandingLCYValue = response['outstandingLCY']?['value'] as num;

          // Create a single user with these values
          users = [
            OutStandingModel1(
              remainingAmount: outstandingValue.toDouble(),
              remainingAmtLCY: outstandingLCYValue.toDouble(),
            )
          ];

          debugPrint('Set remaining amount: ${users[0].remainingAmount}');
          debugPrint('Set remaining amount LCY: ${users[0].remainingAmtLCY}');
        });
      }
    } catch (e) {
      if (mounted) {
        debugPrint('Error in Fetching OutStanding data: $e');
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
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
                const SizedBox(height: 40),
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
                      onPressed: () => _scaffoldKey.currentState?.openDrawer(),
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
                      onTap: () => _showLogoutDialog(),
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
            setState(() => selectedIndex = index);
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
              _buildAccountData()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountData() {
    final dataToShow = (_controller.text.isNotEmpty || _BlNo.text.isNotEmpty)
        ? filteredUsers
        : users;

    return Expanded(
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : dataToShow.isEmpty
          ? const Center(
        child: ErrorScreen(
          errorImage: "assets/images/no_content.png",
          titleMsg: "No Record Found",
          msg: "",
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
            title: _buildInfoRow(
              'Remaining Amount',
              ' ${user.remainingAmount?.toStringAsFixed(2) ?? 'N/A'}',
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(
                  'Remaining Amount (LCY)',
                  ' ${user.remainingAmtLCY?.toStringAsFixed(2) ?? 'N/A'}',
                ),
                const SizedBox(height: 20),
                _buildButton(
                  'View Outstanding Details',
                      () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewOutStanding(),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(color: Colors.blue,thickness: 2.0,),
                _buildButton(
                  'Download Statement',
                      () => _handleDownload(),
                ),
                const Text("*Previouse month statement will be available here",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black,), ),
                const Text("If require for other period,please contact to accounts dept.",style: TextStyle(fontSize: 8,color: Colors.grey,), ),
                const Divider(color: Colors.blue,thickness: 2.0,),

              ],
            ),
            isThreeLine: true,
            contentPadding: EdgeInsets.zero,
          );
        },
      ),
    );
  }



  Widget _buildInfoRow(String label, String value) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120, // Fixed width for the label
          child: Text(
            label,
            style:  TextStyle(
              color: Colors.blue[700],
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style:  TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
            ),
            overflow: TextOverflow.visible, // Allow text to display fully
            softWrap: true, // Enable text wrapping// Ensure value remains in one line
          ),
        ),
      ],
    );
  }


  Widget _buildButton(String label, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.colorPrimary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Future<void> _handleDownload() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(width: 16),
            Text('Downloading files...'),
          ],
        ),
        duration: Duration(seconds: 30),
      ),
    );

    try {
      await accounts.downloadFileforOutStanding(userid ?? '');
      await accounts.downloadFileforOutStandingExcel(userid ?? '');

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 16),
              Text('Files downloaded successfully!'),
            ],
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Set background color to white
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Optional: Rounded corners
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
  }
}