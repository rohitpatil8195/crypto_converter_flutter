import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker_flutter/coin_data.dart';
import 'dart:io' show Platform;
import 'package:bitcoin_ticker_flutter/api_helper.dart';
class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}


class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency='USD';
   String? convertedValue='0';
  String? convertedValueEth='0';
  String? convertedValueLtc='0';
  List<String> currList=CoinData().currenciesList;

  DropdownButton<String> androidPicker(){
    return DropdownButton<String>(
      value: selectedCurrency,
      items: currList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedCurrency=value!;
        });
        getCurrData();
        getCurrDataEth();
        getCurrDataLtc();
      },);
  }

     CupertinoPicker iosPicker(){
       return CupertinoPicker(
         backgroundColor: Colors.lightBlue,
         itemExtent: 32.0,
         onSelectedItemChanged: (selectedIndex){
           setState(() {
             selectedCurrency=currList[selectedIndex];
           });
           getCurrData();
           getCurrDataEth();
           getCurrDataLtc();
         },
         children: currList.map((e) => Text(e)).toList(),
       );
     }

     Widget cardView(String type,String convertedCurrency){
     return  Card(
         color: Colors.lightBlueAccent,
         elevation: 5.0,
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(10.0),
         ),
         child:  Padding(
           padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
           child: Text(
             '1 $type = ''$convertedCurrency $selectedCurrency',
             textAlign: TextAlign.center,
             style: const TextStyle(
               fontSize: 20.0,
               color: Colors.white,
             ),
           ),
         ),
       );
     }

     ApiHelper apiHelper=ApiHelper();

     Future getCurrData()async{
       var curr=await apiHelper.getCalculation(selectedCurrency,CoinData().cryptoList[0]);
       var val=await curr['rate'];
       setState(() {
         convertedValue=(val).toString();
       });
     }

  Future getCurrDataEth()async{
    var curr=await apiHelper.getCalculation(selectedCurrency,CoinData().cryptoList[1]);
    var val=await curr['rate'];
    setState(() {
      convertedValueEth=(val).toString();
    });
  }
  Future getCurrDataLtc()async{
    var curr=await apiHelper.getCalculation(selectedCurrency,CoinData().cryptoList[2]);
    var val=await curr['rate'];
    setState(() {
      convertedValueLtc=(val).toString();
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrData();
    getCurrDataEth();
    getCurrDataLtc();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                cardView(CoinData().cryptoList[0],convertedValue!),
                const SizedBox(height: 10,),
                cardView(CoinData().cryptoList[1],convertedValueEth!),
                const SizedBox(height: 10,),
                cardView(CoinData().cryptoList[2],convertedValueLtc!)
              ],
            )
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding:const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child:Platform.isAndroid ? androidPicker(): iosPicker()
          ),
        ],
      ),
    );
  }
}


// child: DropdownButton<String>(
// value: selectedCurrency,
// items: currList.map<DropdownMenuItem<String>>((String value) {
// return DropdownMenuItem<String>(
// value: value,
// child: Text(value),
// );
// }).toList(),
// onChanged: (value) {
// setState(() {
// selectedCurrency=value!;
// });
// },),