import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:retailshop/Dashboard/OrderPage/order_page.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://uiexercise.onemindindia.com/api/Product'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON data
      List<dynamic> jsonData = jsonDecode(response.body);
      setState(() {
        data = jsonData;
        print("output>>$data");
      });
    } else {
      // If the server did not return a 200 OK response, throw an exception
      throw Exception('Failed to load data');
    }
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text("Online retail shop"),
          titleTextStyle: TextStyle(color: Colors.white,fontSize: 18),
        ),
        body: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: Image.network("https://i.pinimg.com/originals/ce/56/99/ce5699233cbc0f142250b520d967dff7.png",fit: BoxFit.cover,),

            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: data.isEmpty
                    ? CircularProgressIndicator() // Show loading indicator while fetching data
                    : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderPage(
                              name: data[index]['productName'],productId:data[index]['productId'],quantity:data[index]['availableQuantity']  ,
                            )));
                          },
                          child: Card(
                          child: ListTile(
                            title: Text('productName: ${data[index]["productName"]?? "No Data"}',style: TextStyle(fontSize: 20),),
                            subtitle: Text('availableQuantity: ${data[index]["availableQuantity"]}',style: TextStyle(fontSize: 18),),
                            trailing: Icon(Icons.chevron_right),

                          ),
                    ),
                        ),
                      );
                  },

                ),
              ),
            ),
          ],
        ),
      ),
      );

  }
}
