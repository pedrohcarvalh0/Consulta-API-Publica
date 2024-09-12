import 'package:flutter/material.dart';

import '../data/models/produto_model.dart';
import 'product_list_item.dart';

class ProductListView extends StatelessWidget {
  final List<ProdutoModel> produtos;
  final bool isLoading;
  final String erro;

  const ProductListView({
    super.key,
    required this.produtos,
    required this.isLoading,
    required this.erro,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (erro.isNotEmpty) {
      return Center(
        child: Text(
          erro,
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (produtos.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum produto encontrado',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      padding: const EdgeInsets.all(16),
      itemCount: produtos.length,
      itemBuilder: (_, index) => ProductListItem(produto: produtos[index]),
    );
  }
}
