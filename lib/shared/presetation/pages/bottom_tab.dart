import 'package:flutter/material.dart';
import 'package:flutter_get_ride_app/core/helper/helper.dart';
import 'package:flutter_get_ride_app/features/home/presentation/pages/home_page.dart';

class BottomTab extends StatefulWidget {
  const BottomTab({super.key});

  @override
  _BottomTabState createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int _selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = <Widget>[
    HomePage(),
    MyBookingPage(),
    MyInboxPage(),
    MyVoucherPage(),
    MyProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(color: Colors.blue, fontSize: 12),
        unselectedLabelStyle: TextStyle(color: Colors.grey, fontSize: 10),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              _selectedIndex == 0
                  ? Helper.getIconPath('ic_home_active')
                  : Helper.getIconPath('ic_home_inactive'),
              width: 23,
              height: 23,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              _selectedIndex == 1
                  ? Helper.getIconPath('ic_document_active')
                  : Helper.getIconPath('ic_document_inactive'),
              width: 23,
              height: 23,
            ),
            label: 'My Booking',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              _selectedIndex == 2
                  ? Helper.getIconPath('ic_message_active')
                  : Helper.getIconPath('ic_message_inactive'),
              width: 23,
              height: 23,
            ),
            label: 'My Inbox',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              _selectedIndex == 3
                  ? Helper.getIconPath('ic_voucher_active')
                  : Helper.getIconPath('ic_voucher_inactive'),
              width: 23,
              height: 23,
            ),
            label: 'My Voucher',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              _selectedIndex == 4
                  ? Helper.getIconPath('ic_profile_active')
                  : Helper.getIconPath('ic_profile_inactive'),
              width: 23,
              height: 23,
            ),
            label: 'My Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}



class MyBookingPage extends StatelessWidget {
  const MyBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('My Booking Page'),
    );
  }
}

class MyInboxPage extends StatelessWidget {
  const MyInboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('My Inbox Page'),
    );
  }
}

class MyVoucherPage extends StatelessWidget {
  const MyVoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('My Voucher Page'),
    );
  }
}

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('My Profile Page'),
    );
  }
}
