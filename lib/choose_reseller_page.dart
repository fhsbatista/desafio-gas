import 'package:desafio_gas/margins.dart';
import 'package:desafio_gas/models/address.dart';
import 'package:desafio_gas/strings.dart';
import 'package:flutter/material.dart';

class ChooseResellerPage extends StatefulWidget {
  @override
  _ChooseResellerPageState createState() => _ChooseResellerPageState();
}

class _ChooseResellerPageState extends State<ChooseResellerPage> {
  Address currentLocation = Address('Av Paulista', 1001, 'Paulista', 'São Paulo', 'SP');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.chooseResellerStrings.title),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.search),
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
        ],
      ),
      body: Column(
        children: [_Location(address: currentLocation)],
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
                style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }
}
