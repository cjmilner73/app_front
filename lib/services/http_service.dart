import 'package:http/http.dart';
import 'package:app/services/post_model.dart';
import 'dart:convert';

class HttpService {
  final String postsUrl =
      "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin%2Cethereum&vs_currencies=usd";
  final String postsPreUrl =
      "https://api.coingecko.com/api/v3/simple/price?ids=";
  final String postPostUrl = "&vs_currencies=usd";
  //String postsUrl = "";
  // bitcoin%2Cethereum&vs_currencies=usd

  String formURL() {
    // Holdings holdings = new Holdings();
    String bodyUrl = "";

    // Map thisHoldings = holdings.getHoldings();

    // for (var v in thisHoldings.keys) {
    //   if (v.toString() == "aave") {
    //     bodyUrl = bodyUrl + v + "&";
    //   } else {
    //     bodyUrl = bodyUrl + v + "%2C";
    //   }
    // }

    // bodyUrl = bodyUrl.substring(0, bodyUrl.length - 1);
    // String postsUrl = postsPreUrl + bodyUrl + postPostUrl;
    // String postsUrl = "http://127.0.0.1:5000/holdings";
    String postsUrl =
        "https://32rse7u512.execute-api.ap-southeast-1.amazonaws.com/api/holdings";
    //"https://32rse7u512.execute-api.ap-southeast-1.amazonaws.com/api/refresh";
    // print(postsUrl);
    return postsUrl;
  }

  Future<List<Post>> getPosts() async {
    String postsUrl = formURL();
    Response res = await get(Uri.parse(postsUrl));
    print(res.statusCode);
    if (res.statusCode == 200) {
      //print(postsUrl);
      print(res.body);
      // NEXT CODE JUST FOR AURORA CALL
      var lists = json.decode(res.body);
      List<Post> list = [];
      print("PRINT LIST FROM AURORA");
      print(" ");
      print(lists);
      for (var i = 0; i < lists.length; i++) {
        print(lists[i]);
      }

      // Map<String, dynamic> mymap = jsonDecode(res.body);

      // // print(mymap);
      // List<Post> list = [];
      // List myList = mymap['holdings'];
      // print(myList);

      Post p = Post(id: '', price: 0.0, amount: 0, total: 0, day_change: 0.0);

      for (var i = 0; i < lists.length; i++) {
        // String thisId = myList[i]['id'];
        // double thisPrice = myList[i]['last_price'];
        // int thisAmount = myList[i]['amount'];
        // double thisDayChange = myList[i]['day_change'];
        // String newThisDayChange = thisDayChange.toStringAsFixed(3);
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

      // mymap.forEach((k, v) {
      //   double thisPrice = v['usd'].toDouble();
      //   String thisId = k;
      //   p = Post(id: thisId, price: thisPrice);
      //   list.add(p);
      //   list.sort((a, b) => b.price.compareTo(a.price));
      //   // list.sort((a, b) => a.price.compareTo(b.price));
      //   // list.sort();
      // });
      // list.forEach((element) {
      //   print(element.id);
      // });
      // List<dynamic> mbody = jsonDecode(res.body);
      // print(mbody.toString());

      // List<Post> posts =
      //     mbody.map((dynamic item) => Post.fromJson(item)).toList();
      // print("Posts list: " + list.toString());
      return list;
    } else {
      print("Error getting posts.");
      throw "Can't get posts.";
    }
  }
}
