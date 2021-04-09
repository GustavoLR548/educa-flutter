import 'package:educa/provider/auth.dart';
import 'package:educa/screens/Homepage/ExerciciosAlfabeto.dart';
import 'package:educa/screens/Homepage/ExerciciosNumeros.dart';
import 'package:educa/screens/Homepage/Perfil.dart';
import 'package:educa/widgets/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomepageTabController extends StatefulWidget {
  static const routeName = '/homepage';
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
    final userData = Provider.of<Auth>(context).currUser;
    List<Map<String, Object>> _pages;
    _pages = [
      {'page': ExerciciosAlfabeto(userData['exercises']), 'title': 'Alfabeto'},
      {'page': ExerciciosNumeros(userData['exercises']), 'title': 'Matemática'},
      {
        'page': Perfil(userData['username'], userData['email'],
            userData['image_url'], userData['alph'], userData['math']),
        'title': 'Perfil'
      }
    ];
    return DefaultTabController(
      length: _pages.length,
      child: Scaffold(
        appBar: AppBar(
          title: _appBarTitle(
              _selectedPageIndex == 0 ? userData['alph'] : userData['math']),
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

  Widget _appBarTitle(int points) {
    Widget result;
    String pontuacao = points.toString() == 'null' ? '0' : points.toString();
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
              Text(pontuacao)
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
              Text(pontuacao)
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
