import 'package:chat_appp/pages/calls_page.dart';
import 'package:chat_appp/pages/contacts_page.dart';
import 'package:chat_appp/pages/messages_page.dart';
import 'package:chat_appp/pages/notifications_page.dart';
import 'package:chat_appp/theme.dart';
import 'package:chat_appp/widgets/avatar.dart';
import 'package:chat_appp/widgets/glowing_action_button.dart';
import 'package:chat_appp/widgets/icon_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helpers.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Messages');

  final pages = const [
    MessagesPage(),
    NotificationsPage(),
    CallPage(),
    ContactsPage(),
  ];

  final pageTitles = const [
    'Messages',
    'Notifications',
    'Calls',
    'Contacts'
  ];

  void onNavigationItemSelected(index) 
      { title.value = pageTitles[index]; pageIndex.value = index;
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: ValueListenableBuilder(
          valueListenable: title,
          builder: (BuildContext context, String value, _) {
            return Text(value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ));
          },
        ),
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(icon: Icons.search,
           onTap: () {
            print('YOU BEST');
           }),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Avatar.small(url: Helpers.randomPictureUrl()),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (BuildContext context, int value, _) {
          return pages[value];
        },
      ),
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: onNavigationItemSelected,
      ),
    );
  }

  
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({Key? key, required this.onItemSelected})
      : super(key: key);

  final ValueChanged<int> onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;
  void handleSelectedItem(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Card(
      color: (brightness == Brightness.light) ? Colors.transparent : null,
      elevation: 0,
      margin: EdgeInsets.all(0),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavigationBarItem(
                index: 0,
                lable: 'Messages',
                icon: CupertinoIcons.bubble_left_bubble_right_fill,
                onTap: handleSelectedItem,
                isSelected: (selectedIndex == 0),
              ),
              _NavigationBarItem(
                index: 1,
                lable: 'Notifications',
                icon: CupertinoIcons.bell_solid,
                onTap: handleSelectedItem,
                isSelected: (selectedIndex == 1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, ),
                child: GlowingActionButton(color: AppColors.secondary, icon: CupertinoIcons.add, onPressed: () {
                  print('sokol sex');
                }),
              ),
              _NavigationBarItem(
                index: 2,
                lable: 'Calls',
                icon: CupertinoIcons.phone_fill,
                onTap: handleSelectedItem,
                isSelected: (selectedIndex == 2),
              ),
              _NavigationBarItem(
                index: 3,
                lable: 'Contacts  ',
                icon: CupertinoIcons.person_2_fill,
                onTap: handleSelectedItem,
                isSelected: (selectedIndex == 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem(
      {Key? key,
      required this.index,
      required this.icon,
      required this.lable,
      required this.onTap,
      this.isSelected = false})
      : super(key: key);

  final int index;
  final String lable;
  final IconData icon;
  final ValueChanged<int> onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.secondary : null,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              lable,
              style: isSelected
                  ? const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary)
                  : const TextStyle(fontSize: 11),
            )
          ],
        ),
      ),
    );
  }
}
