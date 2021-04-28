import 'dart:io';
import 'package:bitcoin_app/constants.dart';
import 'package:bitcoin_app/models/crypto_currency.dart';
import 'package:bitcoin_app/widgets/crypto_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _curencyValue = 'USD';
  Map<String, dynamic> _cryptoPrice;
  var bitcoinPrice;
  var ethereumPrice;
  var litecoinPrice;

  @override
  void initState() {
    super.initState();
    initGetCryptoCurrency();
  }

  void initGetCryptoCurrency() async {
    await getCryptoPrice();
    setCryptoPrice();
  }

  void setCryptoPrice() {
    setState(() {
      if(_cryptoPrice['bitcoin'] != null) {
        bitcoinPrice = _cryptoPrice['bitcoin'][_curencyValue.toLowerCase()].toString() + ' $_curencyValue';
      }
      if(_cryptoPrice['ethereum'] != null) {
        ethereumPrice = _cryptoPrice['ethereum'][_curencyValue.toLowerCase()].toString() + ' $_curencyValue';
      }
      if(_cryptoPrice['litecoin'] != null) {
        litecoinPrice = _cryptoPrice['litecoin'][_curencyValue.toLowerCase()].toString() + ' $_curencyValue';
      }
    });
  }

  void getListCriptoCurrency() async {
    var my = await CryptoCurrency().getListCriptoCurrency();
    var newList = [];
    for(var obj in my) {
      newList.add({'id': obj['id'], 'symbol': obj['symbol']});
    }
    print(newList);
    // _cryptoList = newList;
  }

  Future<void> getCryptoPrice() async {
    _cryptoPrice = await CryptoCurrency().getCriptoVsCurrency(['bitcoin', 'ethereum', 'litecoin'], currencie: _curencyValue);
  }

  Future<void> getCryptoPriceThenSet() async {
    await getCryptoPrice();
    setCryptoPrice();
  }

  DropdownButton androidDropdownButton() {
    var listDropdownItems = currenciesList.map((e) => DropdownMenuItem(child: Text(e), value: e,)).toList();
    return DropdownButton(
      value: _curencyValue,
      items: listDropdownItems,
      onChanged: (currencyValue) async {
        _curencyValue = currencyValue;
        await getCryptoPrice();
        setCryptoPrice();
      },
    );
  }

  NotificationListener iOSCupertinoPicker() {
    var listCupertinoItems = currenciesList.map((e) => Text(e, style: TextStyle(color: Colors.white),)).toList();
    return NotificationListener<ScrollEndNotification>(
      onNotification: (notification) {
        getCryptoPriceThenSet();
        return true;
      },
      child: CupertinoPicker(
        backgroundColor: Colors.blueAccent,
        scrollController: FixedExtentScrollController(initialItem: 0),
        magnification: 1.1,
        diameterRatio: 1.1,
        looping: true,
        itemExtent: 32.0, 
        onSelectedItemChanged: (index) {
          _curencyValue = currenciesList[index];
        }, 
        children: listCupertinoItems,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bitcoin'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: 
            _cryptoPrice == null
            ? [Center(child: CircularProgressIndicator())]
            : [
                CriptoContainer(criptoText: '1 BTC = $bitcoinPrice',),
                CriptoContainer(criptoText: '1 ETH = $ethereumPrice',),
                CriptoContainer(criptoText: '1 LTC = $litecoinPrice',),
                SizedBox(height: 4.0,),
                Container(
                  alignment: Alignment.center,
                  height: 150,
                  child: Platform.isIOS ? iOSCupertinoPicker() : androidDropdownButton(),
                ),
            ],
      ),
    );
    
  }
}


