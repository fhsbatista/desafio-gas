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
    final storesAsList = json
        .map(
          (e) => Store(
            name: e['nome'],
            brand: Brand(e['tipo']),
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
          ),
        )
        .toList();
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

  const _Location({Key key, this.address}) : super(key: key);

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
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.red,
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Text(
                        store.brand.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Text(stores[index].name),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
