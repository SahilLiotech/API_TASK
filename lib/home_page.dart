import 'package:api_practical/model/order.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static Future<Order?> getData() async {
    try {
      final response = await http.get(
        Uri.parse(
            "http://api.mystorestory.com/api/MenuMaster/GetPoskotForShop?shop_id=4591"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Order.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API Practical"),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<Order?>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Text("Mo Data Available");
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.data!.orderList!.length,
              itemBuilder: (context, index) {
                final order = snapshot.data!.data!.orderList![index];
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ExpansionTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text("User Name : ${order.posUserName!}"),
                    subtitle: Text("Order No: ${order.orderId} "),
                    backgroundColor: Colors.grey.shade300,
                    collapsedBackgroundColor: Colors.black,
                    collapsedIconColor: Colors.white,
                    collapsedTextColor: Colors.white,
                    children: [
                      buildHeader(order),
                      buildSubHeader(order),
                      buildSectionCards(order),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

//This widet function is used to design the Header which contain the order Id, Table No, KOT No and Pos User Name
  Widget buildHeader(OrderList? order) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: Column(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.2,
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "#${order!.orderId}",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Table: ${order.tableNo}",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const VerticalDivider(
                    color: Colors.white,
                    thickness: 1.0,
                  ),
                  Text(
                    "KOT: ${order.kotId}",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const VerticalDivider(
                    color: Colors.white,
                    thickness: 1.0,
                  ),
                  Text(
                    order.posUserName.toString(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  //this widget function is used to design the sub header (QTY , Items , KOT Time)
  Widget buildSubHeader(OrderList? order) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1.0),
        ),
        height: MediaQuery.sizeOf(context).height * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Qty"),
            const Text("Items"),
            Text(order!.kotStartTime.toString()),
          ],
        ),
      ),
    );
  }

  //this widget function is used to design the Stater Card (Category Label, Qty, Starter Item Name, Item status )
  Widget buildSectionCards(OrderList? order) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 8.0),
      child: Column(
        children: order?.sectionData?.map(
              (section) {
                return Card(
                  elevation: 5.0,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        color: Colors.brown,
                        child: Text(
                          section.sectionName.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Column(
                        children: section.itemList?.map((item) {
                              return ListTile(
                                leading: Text(
                                  item.quantity.toString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                title: Text(
                                  item.itemName!,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: Container(
                                  alignment: Alignment.center,
                                  width: 100,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                  ),
                                  child: Text(
                                    item.itemStatus.toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              );
                            }).toList() ??
                            [],
                      )
                    ],
                  ),
                );
              },
            ).toList() ??
            [],
      ),
    );
  }
}
