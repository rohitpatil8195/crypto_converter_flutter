
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

const String url='https://rest.coinapi.io/v1/exchangerate/';

class ApiHelper{
final String _apiKey='Enter api key from https://www.coinapi.io/';
  Future getCalculation(excUnit,currType)async{
      http.Response response =await http.get(Uri.parse('${url+currType}/'+excUnit),
        headers: { HttpHeaders.authorizationHeader: _apiKey});
      if(response.statusCode==200){
        String data =response.body;
       return jsonDecode(data);
      }else{
      if(response.statusCode==429){
        print('Api key invalid');
      }
        print(response.statusCode);
      }

  }

}