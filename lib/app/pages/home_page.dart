import 'package:flutter/material.dart';

import '../components/product_list_view.dart';
import '../components/product_search_bar.dart';
import '../data/http/http_client.dart';
import '../data/models/produto_model.dart';
import '../data/repositories/produto_repository.dart';
import 'produto_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProdutoStore store = ProdutoStore(
    repository: ProdutoRepository(
      client: HttpClient(),
    ),
  );

  final TextEditingController searchController = TextEditingController();
  List<ProdutoModel> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    store.getProdutos().then((_) {
      setState(() {
        filteredProducts = store.state.value;
      });
    });
    searchController.addListener(_filterProducts);
  }

  void _filterProducts() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredProducts = store.state.value.where((produto) {
        return produto.title.toLowerCase().contains(query) ||
            produto.description.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Consumo de APIs',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          ProductSearchBar(controller: searchController),
          Expanded(
            child: AnimatedBuilder(
              animation:
                  Listenable.merge([store.isLoading, store.erro, store.state]),
              builder: (context, child) {
                return ProductListView(
                  produtos: filteredProducts,
                  isLoading: store.isLoading.value,
                  erro: store.erro.value,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
