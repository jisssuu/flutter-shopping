import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart'; // 불러온 이미지를 cache에 저장해서 다시 불로오기 편함
import 'package:flutter_shoppingapp/item_basket_page.dart';
import 'package:intl/intl.dart'; // 상품의 가격이 100000원이라면, 100,000원으로 보기 좋게 만드는데 용이
import 'package:flutter_shoppingapp/models/product.dart';
import './constants.dart';

class ItemDetailsPage extends StatefulWidget {
  int productNo;
  String productName;
  String productImageUrl;
  double price;

  ItemDetailsPage(
      {super.key,
      required this.productNo,
      required this.productName,
      required this.productImageUrl,
      required this.price});

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("제품 상세 페이지"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            productImageContainer(),
            productNameContainer(),
            productPriceContainer(),
            productQuantityContainer(),
            productTotalPriceContainer()
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: FilledButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const ItemBasketPage();
            }));
          },
          child: const Text("장바구니 담기"),
        ),
      ),
    );
  }

  Container productPriceContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        "${numberFormat.format(widget.price)}원",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Container productNameContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        widget.productName,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget productImageContainer() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(15),
      child: CachedNetworkImage(
        width: MediaQuery.of(context).size.width * 0.8,
        imageUrl: widget.productImageUrl,
        placeholder: (context, url) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        },
        errorWidget: (context, url, error) {
          return const Center(
            child: Text("오류 발생"),
          );
        },
      ),
    );
  }

  Widget productQuantityContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("수량: "),
          IconButton(
              onPressed: () {
                setState(() {
                  if (quantity > 1) {
                    quantity--;
                  }
                });
              },
              icon: const Icon(
                Icons.remove,
                size: 24,
              )),
          Text("$quantity"),
          IconButton(
              onPressed: () {
                setState(() {
                  quantity++;
                });
              },
              icon: const Icon(
                Icons.add,
                size: 24,
              )),
        ],
      ),
    );
  }
  Widget productTotalPriceContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("총 상품금액: ", style: TextStyle(fontWeight: FontWeight.bold),),
          Text("${numberFormat.format(widget.price * quantity)}원", style: TextStyle(fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
