import 'package:flutter/material.dart';
import 'package:hpcsl_1/colors.dart';
import 'package:intl/intl.dart';
import '../../Drawer.dart';
import '../../NoRecordFound.dart';
import '../../SharedPreference.dart';
import '../../TitleManager.dart';
import '../Model/Outstanding_Model.dart';
import '../Repo/ViewOutstandingRepository.dart';


class ViewOutStanding extends StatefulWidget {
  // final String? userid;

  const ViewOutStanding({super.key});

  @override
  State<ViewOutStanding> createState() => _ViewOutStanding();
}


class _ViewOutStanding extends State<ViewOutStanding> {
  String title = '';
  final String subtitle = "Outstanding Details";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late List<OutStandingModel1> outstandingDataList;
  String? userid;

  List<OutStandingModel1> users = [];
  bool isLoading = true;
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _BlNo = TextEditingController();
  List<OutStandingModel1> filteredUsers = [];

  ViewOutstandingApi accounts = ViewOutstandingApi ();

  @override
  void initState() {
    super.initState();
    _loadDynamicTitle();
    fetchOutStandingData();
  }


  Future<void> fetchOutStandingData() async {
    userid = await StorageManager.readData('userid') as String?;
    try {
      final response = await accounts.fetchViewOutStanding(context);

      if (mounted) {
        setState(() {
          users = response.value ?? [];
          debugPrint('Fetched OutStanding data: ${users.length}');
        });
      }
    } catch (e) {
      if (mounted) {
        debugPrint('Error in Fetching ViewOutStanding data: $e');
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
              Accountdata(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget Accountdata(BuildContext context) {
    final dataToShow =
    (_controller.text.isNotEmpty || _BlNo.text.isNotEmpty) ? filteredUsers : users;

    return Expanded(
      flex: 2,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : dataToShow.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
      children:[
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
            title: _buildInfoRow('Posting Date', formatDate(user.postingDate)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Document Type', user.documentType?.toString() ?? 'N/A'),
                _buildInfoRow('Document No', user.documentNo?.toString() ?? 'N/A'),
                _buildInfoRow('External Document No', user.externalDocumentNo ?? 'N/A'),
                _buildInfoRow('Original Amount', user.originalAmount?.toString() ?? 'N/A'),
                _buildInfoRow('Remaining Amount', user.remainingAmount?.toString() ?? 'N/A'),
                _buildInfoRow('Original Amount(LCY)', user.originalAmtLCY?.toString() ?? 'N/A'),
                _buildInfoRow('Remaining Amount(LCY)', user.remainingAmtLCY?.toString() ?? 'N/A'),
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
            width: 130, // Set a fixed width for the title
            child: Text(
              title,
              style: TextStyle(
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

  String formatDate(String? date) {
    if (date == null || date.isEmpty) return 'N/A';
    try {
      final parsedDate = DateTime.parse(date); // Parse the date string
      return DateFormat('dd-MM-yyyy').format(parsedDate); // Format the date
    } catch (e) {
      return 'Invalid Date'; // Handle invalid date strings
    }
  }
}
