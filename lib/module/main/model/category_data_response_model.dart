class CategoryDataResponseModel {
  bool? status;
  List<CategoriesData>? categories;

  CategoryDataResponseModel({this.status, this.categories});

  CategoryDataResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['categories'] != null) {
      categories = <CategoriesData>[];
      json['categories'].forEach((v) {
        categories!.add(new CategoriesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoriesData {
  dynamic title;
  dynamic slug;
  dynamic navLink;
  bool? isPlaceholder;
  bool? displayCard;
  List<Images>? images;
  List<ChildrenData>? children;

  CategoriesData(
      {this.title,
      this.slug,
      this.navLink,
      this.isPlaceholder,
      this.displayCard,
      this.images,
      this.children});

  CategoriesData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
    navLink = json['navLink'];
    isPlaceholder = json['isPlaceholder'];
    displayCard = json['displayCard'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    if (json['children'] != null) {
      children = <ChildrenData>[];
      json['children'].forEach((v) {
        children!.add(new ChildrenData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['navLink'] = this.navLink;
    data['isPlaceholder'] = this.isPlaceholder;
    data['displayCard'] = this.displayCard;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  dynamic src;
  dynamic alt;
  dynamic link;

  Images({this.src, this.alt, this.link});

  Images.fromJson(Map<String, dynamic> json) {
    src = json['src'];
    alt = json['alt'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['src'] = this.src;
    data['alt'] = this.alt;
    data['link'] = this.link;
    return data;
  }
}

class ChildrenData {
  dynamic title;
  dynamic slug;
  dynamic navLink;
  List<Children>? children;
  bool? isPlaceholder;
  bool? displayCard;

  ChildrenData(
      {this.title,
      this.slug,
      this.navLink,
      this.children,
      this.isPlaceholder,
      this.displayCard});

  ChildrenData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
    navLink = json['navLink'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(new Children.fromJson(v));
      });
    }
    isPlaceholder = json['isPlaceholder'];
    displayCard = json['displayCard'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['navLink'] = this.navLink;
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    data['isPlaceholder'] = this.isPlaceholder;
    data['displayCard'] = this.displayCard;
    return data;
  }
}

class Children {
  dynamic title;
  dynamic slug;
  dynamic navLink;
  List<Null>? children;

  Children({this.title, this.slug, this.navLink, this.children});

  Children.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
    navLink = json['navLink'];
    if (json['children'] != null) {
      children = <Null>[];
      // json['children'].forEach((v) {
      //   children!.add(new Null.fromJson(v));
      // });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['navLink'] = this.navLink;
    // if (this.children != null) {
    //   data['children'] = this.children!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
