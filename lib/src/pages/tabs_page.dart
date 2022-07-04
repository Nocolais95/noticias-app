import 'package:flutter/material.dart';
import 'package:newsapp/src/pages/tab1_page.dart';
import 'package:newsapp/src/pages/tab2_page.dart';
import 'package:newsapp/src/services/news_services.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Esta es la forma para crear la instancia de mi clase
      create: (_) => _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Recordar que el context es un objeto que tiene toda la informacion de mi arbol de widgets,
    // por ende hay que buscar la instancia del provider, la que nosotros creamos

    final navegacionModel = Provider.of<_NavegacionModel>(context);
    final newServices = Provider.of<NewsServices>(context);
    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (i) => navegacionModel.paginaActual = i,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: 'Para ti'),
        BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Encabezados'),
      ],
    );
  }
}

class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return PageView(
      controller: navegacionModel.pageController,
      // Esto hace que tenga una animacion
      // physics: BouncingScrollPhysics(),
      // Pero usamos esta para que el usuario no pueda mover, sino que tenga que usar el botton bar de abajo
      physics: NeverScrollableScrollPhysics(),
      children: [
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;
  PageController _pageController = new PageController();

  // Esto es para llamar esta instancia y pueda ver el valor
  int get paginaActual => this._paginaActual;

  set paginaActual(int valor) {
    this._paginaActual = valor;
    _pageController.animateToPage(
      valor,
      duration: Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
