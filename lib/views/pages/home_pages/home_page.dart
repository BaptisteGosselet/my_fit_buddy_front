import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/pages/home_pages/records_list_page.dart';
import 'package:my_fit_buddy/views/pages/home_pages/sessions_list_page.dart';
import 'package:my_fit_buddy/views/pages/home_pages/settings_page.dart';
import 'package:my_fit_buddy/views/themes/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final double _iconSize = 25.0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () => _onItemTapped(0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: _selectedIndex == 0 ? fitBlueDark : Colors.transparent,
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.home_outlined,
                    size: _iconSize,
                    color: _selectedIndex == 0 ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _onItemTapped(1),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: _selectedIndex == 1 ? fitBlueDark : Colors.transparent,
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.signal_cellular_alt,
                    size: _iconSize,
                    color: _selectedIndex == 1 ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _onItemTapped(2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: _selectedIndex == 2 ? fitBlueDark : Colors.transparent,
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.settings,
                    size: _iconSize,
                    color: _selectedIndex == 2 ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return const SessionsListPage();
      case 1:
        return const RecordsListPage();
      case 2:
        return const SettingsPage();
      default:
        return Container(
            color: fitCloudWhite, child: const CircularProgressIndicator());
    }
  }
}
