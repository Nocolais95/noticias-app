import 'package:flutter/material.dart';
import 'package:newsapp/src/services/news_services.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

// Para mantener el estado de la pagina cuando cambio a la otra y vuelvo
// Primero convertir en un Stateful
class Tab1Page extends StatefulWidget {
  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

// Agregar with AutomaticKeepAliveClientMixin para mantener el estado cambiando de pantallas
class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final newsServices = Provider.of<NewsServices>(context);
    return Scaffold(
      body: (newsServices.headLines.length == 0)
          ? Center(child: CircularProgressIndicator())
          : ListaNoticias(newsServices.headLines),
    );
  }

  @override
  // Poner en true
  bool get wantKeepAlive => true;
}
