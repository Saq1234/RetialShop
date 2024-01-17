import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:slider_button/slider_button.dart';


class OrderPage extends StatefulWidget {
String? name;
String? productId;
int? quantity;

OrderPage({this.name,this.productId,this.quantity});

 @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  var respnse="";
  void showFullScreenPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          // Full-screen container
          child: Container(
            height: 200,
            width: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ' Your Order is Placed\nThank You for Shopping  😊',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 20.0),
                GestureDetector(
                  onTap: (){
                   // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Dashboard()));
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.green,

                    ),
                    width: double.infinity,
                    child:
                    Center(child: Text('ok',style: TextStyle(color: Colors.white,fontSize: 20),)),
                  ),
                )

              ],
            ),
          ),
        );
      },
    );
  }
  void noData(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          // Full-screen container
          child: Container(
            height: 200,
            width: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ' Your dont have sufficident quantity to make order  😊',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 20.0),
                GestureDetector(
                  onTap: (){
                   // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Dashboard()));
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.green,

                    ),
                    width: double.infinity,
                    child:
                    Center(child: Text('ok',style: TextStyle(color: Colors.white,fontSize: 20),)),
                  ),
                )

              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("Orders"),
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 18),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black)
            ),
            height: 200,
            width: double.infinity,
            child: Image.network("https://i.pinimg.com/originals/ce/56/99/ce5699233cbc0f142250b520d967dff7.png",fit: BoxFit.cover,),

          ),
          Card(
            elevation: 10,
            margin: EdgeInsets.only(top: 30,left: 10,right: 10),
            child: ListTile(
              title: Text('productName: ${widget.name?? "No Data"}',style: TextStyle(fontSize: 20),),
              subtitle: Text('availableQuantity: ${widget.quantity??"No Data"}',style: TextStyle(fontSize: 18),),

            ),
          ),
      SizedBox(
        height: MediaQuery.of(context).size.height/3.3,
      ),
      Padding(
        padding: EdgeInsets.only(left: 10,right: 10),
        child: SliderButton(
          buttonColor: Colors.transparent,

          backgroundColor: Colors.green,
          alignLabel: Alignment.center,
          width: double.infinity,
          action: () async{
            postData();
            if(respnse==200){
              showFullScreenPopup(context);
            }
            else{
              noData(context);
            }
            return true;
            },
          label: Text(
            "Slide to Make your Order",
            style: TextStyle(
                color: Color(0xff4a4a4a), fontWeight: FontWeight.w500, fontSize: 20),
          ),
          icon: Image.asset("assets/image/tick.png")
        ),
      )
        ],
      ),
    );
  }

  Future<void> postData() async {
    final String apiUrl = 'https://uiexercise.theproindia.com/api/Product';

    // Replace this with your actual JSON payload
    final Map<String, dynamic> requestBody = {
      'orderId': widget.productId,
      'customerId':widget.productId,
      'productId': widget.productId,
      'quantity': widget.quantity,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, handle the response here
        respnse=response.statusCode.toString();
        print('POST Response: ${response.body}');
      } else {
        // If the server did not return a 200 OK response, throw an exception
        print('Failed to make a POST request. Status code: ${response.statusCode}');
        // Optionally, you can show an error message to the user.
      }
    } catch (e) {
      // Handle exceptions that may occur during the API call
      print('Error making POST request: $e');
      // Optionally, you can show an error message to the user.
    }
  }
}

