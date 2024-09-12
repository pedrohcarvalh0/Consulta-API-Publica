import 'package:flutter/material.dart';
import '../data/models/produto_model.dart';
import '../pages/product_details_page.dart';

class ProductListItem extends StatefulWidget {
  final ProdutoModel produto;

  const ProductListItem({super.key, required this.produto});

  @override
  _ProductListItemState createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegar para a página de detalhes ao clicar
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(produto: widget.produto),
          ),
        );
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = MediaQuery.of(context).size.width;

          return MouseRegion(
            onEnter: (_) {
              setState(() {
                _isHovering = true;
              });
            },
            onExit: (_) {
              setState(() {
                _isHovering = false;
              });
            },
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                transform: Matrix4.identity()..scale(_isHovering ? 1.05 : 1.0),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.all(25),
                margin: EdgeInsets.symmetric(
                  vertical: _isHovering ? 20 : 10,
                  horizontal: _isHovering ? 15 : 5,
                ),
                constraints: BoxConstraints(
                  maxWidth: screenWidth * 0.8,
                  minWidth: 200,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.produto.thumbnail,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.produto.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'R\$ ${widget.produto.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 31, 0, 207),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.produto.description,
                      style: const TextStyle(fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
