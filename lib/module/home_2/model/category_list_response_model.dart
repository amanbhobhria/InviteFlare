class CategoryListResponseModel {
  dynamic title;
  dynamic slug;
  dynamic bgColor;
  dynamic iconXs;
  dynamic iconXl;
  dynamic navTitle;
  dynamic navSubTitle;
  dynamic navLink;
  Seo? seo;
  Banner? banner;
  List<Attributes>? attributes;
  List<Breadcrumbs>? breadcrumbs;
  BreadcrumbSchema? breadcrumbSchema;
  List<Category>? category;
  Schemas? schemas;
  Parent? parent;

  CategoryListResponseModel(
      {this.title,
        this.slug,
        this.bgColor,
        this.iconXs,
        this.iconXl,
        this.navTitle,
        this.navSubTitle,
        this.navLink,
        this.seo,
        this.banner,
        this.attributes,
        this.breadcrumbs,
        this.breadcrumbSchema,
        this.category,
        this.schemas,
        this.parent});

  CategoryListResponseModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
    bgColor = json['bg_color'];
    iconXs = json['icon_xs'];
    iconXl = json['icon_xl'];
    navTitle = json['nav_title'];
    navSubTitle = json['nav_sub_title'];
    navLink = json['nav_link'];
    seo = json['seo'] != null ? new Seo.fromJson(json['seo']) : null;
    banner =
    json['banner'] != null ? new Banner.fromJson(json['banner']) : null;
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(new Attributes.fromJson(v));
      });
    }
    if (json['breadcrumbs'] != null) {
      breadcrumbs = <Breadcrumbs>[];
      json['breadcrumbs'].forEach((v) {
        breadcrumbs!.add(new Breadcrumbs.fromJson(v));
      });
    }
    breadcrumbSchema = json['breadcrumb_schema'] != null
        ? new BreadcrumbSchema.fromJson(json['breadcrumb_schema'])
        : null;
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    schemas =
    json['schemas'] != null ? new Schemas.fromJson(json['schemas']) : null;
    parent =
    json['parent'] != null ? new Parent.fromJson(json['parent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['bg_color'] = this.bgColor;
    data['icon_xs'] = this.iconXs;
    data['icon_xl'] = this.iconXl;
    data['nav_title'] = this.navTitle;
    data['nav_sub_title'] = this.navSubTitle;
    data['nav_link'] = this.navLink;
    if (this.seo != null) {
      data['seo'] = this.seo!.toJson();
    }
    if (this.banner != null) {
      data['banner'] = this.banner!.toJson();
    }
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }
    if (this.breadcrumbs != null) {
      data['breadcrumbs'] = this.breadcrumbs!.map((v) => v.toJson()).toList();
    }
    if (this.breadcrumbSchema != null) {
      data['breadcrumb_schema'] = this.breadcrumbSchema!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.schemas != null) {
      data['schemas'] = this.schemas!.toJson();
    }
    if (this.parent != null) {
      data['parent'] = this.parent!.toJson();
    }
    return data;
  }
}

class Seo {
  dynamic metaTitle;
  dynamic metaDescription;
  dynamic pageTitle;
  dynamic pageDescription;
  dynamic canonicalUrl;
  dynamic type;

  Seo(
      {this.metaTitle,
        this.metaDescription,
        this.pageTitle,
        this.pageDescription,
        this.canonicalUrl,
        this.type});

  Seo.fromJson(Map<String, dynamic> json) {
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    pageTitle = json['page_title'];
    pageDescription = json['page_description'];
    canonicalUrl = json['canonical_url'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['page_title'] = this.pageTitle;
    data['page_description'] = this.pageDescription;
    data['canonical_url'] = this.canonicalUrl;
    data['type'] = this.type;
    return data;
  }
}

class Banner {
  dynamic title;
  dynamic subTitle;
  dynamic description;
  dynamic backgroundColor;

  Banner({this.title, this.subTitle, this.description, this.backgroundColor});

  Banner.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subTitle = json['sub_title'];
    description = json['description'];
    backgroundColor = json['background_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['sub_title'] = this.subTitle;
    data['description'] = this.description;
    data['background_color'] = this.backgroundColor;
    return data;
  }
}

class Attributes {
  dynamic name;
  List<Values>? values;

  Attributes({this.name, this.values});

  Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['values'] != null) {
      values = <Values>[];
      json['values'].forEach((v) {
        values!.add(new Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.values != null) {
      data['values'] = this.values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Values {
  dynamic name;
  dynamic value;
  dynamic rgb;

  Values({this.name, this.value, this.rgb});

  Values.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    rgb = json['rgb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    data['rgb'] = this.rgb;
    return data;
  }
}

class Breadcrumbs {
  dynamic name;
  dynamic url;

  Breadcrumbs({this.name, this.url});

  Breadcrumbs.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class BreadcrumbSchema {
  dynamic context;
  dynamic type;
  List<ItemListElement>? itemListElement;

  BreadcrumbSchema({this.context, this.type, this.itemListElement});

  BreadcrumbSchema.fromJson(Map<String, dynamic> json) {
    context = json['@context'];
    type = json['@type'];
    if (json['itemListElement'] != null) {
      itemListElement = <ItemListElement>[];
      json['itemListElement'].forEach((v) {
        itemListElement!.add(new ItemListElement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@context'] = this.context;
    data['@type'] = this.type;
    if (this.itemListElement != null) {
      data['itemListElement'] =
          this.itemListElement!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemListElement {
  dynamic type;
  dynamic position;
  dynamic name;
  dynamic item;

  ItemListElement({this.type, this.position, this.name, this.item});

  ItemListElement.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    position = json['position'];
    name = json['name'];
    item = json['item'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@type'] = this.type;
    data['position'] = this.position;
    data['name'] = this.name;
    data['item'] = this.item;
    return data;
  }
}

class Category {
  dynamic title;
  dynamic slug;
  dynamic bgColor;
  dynamic iconXs;
  dynamic iconXl;
  dynamic navTitle;
  dynamic navSubTitle;
  dynamic navLink;

  Category(
      {this.title,
        this.slug,
        this.bgColor,
        this.iconXs,
        this.iconXl,
        this.navTitle,
        this.navSubTitle,
        this.navLink});

  Category.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
    bgColor = json['bg_color'];
    iconXs = json['icon_xs'];
    iconXl = json['icon_xl'];
    navTitle = json['nav_title'];
    navSubTitle = json['nav_sub_title'];
    navLink = json['nav_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['bg_color'] = this.bgColor;
    data['icon_xs'] = this.iconXs;
    data['icon_xl'] = this.iconXl;
    data['nav_title'] = this.navTitle;
    data['nav_sub_title'] = this.navSubTitle;
    data['nav_link'] = this.navLink;
    return data;
  }
}

class Schemas {
  Collection? collection;
  BreadcrumbSchema? breadcrumb;
  BreadcrumbSchema? itemList;

  Schemas({this.collection, this.breadcrumb, this.itemList});

  Schemas.fromJson(Map<String, dynamic> json) {
    collection = json['collection'] != null
        ? new Collection.fromJson(json['collection'])
        : null;
    breadcrumb = json['breadcrumb'] != null
        ? new BreadcrumbSchema.fromJson(json['breadcrumb'])
        : null;
    itemList = json['itemList'] != null
        ? new BreadcrumbSchema.fromJson(json['itemList'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.collection != null) {
      data['collection'] = this.collection!.toJson();
    }
    if (this.breadcrumb != null) {
      data['breadcrumb'] = this.breadcrumb!.toJson();
    }
    if (this.itemList != null) {
      data['itemList'] = this.itemList!.toJson();
    }
    return data;
  }
}

class Collection {
  dynamic context;
  dynamic type;
  dynamic name;
  dynamic description;
  dynamic url;
  dynamic inLanguage;
  BreadcrumbSchema? mainEntity;

  Collection(
      {this.context,
        this.type,
        this.name,
        this.description,
        this.url,
        this.inLanguage,
        this.mainEntity});

  Collection.fromJson(Map<String, dynamic> json) {
    context = json['@context'];
    type = json['@type'];
    name = json['name'];
    description = json['description'];
    url = json['url'];
    inLanguage = json['inLanguage'];
    mainEntity = json['mainEntity'] != null
        ? new BreadcrumbSchema.fromJson(json['mainEntity'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@context'] = this.context;
    data['@type'] = this.type;
    data['name'] = this.name;
    data['description'] = this.description;
    data['url'] = this.url;
    data['inLanguage'] = this.inLanguage;
    if (this.mainEntity != null) {
      data['mainEntity'] = this.mainEntity!.toJson();
    }
    return data;
  }
}

class ItemListElement2 {
  dynamic type;
  dynamic position;
  dynamic url;
  dynamic name;

  ItemListElement2({this.type, this.position, this.url, this.name});

  ItemListElement2.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    position = json['position'];
    url = json['url'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@type'] = this.type;
    data['position'] = this.position;
    data['url'] = this.url;
    data['name'] = this.name;
    return data;
  }
}

class Parent {
  dynamic title;
  dynamic slug;
  dynamic bgColor;
  dynamic iconXs;
  dynamic iconXl;
  dynamic navTitle;
  dynamic navSubTitle;
  dynamic navLink;
  dynamic parent;

  Parent(
      {this.title,
        this.slug,
        this.bgColor,
        this.iconXs,
        this.iconXl,
        this.navTitle,
        this.navSubTitle,
        this.navLink,
        this.parent});

  Parent.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
    bgColor = json['bg_color'];
    iconXs = json['icon_xs'];
    iconXl = json['icon_xl'];
    navTitle = json['nav_title'];
    navSubTitle = json['nav_sub_title'];
    navLink = json['nav_link'];
    parent = json['parent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['bg_color'] = this.bgColor;
    data['icon_xs'] = this.iconXs;
    data['icon_xl'] = this.iconXl;
    data['nav_title'] = this.navTitle;
    data['nav_sub_title'] = this.navSubTitle;
    data['nav_link'] = this.navLink;
    data['parent'] = this.parent;
    return data;
  }
}
