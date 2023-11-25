import 'package:flutter/material.dart';
import 'package:flutter_app_grocery_admin/inner_screens/all_orders_screen.dart';
import 'package:flutter_app_grocery_admin/inner_screens/all_products.dart';
import 'package:flutter_app_grocery_admin/providers/dark_theme_provider.dart';
import 'package:flutter_app_grocery_admin/screens/main_screen.dart';
import 'package:flutter_app_grocery_admin/services/utils.dart';
import 'package:flutter_app_grocery_admin/widgets/text_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    final themeState = Provider.of<DarkThemeProvider>(context);

    final color = Utils(context).color;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset(
              "assets/images/groceries.png",
            ),
          ),
          DrawerListTile(
            title: "Main",
            press: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ),
              );
            },
            icon: Icons.home_filled,
          ),
          DrawerListTile(
            title: "View all products",
            press: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AllProductsScreen()));
            },
            icon: Icons.store,
          ),
          DrawerListTile(
            title: "View all order",
            press: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AllOrdersScreen()));
            },
            icon: IconlyBold.bag_2,
          ),
          SwitchListTile(
            title: Text(themeState.getDarkTheme ? 'Dark Mode' : 'Light Mode'),
            secondary: Icon(themeState.getDarkTheme
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined),
            value: theme,
            onChanged: (value) {
              setState(() {
                themeState.setDarkTheme = value;
              });
            },
            activeColor: Colors.white,
          )
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.press,
    required this.icon,
  }) : super(key: key);

  final String title;
  final VoidCallback press;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    final color = theme == true ? Colors.white : Colors.black;

    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      title: Row(
        children: [
          Icon(
            icon,
            size: 18,
          ),
          const SizedBox(width: 33), // Khoảng cách giữa icon và text
          TextWidget(
            text: title,
            color: color,
          ),
        ],
      ),
    );
  }
}
