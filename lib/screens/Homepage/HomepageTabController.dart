import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educa/screens/Homepage/ExerciciosAlfabeto.dart';
import 'package:educa/screens/Homepage/ExerciciosNumeros.dart';
import 'package:educa/screens/Homepage/Perfil.dart';
import 'package:educa/screens/Splashscreen.dart';
import 'package:educa/widgets/drawer/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomepageTabController extends StatefulWidget {
  @override
  _HomepageTabControllerState createState() => _HomepageTabControllerState();
}

class _HomepageTabControllerState extends State<HomepageTabController> {
  int _selectedPageIndex;

  void initState() {
    _selectedPageIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return FutureBuilder(
        future:
            FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else {
            return _buildPage(snapshot.data.data());
          }
        });
  }

  Widget _buildPage(Map<String, dynamic> user) {
    List<Map<String, Object>> _pages;

    _pages = [
      {'page': ExerciciosAlfabeto(), 'title': 'Alfabeto'},
      {'page': ExerciciosNumeros(), 'title': 'Matemática'},
      {
        'page': Perfil(user['username'], user['email'], user['image_url']),
        'title': 'Perfil'
      }
    ];

    return DefaultTabController(
      length: _pages.length,
      child: Scaffold(
        appBar: AppBar(
          title: _appBarTitle(),
          centerTitle: true,
        ),
        drawer: AppDrawer(),
        body: _pages[_selectedPageIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              _selectedPageIndex = index;
            });
          },
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.yellow,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.sort_by_alpha),
              label: _pages[0]['title'],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.calculate),
              label: _pages[1]['title'],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: _pages[2]['title'],
            ),
          ],
        ),
      ),
    );
  }

  Widget _appBarTitle() {
    Widget result;

    switch (_selectedPageIndex) {
      case 0:
        result = Padding(
          padding: const EdgeInsets.only(left: 88),
          child: Row(
            children: [
              const Icon(
                Icons.star,
                color: Colors.yellow,
              ),
              Text('0')
            ],
          ),
        );
        break;
      case 1:
        result = Padding(
          padding: const EdgeInsets.only(left: 88),
          child: Row(
            children: [
              const Icon(
                Icons.mode_outlined,
                color: Colors.yellow,
              ),
              Text('0')
            ],
          ),
        );
        break;
      case 2:
        result = const Text('Seu Perfil');
        break;
      default:
        result = const Text('Erro!');
        break;
    }

    return result;
  }
}
