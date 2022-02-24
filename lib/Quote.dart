import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ketto_quote/Models/Quote%20Model.dart';
import 'package:ketto_quote/Style.dart';

class Quote extends StatefulWidget {
  const Quote({Key? key}) : super(key: key);

  @override
  _QuoteState createState() => _QuoteState();
}

class _QuoteState extends State<Quote> {

  QuoteModel quote = QuoteModel();

  bool quoteLoading=true;


  getQuote() async{
    setState(() {
      quoteLoading=true;
    });    var response = await http.get(Uri.http('api.quotable.io', 'random'));
    var _quote = jsonDecode(response.body);
    quote = QuoteModel.fromJson(_quote);
    print('done');
    setState(() {
      quoteLoading=false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Quote',style: appBarTitle,),
        actions: [
          IconButton(onPressed: (){
            getQuote();
          }, icon: Icon(Icons.refresh_rounded,size: 30,))
        ],
      ),
      body: GestureDetector(
          onVerticalDragUpdate: (details) async {
            if (details.delta.dy < -0) {
              if (quoteLoading == false) {
                getQuote();
              }
            }
          },

        child: Container(
          color: backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: quoteLoading?Center(
              child: LinearProgressIndicator(
                backgroundColor: Colors.black87,
                valueColor: AlwaysStoppedAnimation(backgroundColor),
                minHeight: 20,
              ),
            ):quoteCenter(quote.content,quote.author),
            ),
        ),
      )
    );


  }
  Widget quoteCenter(String? quote,author){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$quote",
          style: TextStyle(fontSize: 23, color: primaryColor),
        ),
        SizedBox(
          height: 35,
        ),
        Align(
            alignment: Alignment.centerRight,
            child: Text("$author",
                style: TextStyle(
                    fontSize: 25,
                    color: primaryColor,
                    fontWeight: FontWeight.bold)))
      ],
    );
  }
}
