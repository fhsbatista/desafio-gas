import 'dart:convert';

import 'package:desafio_gas/margins.dart';
import 'package:desafio_gas/models/address.dart';
import 'package:desafio_gas/models/brand.dart';
import 'package:desafio_gas/models/store.dart';
import 'package:desafio_gas/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChooseResellerPage extends StatefulWidget {
  @override
  _ChooseResellerPageState createState() => _ChooseResellerPageState();
}

class _ChooseResellerPageState extends State<ChooseResellerPage> {
  Address currentLocation =
      Address('Av Paulista', 1001, 'Paulista', 'São Paulo', 'SP');

  List<Store> stores = [];

  Future _initializeStores() async {
    final List json =
        jsonDecode(await rootBundle.loadString('assets/dados.json'));
    final storesAsList = json.map(
      (e) {
        final int? colorInt = int.tryParse(e['cor'], radix: 16);
        final color = Color(6208125);
        // final color = Color(colorInt ?? Colors.black.value);
        return Store(
          name: e['nome'],
          brand: Brand(name: e['tipo'], color: color),
          rating: e['nota'],
          averageDeliveryTime: DeliveryTime(
            min: int.parse(
              e['tempoMedio'].toString().split('-')[0],
            ),
            max: int.parse(
              e['tempoMedio'].toString().split('-')[1],
            ),
          ),
          price: e['preco'],
          isBestPrice: e['melhorPreco'],
        );
      },
    ).toList();
    setState(() {
      stores = storesAsList;
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeStores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.chooseResellerStrings.title),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.filter_alt),
            onSelected: null,
            itemBuilder: (_) => <PopupMenuItem>[
              PopupMenuItem(
                value: 0,
                child: Text(Strings.chooseResellerStrings.mostHighRating),
              ),
              PopupMenuItem(
                value: 1,
                child: Text(Strings.chooseResellerStrings.mostFast),
              ),
              PopupMenuItem(
                value: 2,
                child: Text(Strings.chooseResellerStrings.mostCheap),
              )
            ],
          ),
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          _Location(address: currentLocation),
          Expanded(child: _Stores(stores)),
        ],
      ),
    );
  }
}

class _Location extends StatelessWidget {
  final Address address;

  const _Location({
    Key? key,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(kMarginDefault),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.chooseResellerStrings.gasLocation,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                '${address.address}, ${address.number}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
              ),
              Text(
                '${address.neighbourhood}, ${address.neighbourhood}, ${address.state}',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Icon(
                Icons.location_on,
                color: Theme.of(context).primaryColor,
              ),
              Text(
                Strings.chooseResellerStrings.changeAddress,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 12,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _Stores extends StatelessWidget {
  final List<Store> stores;

  _Stores(this.stores);

  TextStyle get defaultStyleForStoreInfo {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stores.length,
      itemBuilder: (_, index) {
        final store = stores[index];
        return Padding(
          padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 120,
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    color: store.brand.color,
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Center(
                        child: Text(
                          store.brand.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Text(
                                  store.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Visibility(
                                visible: store.isBestPrice,
                                child: _BestPrice(),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _StoreInfoText(
                                  title: 'Nota',
                                  child: Text(
                                    '${store.rating}',
                                    style: defaultStyleForStoreInfo,
                                  ),
                                ),
                                _StoreInfoText(
                                  title: 'Tempo Médio',
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${store.averageDeliveryTime}',
                                        style: defaultStyleForStoreInfo,
                                      ),
                                      Text('min'),
                                    ],
                                  ),
                                ),
                                _StoreInfoText(
                                  title: 'Preço',
                                  child: Text(
                                    store.formattedPrice,
                                    style: defaultStyleForStoreInfo,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StoreInfoText extends StatelessWidget {
  final String title;
  final Widget child;

  _StoreInfoText({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _BestPrice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.orange,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.label,
            color: Colors.white,
          ),
          Text(
            'Melhor Preço',
            style: TextStyle(color: Colors.white, fontSize: 8.0),
          ),
        ],
      ),
    );
  }
}
