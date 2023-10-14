import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping_list/model/items_model.dart';
import 'package:shopping_list/utils.dart';

class NewListScreen extends StatefulWidget {
  static const routeName = '/new_list_screen';
  const NewListScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<NewListScreen> createState() => _NewListScreenState();
}

class _NewListScreenState extends State<NewListScreen> {
  TextEditingController item = TextEditingController();
  TextEditingController itemPrice = TextEditingController();
  TextEditingController itemQnty = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<String> listItems = [];
  // int amountQnty = 1;
  // int amountPrice = 0;
  int prod = 0;
  String formattedPrice = "";
  String formattedProd = "";
  int num = 0;
  int grandTotal = 0;
  String formattedGrandTotal = "";
  late FocusNode _focusNode;

  void _scrollToBottom() {
    // _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    // _scrollController.jumpTo(_scrollController.position.minScrollExtent);
    _scrollController.animateTo(
      5000.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _focusNode.unfocus();
      }
    });
  }
  String formatNumber(int number) {
    final format = NumberFormat("#,###", "en_US");
    return format.format(number);
  }
  List<Widget> _buildListItems(int index) {
    List<Widget> widgets = [];
    for (int index = 0; index < ListItems.allItems.length; index++) {
      // Build your list item widgets here
      widgets.add(Column(
        children: [
          Container(
            height:
            MediaQuery.of(context).size.height * .03,
            padding: EdgeInsets.fromLTRB(
              pageWidth(context) * .0,
              pageHeight(context) * .0,
              pageWidth(context) * .0,
              pageHeight(context) * .0,
            ),
            margin: EdgeInsets.fromLTRB(
              pageWidth(context) * .02,
              pageHeight(context) * .001,
              pageWidth(context) * .02,
              pageHeight(context) * .00,
            ),
            // color: Colors.greenAccent,
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                        width: pageWidth(context) * .08,
                        // color: Colors.yellow,
                        child: Text(
                            "${ListItems.allItems[index].num}.")),
                  ],
                ),
                Column(
                  children: [
                    Container(
                        width: pageWidth(context) * .3,
                        // color: Colors.purple,
                        child: Text(ListItems
                            .allItems[index].item)),
                  ],
                ),
                Column(
                  children: [
                    Container(
                        width: pageWidth(context) * .2,
                        // color: Colors.purple,
                        child: Text(
                            ListItems.allItems[index].formattedPrice)),
                  ],
                ),
                Column(
                  children: [
                    Container(
                        width: pageWidth(context) * .1,
                        // color: Colors.yellow,
                        child: Text(ListItems
                            .allItems[index].itemQnty)),
                  ],
                ),
                Column(
                  children: [
                    Container(
                        width: pageWidth(context) * .28,
                        // color: Colors.yellow,
                        child: Text(
                            ListItems.allItems[index].formattedProd)),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            thickness: .2,
            color: Colors.grey,
          )
        ],
      ));
      if(index+1 == ListItems.allItems.length){
        widgets.add(Column(
          children: [
            Container(
              // color: Colors.grey,
                padding: EdgeInsets.fromLTRB(
                  pageWidth(context) * .02,
                  pageHeight(context) * .0,
                  pageWidth(context) * .02,
                  pageHeight(context) * .0,
                ),
                height: pageHeight(context) * .03,
                child: Text(
                  "GrandTotal ₦${ListItems.allItems[index].formattedGrandTotal}",
                  style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                )),
            const Divider(
              thickness: .2,
              color: Colors.red,
            )
          ],
        ));
      }
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListItems.allItems.isEmpty
                ? const SizedBox()
                : Container(
                    color: Colors.grey,
                    padding: EdgeInsets.fromLTRB(
                      pageWidth(context) * .02,
                      pageHeight(context) * .0,
                      pageWidth(context) * .02,
                      pageHeight(context) * .0,
                    ),
                    height: pageHeight(context) * .03,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                                width: pageWidth(context) * .08,
                                // color: Colors.grey,
                                child: const Text("s/n")),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                                width: pageWidth(context) * .3,
                                // color: Colors.grey,
                                child: const Text("Description")),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                                width: pageWidth(context) * .2,
                                // color: Colors.grey,
                                child: const Text("Price (₦)")),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                                width: pageWidth(context) * .1,
                                // color: Colors.grey,
                                child: const Text("Qnty")),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                                width: pageWidth(context) * .28,
                                // color: Colors.grey,
                                child: const Text("Total(₦)")),
                          ],
                        ),
                      ],
                    ),
                  ),
            Expanded(
              child: Container(
                height: 350,
                child: ListItems.allItems.isEmpty
                    ? const Center(
                        child:
                            Text("Empty List, enter items to create a List."))
                    : ListView.builder(
                        controller: _scrollController,
                        reverse: false,
                        // itemCount: ListItems.allItems.length,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          // if(index < ListItems.allItems.length) {
                          //   return Column(
                          //     children: [
                          //       Container(
                          //           // color: Colors.grey,
                          //           padding: EdgeInsets.fromLTRB(
                          //             pageWidth(context) * .02,
                          //             pageHeight(context) * .0,
                          //             pageWidth(context) * .02,
                          //             pageHeight(context) * .0,
                          //           ),
                          //           height: pageHeight(context) * .03,
                          //           child: Text(
                          //             "Total ₦${ListItems.allItems[index].formattedGrandTotal}",
                          //             style: const TextStyle(
                          //                 fontSize: 14.0,
                          //                 fontWeight: FontWeight.bold),
                          //           )),
                          //       const Divider(
                          //         thickness: .2,
                          //         color: Colors.red,
                          //       )
                          //     ],
                          //   );
                          // } else {
                            return Column(
                              children: _buildListItems(index),
                            );
                            return Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * .03,
                                  padding: EdgeInsets.fromLTRB(
                                    pageWidth(context) * .0,
                                    pageHeight(context) * .0,
                                    pageWidth(context) * .0,
                                    pageHeight(context) * .0,
                                  ),
                                  margin: EdgeInsets.fromLTRB(
                                    pageWidth(context) * .02,
                                    pageHeight(context) * .001,
                                    pageWidth(context) * .02,
                                    pageHeight(context) * .00,
                                  ),
                                  // color: Colors.greenAccent,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                              width: pageWidth(context) * .08,
                                              // color: Colors.yellow,
                                              child: Text(
                                                  "${ListItems.allItems[index].num}.")),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                              width: pageWidth(context) * .3,
                                              // color: Colors.purple,
                                              child: Text(ListItems
                                                  .allItems[index].item)),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                              width: pageWidth(context) * .1,
                                              // color: Colors.yellow,
                                              child: Text(ListItems
                                                  .allItems[index].itemQnty)),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                              width: pageWidth(context) * .2,
                                              // color: Colors.purple,
                                              child: Text(
                                                  ListItems.allItems[index].formattedPrice)),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                              width: pageWidth(context) * .28,
                                              // color: Colors.yellow,
                                              child: Text(
                                                  ListItems.allItems[index].formattedProd)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  thickness: .2,
                                  color: Colors.red,
                                )
                              ],
                            );
                          // }
                        }),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: pageWidth(context) * .02),
              child: Row(
                children: [
                  Expanded(
                    flex: 9,
                    child: TextField(
                      controller: item,
                      maxLength: 18,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        counter: SizedBox(),
                          filled: true,
                          fillColor: Colors.greenAccent,
                          hintText: "Enter Item"),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: itemQnty,
                      maxLength: 3,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        counter: SizedBox(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                          filled: true,
                          fillColor: Colors.yellow,
                          hintText: "Qnty"),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: itemPrice,
                      maxLength: 7,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        counter: SizedBox(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 2.5),
                          filled: true,
                          fillColor: Colors.red,
                          hintText: "   price"),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          num += 1;
                          prod = (int.tryParse(itemQnty.text)!) * (int.tryParse(itemPrice.text)!);
                          grandTotal += prod;
                          formattedPrice = formatNumber(int.tryParse(itemPrice.text)!);
                          formattedProd = formatNumber(prod);
                          formattedGrandTotal = formatNumber(grandTotal);
                          debugPrint(num.toString());
                          debugPrint(item.text);
                          debugPrint(itemPrice.text);
                          debugPrint(itemQnty.text);
                          debugPrint(prod.toString());
                          for (var items in ListItems.allItems) {
                            print("${items.num} ${items.item} ${items.itemQnty}"
                                "${items.formattedPrice} ${items.formattedProd}");
                          }
                          debugPrint(formattedGrandTotal.toString());
                          ListItems.allItems.add(ListItems(
                            num: num,
                            item: item.text,
                            itemPrice: itemPrice.text,
                            itemQnty: itemQnty.text,
                            prod: prod.toString(),
                            grandTotal: grandTotal,
                            formattedPrice: formattedPrice,
                            formattedProd: formattedProd,
                            formattedGrandTotal: formattedGrandTotal,
                          ));
                          // debugPrint(ListItems.allItems.map((e) => e.item).toString());
                          // debugPrint(ListItems.allItems.map((e) => e.itemPrice).toString());
                          // debugPrint(ListItems.allItems.map((e) => e.itemQnty).toString());
                          // debugPrint(ListItems.allItems.map((e) => e.prod).toString());
                          item.clear();
                          itemQnty.clear();
                          itemPrice.clear();
                          _scrollToBottom();
                        });
                      },
                      icon: const Icon(Icons.send),
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size(50, 50)),
                          maximumSize: MaterialStateProperty.all<Size>(
                              const Size(50, 50)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    item.dispose();
    itemQnty.dispose();
    itemPrice.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
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
        );
      },
    );
  }
}
