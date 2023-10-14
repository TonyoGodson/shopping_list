import 'package:flutter/material.dart';
import 'package:shopping_list/features/new_list_screen.dart';
import 'package:shopping_list/utils.dart';

class AllListsScreen extends StatefulWidget {
  static const routeName = '/all_list_screen';
  const AllListsScreen({Key? key}) : super(key: key);

  @override
  State<AllListsScreen> createState() => _AllListsScreenState();
}

class _AllListsScreenState extends State<AllListsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Lists"), centerTitle: true,),
      body: ListView(
        children: [
          Container(
            height: pageHeight(context) * .8,
            width: pageWidth(context),
            // color: Colors.greenAccent,
            child: ListView.builder(
              itemCount: 10,
                padding: EdgeInsets.only(bottom:
                    pageHeight(context) * .05),
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: (){
                        Navigator.of(context).pushNamed(NewListScreen.routeName);
                    },
                    child: Container(
                      width: pageWidth(context),
                      height: pageHeight(context) * .1,
                      padding: EdgeInsets.fromLTRB(
                          pageWidth(context) * .03,
                          pageHeight(context) * .01,
                          pageWidth(context) * .03,
                          pageHeight(context) * .0),
                      margin: EdgeInsets.fromLTRB(
                          pageWidth(context) * .03,
                          pageHeight(context) * .03,
                          pageWidth(context) * .03,
                          pageHeight(context) * .0),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 3),
                            spreadRadius: 0.0,
                            blurRadius: 6.0,
                            color: Color(0xFFD2D0CE)
                          )
                        ]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Title", style: TextStyle(fontSize: 18),),
                          SizedBox(height: pageHeight(context) * .01,),
                          Row(
                            children: [
                              Text("Created on:"),
                              SizedBox(width: pageWidth(context) * .2,),
                              Text("Edited on:")
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 80, right: 20), // Adjust margin for the position
        child: FloatingActionButton(
          onPressed: () {
            // Add your onPressed logic here
            print('Floating action button pressed');
            _openBottomSheet(context);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your text here',
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Handle the input
                      Navigator.pop(context);
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
