import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

final String apiKey = 'OJCgY1o35ki5cVHsPNLRxB2Y6bIVdvTPABDzdzF0KEgDXwzBXFRmDCNw';

class ApiServices {
  Future<http.Response> getCuratedWallpapers() async{
    
    final response = await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=10'), headers: {
      'Authorization' : 'OJCgY1o35ki5cVHsPNLRxB2Y6bIVdvTPABDzdzF0KEgDXwzBXFRmDCNw'
    });

    return response;
  }

  Future<http.Response> getSearchWallpapers(String searchQuery) async {
    final response = await http.get(Uri.parse('https://api.pexels.com/v1/search?query=$searchQuery&per_page=20'), headers: {
      'Authorization': 'OJCgY1o35ki5cVHsPNLRxB2Y6bIVdvTPABDzdzF0KEgDXwzBXFRmDCNw'
    });

    return response;
  }
}