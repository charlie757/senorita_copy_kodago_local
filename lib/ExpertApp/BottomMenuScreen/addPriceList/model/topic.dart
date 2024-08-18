class GroupTitleDataModel {
  final String userId;
  final String item_name;
  final String price;
  GroupTitleDataModel({
    required this.userId,
    required this.item_name,
    required this.price,
  });
  factory GroupTitleDataModel.fromJson(Map<String, dynamic> json) {
    return GroupTitleDataModel(
      userId: json['userId'],
      item_name: json['item_name'],
      price: json['price'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'item_name': item_name,
      'price': price,
    };
  }
}



class CategoryPriceModel {
  int id;
  String categoryId;
  String name;

  CategoryPriceModel({
    required this.id,
    required this.categoryId,
    required this.name,
  });

  factory CategoryPriceModel.fromJson(Map<String, dynamic> json) => CategoryPriceModel(
    id: json["id"],
    categoryId: json["category_id"],
    name: json["name"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "name": name,
  };
}
class AddPriceList {
  final user_Id;
  final item_name;
  final price;

  AddPriceList(
     this.user_Id,
     this.item_name,
     this.price,
  );


}




/*
class GroupTitleDataModel {
  final  id;
  final name;
  final select=false.obs;
  List<GroupSubTitleDataModel> child;

  GroupTitleDataModel({
     this.id,
     this.name,
     required this.child,
  });

  factory GroupTitleDataModel.fromJson(Map<String, dynamic> json) {
    return GroupTitleDataModel(
      id: json['id'],
      name: json['name'],
      child: List<GroupSubTitleDataModel>.from(
        json['child'].map((x) => GroupSubTitleDataModel.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'child': List<dynamic>.from(child.map((x) => x.toJson())),
    };
  }
}

class GroupSubTitleDataModel {
  String id;
  String name;
  List<GroupSubTitleChildDataModel> child;

  GroupSubTitleDataModel({
    required this.id,
    required this.name,
    required this.child,
  });

  factory GroupSubTitleDataModel.fromJson(Map<String, dynamic> json) {
    return GroupSubTitleDataModel(
      id: json['id'],
      name: json['name'],
      child: List<GroupSubTitleChildDataModel>.from(
        json['child'].map((x) => GroupSubTitleChildDataModel.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'child': List<dynamic>.from(child.map((x) => x.toJson())),
    };
  }
}

class GroupSubTitleChildDataModel {
  String id;
  String name;

  GroupSubTitleChildDataModel({
    required this.id,
    required this.name,
  });

  factory GroupSubTitleChildDataModel.fromJson(Map<String, dynamic> json) {
    return GroupSubTitleChildDataModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
*/
