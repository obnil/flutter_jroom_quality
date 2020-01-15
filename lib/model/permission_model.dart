class PermissionDetail {
  String name;
  String positionName;
  String img;
  String userId;
  List<PermissionListBean> permissionList;

  PermissionDetail.fromJsonMap(Map<String, dynamic> map)
      : name = map["name"],
        positionName = map["positionName"],
        img = map["img"],
        userId = map["userId"],
        permissionList = List()
          ..addAll((map['permissionList'] as List ?? [])
              .map((o) => PermissionListBean.fromJsonMap(o)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['positionName'] = positionName;
    data['img'] = img;
    data['userId'] = userId;
    data['permissionList'] = permissionList;
    return data;
  }
}

class PermissionListBean {
  int id;
  String permCode;
  String type;
  int parentId;
  String permName;
  String permType;
  List<ChildrenBeanX> children;

  PermissionListBean.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        permCode = map["permCode"],
        type = map["type"],
        parentId = map["parentId"],
        permName = map["permName"],
        permType = map["permType"],
        children = List()
          ..addAll((map['children'] as List ?? [])
              .map((o) => ChildrenBeanX.fromJsonMap(o)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['permCode'] = permCode;
    data['type'] = type;
    data['parentId'] = parentId;
    data['permName'] = permName;
    data['permType'] = permType;
    data['children'] = children;
    return data;
  }
}

class ChildrenBeanX {
  int id;
  String permCode;
  String type;
  int parentId;
  String permName;
  String permType;
  List<ChildrenBean> children;

  ChildrenBeanX.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        permCode = map["permCode"],
        type = map["type"],
        parentId = map["parentId"],
        permName = map["permName"],
        permType = map["permType"],
        children = List()
          ..addAll((map['children'] as List ?? [])
              .map((o) => ChildrenBean.fromJsonMap(o)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['permCode'] = permCode;
    data['type'] = type;
    data['parentId'] = parentId;
    data['permName'] = permName;
    data['permType'] = permType;
    data['children'] = children;
    return data;
  }
}

class ChildrenBean {
  int id;
  String permCode;
  String type;
  int parentId;
  String permName;
  String permType;

  ChildrenBean.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        permCode = map["permCode"],
        type = map["type"],
        parentId = map["parentId"],
        permName = map["permName"],
        permType = map["permType"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['permCode'] = permCode;
    data['type'] = type;
    data['parentId'] = parentId;
    data['permName'] = permName;
    data['permType'] = permType;
    return data;
  }
}
