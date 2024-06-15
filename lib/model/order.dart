class Order {
  bool? success;
  Data? data;
  String? message;
  int? responseCode;

  Order({this.success, this.data, this.message, this.responseCode});

  Order.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    responseCode = json['responseCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['responseCode'] = responseCode;
    return data;
  }
}

class Data {
  List<OrderList>? orderList;

  Data({this.orderList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['order_list'] != null) {
      orderList = <OrderList>[];
      json['order_list'].forEach((v) {
        orderList!.add(OrderList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orderList != null) {
      data['order_list'] = orderList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderList {
  String? orderId;
  String? posUserName;
  String? orderType;
  String? tableNo;
  String? kotId;
  String? kotStartTime;
  String? kotEndTime;
  String? kotStatus;
  List<SectionData>? sectionData;

  OrderList(
      {this.orderId,
      this.posUserName,
      this.orderType,
      this.tableNo,
      this.kotId,
      this.kotStartTime,
      this.kotEndTime,
      this.kotStatus,
      this.sectionData});

  OrderList.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    posUserName = json['pos_user_name'];
    orderType = json['order_type'];
    tableNo = json['table_no'];
    kotId = json['kot_id'];
    kotStartTime = json['kot_start_time'];
    kotEndTime = json['kot_end_time'];
    kotStatus = json['kot_status'];
    if (json['sectionData'] != null) {
      sectionData = <SectionData>[];
      json['sectionData'].forEach((v) {
        sectionData!.add(SectionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['pos_user_name'] = posUserName;
    data['order_type'] = orderType;
    data['table_no'] = tableNo;
    data['kot_id'] = kotId;
    data['kot_start_time'] = kotStartTime;
    data['kot_end_time'] = kotEndTime;
    data['kot_status'] = kotStatus;
    if (sectionData != null) {
      data['sectionData'] = sectionData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SectionData {
  String? sectionId;
  String? sectionName;
  List<ItemList>? itemList;

  SectionData({this.sectionId, this.sectionName, this.itemList});

  SectionData.fromJson(Map<String, dynamic> json) {
    sectionId = json['section_id'];
    sectionName = json['section_name'];
    if (json['itemList'] != null) {
      itemList = <ItemList>[];
      json['itemList'].forEach((v) {
        itemList!.add(ItemList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['section_id'] = sectionId;
    data['section_name'] = sectionName;
    if (itemList != null) {
      data['itemList'] = itemList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemList {
  String? categoryId;
  String? categoryName;
  String? itemId;
  String? itemName;
  String? sizeId;
  String? sizeName;
  String? customizationDetails;
  String? choiceDetails;
  String? itemStatus;
  String? quantity;
  String? cancelQuantity;

  ItemList(
      {this.categoryId,
      this.categoryName,
      this.itemId,
      this.itemName,
      this.sizeId,
      this.sizeName,
      this.customizationDetails,
      this.choiceDetails,
      this.itemStatus,
      this.quantity,
      this.cancelQuantity});

  ItemList.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    itemId = json['item_id'];
    itemName = json['itemName'];
    sizeId = json['size_id'];
    sizeName = json['size_name'];
    customizationDetails = json['customization_details'];
    choiceDetails = json['choice_details'];
    itemStatus = json['item_status'];
    quantity = json['quantity'];
    cancelQuantity = json['cancel_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['item_id'] = itemId;
    data['itemName'] = itemName;
    data['size_id'] = sizeId;
    data['size_name'] = sizeName;
    data['customization_details'] = customizationDetails;
    data['choice_details'] = choiceDetails;
    data['item_status'] = itemStatus;
    data['quantity'] = quantity;
    data['cancel_quantity'] = cancelQuantity;
    return data;
  }
}
