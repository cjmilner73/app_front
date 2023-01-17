import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:app/services/post_model.dart';
import 'dart:convert';

class HttpService {
  final String postsUrl =
      "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin%2Cethereum&vs_currencies=usd";
  final String postsPreUrl =
      "https://api.coingecko.com/api/v3/simple/price?ids=";
  final String postPostUrl = "&vs_currencies=usd";

  String formURL() {
    // Holdings holdings = new Holdings();
    String bodyUrl = "";

    // String postsUrl =
    //     "https://1jyqqpwi3m.execute-api.ap-southeast-1.amazonaws.com/api/holdings";
    String postsUrl = "http://127.0.0.1:5000/holdings";
    
    return postsUrl;
  }

  Future<List<Post>> getPosts() async {
    String postsUrl = formURL();
    Response res = await get(Uri.parse(postsUrl));
    // Check if running local server
    if (postsUrl == "http://127.0.0.1:5000/holdings") {
    if (res.statusCode == 200) {
      var hashMap = json.decode(res.body);
      Map<String, dynamic> m = Map<String, dynamic>.from(hashMap);
      print(m["holdings"]);
      var lists = m["holdings]"];
      print("List length");
      print(lists.runtimeType);
      List<Post> list = [];
      Post p = Post(id: '', price: 0.0, amount: 0, total: 0, day_change: 0.0);
      for (var i = 0; i < lists.length; i++) {
        String thisId = lists[i][1];
        double thisPrice = lists[i][3];
        int thisAmount = lists[i][2];
        double thisDayChange = lists[i][4];
        // ignore: unused_local_variable
        String newThisDayChange = thisDayChange.toStringAsFixed(3);
        p = Post(
            id: thisId,
            price: thisPrice,
            amount: thisAmount,
            total: thisAmount * thisPrice,
            day_change: thisDayChange);
        list.add(p);
        list.sort((a, b) => b.total.compareTo(a.total));
      }
      return list;
    } else {
      throw "Can't get posts.";
    } 
    } else {
    if (res.statusCode == 200) {
      var lists = json.decode(res.body);
      List<Post> list = [];
      Post p = Post(id: '', price: 0.0, amount: 0, total: 0, day_change: 0.0);
      for (var i = 0; i < lists.length; i++) {
        String thisId = lists[i][1];
        double thisPrice = lists[i][3];
        int thisAmount = lists[i][2];
        double thisDayChange = lists[i][4];
        // ignore: unused_local_variable
        String newThisDayChange = thisDayChange.toStringAsFixed(3);
        p = Post(
            id: thisId,
            price: thisPrice,
            amount: thisAmount,
            total: thisAmount * thisPrice,
            day_change: thisDayChange);
        list.add(p);
        list.sort((a, b) => b.total.compareTo(a.total));
      }
      return list;
    } else {
      throw "Can't get posts.";
    }
  }
  }
  Future<List<Post>> getOHCL() async {
    String postsUrl = formURL();
    Response res = await get(Uri.parse(postsUrl));
    if (res.statusCode == 200) {
      var lists = json.decode(res.body);
      List<Post> list = [];
      Post p = Post(id: '', price: 0.0, amount: 0, total: 0, day_change: 0.0);
      for (var i = 0; i < lists.length; i++) {
        String thisId = lists[i][1];
        double thisPrice = lists[i][3];
        int thisAmount = lists[i][2];
        double thisDayChange = lists[i][4];
        String newThisDayChange = thisDayChange.toStringAsFixed(3);
        p = Post(
            id: thisId,
            price: thisPrice,
            amount: thisAmount,
            total: thisAmount * thisPrice,
            day_change: thisDayChange);
        list.add(p);
        list.sort((a, b) => b.total.compareTo(a.total));
      }
      List newList = [1,1,3,4];
      // return newList;
      return list;
    } else {
      throw "Can't get posts.";
    }
  }
}
