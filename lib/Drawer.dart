// import 'package:flutter/material.dart';
// import 'package:hpcsl_1/colors.dart';
//
// import 'AccountStatement/UI/Accounts.dart';
// import 'ChangePassword/UI/ChangePassword.dart';
// import 'Domestic/UI/Domestic.dart';
// import 'ViewProfile/UI/Edit.dart';
// import 'EmptyContainer/UI/EmptyContainer.dart';
// import 'EmptyTracking/UI/Empty.dart';
// import 'Export/UI/Export.dart';
// import 'HomeScreen.dart';
// import 'Import/UI/Import.dart';
// import 'Invoice/UI/Invoice.dart';
// import 'Sign In/UI/login.dart';
// import 'Transport/UI/Transport.dart';
// import 'Warehouse/UI/Warehouse.dart';
//
// class CustomDrawer extends StatelessWidget {
//   final int? selectedIndex;
//   final Function(int) onItemTap;
//   final bool showAccounts; // Access control flag
//
//   CustomDrawer({this.selectedIndex, required this.onItemTap, required this.showAccounts,});
//
//   void _navigateToScreen(BuildContext context, int index) {
//     Widget screen;
//     switch (index) {
//       case 0:
//         screen = HomeScreen();
//         break;
//       case 1:
//         screen = Export();
//         break;
//       case 2:
//         screen = Import();
//         break;
//       case 3:
//         screen = Domestic();
//         break;
//       case 4:
//         screen = Empty();
//         break;
//       case 5:
//         screen = Transport();
//         break;
//       case 6:
//         if (showAccounts) {
//           screen = const Accounts();
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text("You do not have access to Accounts Statement."),
//               duration: Duration(seconds: 3),
//               backgroundColor: Colors.black,
//             ),
//           );
//           return;
//         }
//         break;
//       case 7:
//         screen = Invoice();
//         break;
//       case 8:
//         screen = Warehouse();
//         break;
//       case 9:
//         screen = EmptyContainer();
//         break;
//       case 10:
//         screen = Edit();
//         break;
//       case 11:
//         screen = ChangePassword ();
//         break;
//       case 12:
//       // Handle logout differently
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => LoginScreen()),
//               (route) => false,
//         );
//         return;
//       default:
//         return;
//     }
//
//     // Use push for normal navigation to maintain stack
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => screen),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: Colors.white,
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           _buildDrawerHeader(),
//           _buildHomeItem(context),
//           const Divider(),
//           _buildTrackingSection(context),
//           const Divider(),
//           _buildAccountSection(context),
//           const Divider(),
//           _buildInventorySection(context),
//           const Divider(),
//           _buildSettingsSection(context),
//           _buildLogoutItem(context),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDrawerHeader() {
//     return SizedBox(
//       height: 120,
//       child: DrawerHeader(
//         decoration: const BoxDecoration(
//           color: Colors.blue,
//         ),
//         padding: const EdgeInsets.only(top: -28.0),
//         child: Stack(
//           children: [
//             Center(
//               child: Image.asset(
//                 'assets/images/logo.png',
//                 width: 120,
//                 height: 100,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHomeItem(BuildContext context) {
//     return ListTile(
//       leading: _getDrawerIcon('assets/images/home.png'),
//       title: Text(
//         'Home',
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//           color: Colors.blue,
//         ),
//       ),
//       selected: selectedIndex == 0,
//       selectedTileColor: Colors.grey.withOpacity(0.3),
//       onTap: () {
//         onItemTap(0);
//         Navigator.pop(context);
//         _navigateToScreen(context, 0);
//       },
//     );
//   }
//
//   Widget _buildTrackingSection(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const ListTile(
//           title: Text('Tracking',
//             style: TextStyle(
//               color: AppColors.darkGrey,
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         _buildTrackingItem(context, 'Export Tracking', 'assets/images/export.png', 1),
//         _buildTrackingItem(context, 'Import Tracking', 'assets/images/import_report.png', 2),
//         _buildTrackingItem(context, 'Domestic Tracking', 'assets/images/domestic.png', 3),
//         _buildTrackingItem(context, 'Empty Tracking', 'assets/images/empty.png', 4),
//         _buildTrackingItem(context, 'Transport Tracking', 'assets/images/transit.png', 5),
//       ],
//     );
//   }
//
//   Widget _buildTrackingItem(BuildContext context, String title, String iconPath, int index) {
//     return ListTile(
//       leading: _getDrawerIcon(iconPath),
//       title: Text(
//         title,
//         style: TextStyle(
//           color: Colors.black,
//           fontSize: 14,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//       selected: selectedIndex == index,
//       selectedTileColor: Colors.grey.withOpacity(0.3),
//       onTap: () {
//         onItemTap(index);
//         Navigator.pop(context);
//         _navigateToScreen(context, index);
//       },
//     );
//   }
//
//   Widget _buildAccountSection(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const ListTile(
//           title: Text('Account',
//             style: TextStyle(
//               color: AppColors.darkGrey,
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         _buildAccountItem(context, 'Account Statement', 'assets/images/outstanding.png', 6),
//         _buildAccountItem(context, 'Invoice', 'assets/images/invoice.png', 7),
//       ],
//     );
//   }
//
//   Widget _buildAccountItem(BuildContext context, String title, String iconPath, int index) {
//     return ListTile(
//       leading: _getDrawerIcon(iconPath),
//       title: Text(
//         title,
//         style: TextStyle(
//           color: Colors.black,
//           fontSize: 14,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//       selected: selectedIndex == index,
//       selectedTileColor: Colors.grey.withOpacity(0.3),
//       onTap: () {
//         onItemTap(index);
//         Navigator.pop(context);
//         _navigateToScreen(context, index);
//       },
//     );
//   }
//
//   Widget _buildInventorySection(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const ListTile(
//           title: Text('Inventory',
//             style: TextStyle(
//               color: AppColors.darkGrey,
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         _buildInventoryItem(context, 'Warehouse Inventory', 'assets/images/warehouse.png', 8),
//         _buildInventoryItem(context, 'Empty Container Inventory', 'assets/images/empty.png', 9),
//       ],
//     );
//   }
//
//   Widget _buildInventoryItem(BuildContext context, String title, String iconPath, int index) {
//     return ListTile(
//       leading: _getDrawerIcon(iconPath),
//       title: Text(
//         title,
//         style: TextStyle(
//           color: Colors.black,
//           fontSize: 14,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//       selected: selectedIndex == index,
//       selectedTileColor: Colors.grey.withOpacity(0.3),
//       onTap: () {
//         onItemTap(index);
//         Navigator.pop(context);
//         _navigateToScreen(context, index);
//       },
//     );
//   }
//
//   Widget _buildSettingsSection(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const ListTile(
//           title: Text('Settings',
//             style: TextStyle(
//               color: AppColors.darkGrey,
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         _buildSettingsItem(context, 'View Profile', 'assets/images/edit.png', 10),
//         _buildSettingsItem(context, 'Change Password/mpin', 'assets/images/ic_change_password_lock.png', 11),
//       ],
//     );
//   }
//
//   Widget _buildSettingsItem(BuildContext context, String title, String iconPath, int index) {
//     return ListTile(
//       leading: _getDrawerIcon(iconPath),
//       title: Text(
//         title,
//         style: TextStyle(
//           color: Colors.black,
//           fontSize: 14,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//       selected: selectedIndex == index,
//       selectedTileColor: Colors.grey.withOpacity(0.3),
//       onTap: () {
//         onItemTap(index);
//         Navigator.pop(context);
//         _navigateToScreen(context, index);
//       },
//     );
//   }
//
//   Widget _buildLogoutItem(BuildContext context) {
//     return ListTile(
//       leading: _getDrawerIcon('assets/images/logout.png'),
//       title: const Text(
//         'Logout',
//         style: TextStyle(
//           color: Colors.black,
//           fontSize: 14,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//       selected: selectedIndex == 12,
//       selectedTileColor: Colors.grey.withOpacity(0.3),
//       onTap: () {
//         onItemTap(12);
//         Navigator.pop(context);
//         _navigateToScreen(context, 12);
//       },
//     );
//   }
//
//   Widget _getDrawerIcon(String iconPath) {
//     return ColorFiltered(
//       colorFilter: const ColorFilter.mode(
//         Colors.blue,
//         BlendMode.srcIn,
//       ),
//       child: Image.asset(
//         iconPath,
//         width: 24,
//         height: 30,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:hpcsl_1/colors.dart';

import 'AccountStatement/UI/Accounts.dart';
import 'ChangePassword/UI/ChangePassword.dart';
import 'Domestic/UI/Domestic.dart';
import 'SharedPreference.dart';
import 'ViewProfile/UI/Edit.dart';
import 'EmptyContainer/UI/EmptyContainer.dart';
import 'EmptyTracking/UI/Empty.dart';
import 'Export/UI/Export.dart';
import 'HomeScreen/UI/HomeScreen.dart';
import 'Import/UI/Import.dart';
import 'Invoice/UI/Invoice.dart';
import 'Sign In/UI/login.dart';
import 'Transport/UI/Transport.dart';
import 'Warehouse/UI/Warehouse.dart';

class CustomDrawer extends StatefulWidget {
  final int? selectedIndex;
  final Function(int) onItemTap;

  const CustomDrawer({
    Key? key,
    this.selectedIndex,
    required this.onItemTap,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool showAccounts = false;

  @override
  void initState() {
    super.initState();
    _loadUserInvoiceStatus();
  }

  Future<void> _loadUserInvoiceStatus() async {
    final userInvoice = await StorageManager.readData('userInvoice');
    setState(() {
      showAccounts = userInvoice == true;
    });
  }

  Future<void> _navigateToScreen(BuildContext context, int index) async {
    Widget screen;
    switch (index) {
      case 0:
        screen = HomeScreen();
        break;
      case 1:
        screen = Export();
        break;
      case 2:
        screen = Import();
        break;
      case 3:
        screen = Domestic();
        break;
      case 4:
        screen = Empty();
        break;
      case 5:
        screen = Transport();
        break;
      case 6:
        final userInvoice = await StorageManager.readData('userInvoice');
        if (userInvoice == true || userInvoice == 'true') {
          screen = const Accounts();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("You do not have access to Account Statement."),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 3),
            ),
          );
          return;
        }
        break;
      case 7:
        screen = Invoice();
        break;
      case 8:
        screen = Warehouse();
        break;
      case 9:
        screen = EmptyContainer();
        break;
      case 10:
        screen = Edit();
        break;
      case 11:
        screen = ChangePassword();
        break;
      case 12:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false,
        );
        return;
      default:
        return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(),
          _buildHomeItem(context),
          const Divider(),
          _buildTrackingSection(context),
          const Divider(),
          _buildAccountSection(context),
          const Divider(),
          _buildInventorySection(context),
          const Divider(),
          _buildSettingsSection(context),
          _buildLogoutItem(context),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return SizedBox(
      height: 120,
      child: DrawerHeader(
        decoration: const BoxDecoration(color: Colors.blue),
        padding: const EdgeInsets.only(top: -28.0),
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            width: 120,
            height: 100,
          ),
        ),
      ),
    );
  }

  Widget _buildHomeItem(BuildContext context) {
    return ListTile(
      leading: _getDrawerIcon('assets/images/home.png'),
      title: const Text('Home', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
      selected: widget.selectedIndex == 0,
      selectedTileColor: Colors.grey.withOpacity(0.3),
      onTap: () {
        widget.onItemTap(0);
        Navigator.pop(context);
        _navigateToScreen(context, 0);
      },
    );
  }

  Widget _buildTrackingSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          title: Text('Tracking', style: TextStyle(color: AppColors.darkGrey, fontSize: 16, fontWeight: FontWeight.w500)),
        ),
        _buildTrackingItem(context, 'Export Tracking', 'assets/images/export.png', 1),
        _buildTrackingItem(context, 'Import Tracking', 'assets/images/import_report.png', 2),
        _buildTrackingItem(context, 'Domestic Tracking', 'assets/images/domestic.png', 3),
        _buildTrackingItem(context, 'Empty Tracking', 'assets/images/empty.png', 4),
        _buildTrackingItem(context, 'Transport Tracking', 'assets/images/transit.png', 5),
      ],
    );
  }

  Widget _buildTrackingItem(BuildContext context, String title, String iconPath, int index) {
    return ListTile(
      leading: _getDrawerIcon(iconPath),
      title: Text(title, style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
      selected: widget.selectedIndex == index,
      selectedTileColor: Colors.grey.withOpacity(0.3),
      onTap: () {
        widget.onItemTap(index);
        Navigator.pop(context);
        _navigateToScreen(context, index);
      },
    );
  }

  Widget _buildAccountSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          title: Text('Account', style: TextStyle(color: AppColors.darkGrey, fontSize: 16, fontWeight: FontWeight.w500)),
        ),
        _buildAccountItem(context, 'Account Statement', 'assets/images/outstanding.png', 6),
        _buildAccountItem(context, 'Invoice', 'assets/images/invoice.png', 7),
      ],
    );
  }

  Widget _buildAccountItem(BuildContext context, String title, String iconPath, int index) {
    return ListTile(
      leading: _getDrawerIcon(iconPath),
      title: Text(title, style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
      selected: widget.selectedIndex == index,
      selectedTileColor: Colors.grey.withOpacity(0.3),
      onTap: () {
        widget.onItemTap(index);
        Navigator.pop(context);
        _navigateToScreen(context, index);
      },
    );
  }

  Widget _buildInventorySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          title: Text('Inventory', style: TextStyle(color: AppColors.darkGrey, fontSize: 16, fontWeight: FontWeight.w500)),
        ),
        _buildInventoryItem(context, 'Warehouse Inventory', 'assets/images/warehouse.png', 8),
        _buildInventoryItem(context, 'Empty Container Inventory', 'assets/images/empty.png', 9),
      ],
    );
  }

  Widget _buildInventoryItem(BuildContext context, String title, String iconPath, int index) {
    return ListTile(
      leading: _getDrawerIcon(iconPath),
      title: Text(title, style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
      selected: widget.selectedIndex == index,
      selectedTileColor: Colors.grey.withOpacity(0.3),
      onTap: () {
        widget.onItemTap(index);
        Navigator.pop(context);
        _navigateToScreen(context, index);
      },
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          title: Text('Settings', style: TextStyle(color: AppColors.darkGrey, fontSize: 16, fontWeight: FontWeight.w500)),
        ),
        _buildSettingsItem(context, 'View Profile', 'assets/images/edit.png', 10),
        _buildSettingsItem(context, 'Change Password/MPIN', 'assets/images/ic_change_password_lock.png', 11),
      ],
    );
  }

  Widget _buildSettingsItem(BuildContext context, String title, String iconPath, int index) {
    return ListTile(
      leading: _getDrawerIcon(iconPath),
      title: Text(title, style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
      selected: widget.selectedIndex == index,
      selectedTileColor: Colors.grey.withOpacity(0.3),
      onTap: () {
        widget.onItemTap(index);
        Navigator.pop(context);
        _navigateToScreen(context, index);
      },
    );
  }

  Widget _buildLogoutItem(BuildContext context) {
    return ListTile(
      leading: _getDrawerIcon('assets/images/logout.png'),
      title: const Text('Logout', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
      selected: widget.selectedIndex == 12,
      selectedTileColor: Colors.grey.withOpacity(0.3),
      onTap: () {
        widget.onItemTap(12);
        Navigator.pop(context);
        _navigateToScreen(context, 12);
      },
    );
  }

  Widget _getDrawerIcon(String iconPath) {
    return ColorFiltered(
      colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
      child: Image.asset(iconPath, width: 24, height: 30),
    );
  }
}
