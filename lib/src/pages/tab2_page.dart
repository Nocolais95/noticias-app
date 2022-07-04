import 'package:flutter/material.dart';

import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/services/news_services.dart';
import 'package:newsapp/src/theme/tema.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newService = Provider.of<NewsServices>(context);
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          _ListaCategorias(),
          Expanded(
            child: ListaNoticias(newService.getArticleCategorySelected),
          ),
        ],
      )),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsServices>(context).categories;
    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        // Esto hace que la animacion sea mejor
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          // Antes de capitalizar creamos una variable
          final catName = categories[index].name;
          return Container(
            width: 105,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  _CategoryButton(categories[index]),
                  SizedBox(height: 5),
                  // Esto es para capitalizar el nombre
                  Text('${catName[0].toUpperCase()}${catName.substring(1)}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category categoria;

  const _CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {
    final newService = Provider.of<NewsServices>(context);
    return GestureDetector(
      onTap: (() {
        // print(categoria.name);
        // Cuando el provider esta en un evento tap no se tiene que redibujar, por eso el listen en false
        final newService = Provider.of<NewsServices>(context, listen: false);
        newService.selectedCategory = categoria.name;
      }),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          categoria.icon,
          color: (newService.selectedCategory == categoria.name)
              ? miTema.colorScheme.secondary
              : Colors.black54,
        ),
      ),
    );
  }
}
