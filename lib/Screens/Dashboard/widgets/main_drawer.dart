// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slr_inventory_management/Screens/Dashboard/controller/dashboardController.dart';
import 'package:slr_inventory_management/Screens/Login/view/login_view.dart';
import 'package:slr_inventory_management/Utils/colors/colors.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  Dashboardcontroller dashboardcontroller = Get.find();
  String? userName;


  @override
  void initState() {
    super.initState();
    _loadUserData();
     dashboardcontroller.fetchData();
  }

  Future<void> _loadUserData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userName = pref.getString('name');
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: AppColors.appbarBlueGradient),
              ),
              child: SizedBox(
                width: double.infinity,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 30, // Reduced from 35
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 28, // Reduced from 33
                          backgroundImage: NetworkImage(
                            "https://i.pravatar.cc/150?img=8",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8), // Reduced from 10
                    Text(
                      userName ?? "",
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 1),
                     Obx(()=>
                        Text(
                       dashboardcontroller.raw.value['shop_name'].toString(),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                                           ),
                     ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            DrawerItemsWidget(
              size: size,
              icon: Icons.logout,
              title: "Logout",
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      title: Text(
                        "Logout",
                        style: TextStyle(
                          fontFamily: "Geist",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      content: Text(
                        "Are you sure you want to logout?",
                        style: TextStyle(
                          fontFamily: "Geist",
                          fontSize: 14.22,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.white60,
                            ),
                          ),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontFamily: "Geist",
                              fontWeight: FontWeight.w600,
                              fontSize: 12.8,
                              color: AppColors.mainBg,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              AppColors.mainBg,
                            ),
                          ),
                          child: Text(
                            "Logout",
                            style: TextStyle(
                              fontFamily: "Geist",
                              fontWeight: FontWeight.w600,
                              fontSize: 12.8,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          onPressed: () async {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                return LoginScreen();
                              }), (r) {
                                return false;
                              });
                              final SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              pref.remove('token');
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItemsWidget extends StatelessWidget {
  const DrawerItemsWidget({
    super.key,
    required this.size,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final Size size;
  final IconData icon;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: size.height / 15,

        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
        child: ListTile(
          onTap: onTap,
          leading: Icon(icon, size: 25),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: "Geist",
            ),
          ),
        ),
      ),
    );
  }
}
