class CateroiesResponseModel {
  dynamic title;
  dynamic slug;
  dynamic iconXs;
  dynamic iconXl;
  dynamic bgColor;
  dynamic navLink;
  Banner? banner;
  Seo? seo;
  List<Category>? category;
  dynamic parent;

  CateroiesResponseModel(
      {this.title,
      this.slug,
      this.iconXs,
      this.iconXl,
      this.bgColor,
      this.navLink,
      this.banner,
      this.seo,
      this.category,
      this.parent});

  CateroiesResponseModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
    iconXs = json['icon_xs'];
    iconXl = json['icon_xl'];
    bgColor = json['bg_color'];
    navLink = json['nav_link'];
    banner =
        json['banner'] != null ? new Banner.fromJson(json['banner']) : null;
    seo = json['seo'] != null ? new Seo.fromJson(json['seo']) : null;
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    parent = json['parent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['icon_xs'] = this.iconXs;
    data['icon_xl'] = this.iconXl;
    data['bg_color'] = this.bgColor;
    data['nav_link'] = this.navLink;
    if (this.banner != null) {
      data['banner'] = this.banner!.toJson();
    }
    if (this.seo != null) {
      data['seo'] = this.seo!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    data['parent'] = this.parent;
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

class Seo {
  dynamic metaTitle;
  dynamic metaDescription;
  dynamic pageTitle;
  dynamic pageDescription;
  dynamic canonicalUrl;

  Seo(
      {this.metaTitle,
      this.metaDescription,
      this.pageTitle,
      this.pageDescription,
      this.canonicalUrl});

  Seo.fromJson(Map<String, dynamic> json) {
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    pageTitle = json['page_title'];
    pageDescription = json['page_description'];
    canonicalUrl = json['canonical_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['page_title'] = this.pageTitle;
    data['page_description'] = this.pageDescription;
    data['canonical_url'] = this.canonicalUrl;
    return data;
  }
}

class Category {
  dynamic title;
  dynamic slug;
  dynamic iconXs;
  dynamic iconXl;
  dynamic bgColor;
  dynamic navLink;

  Category(
      {this.title,
      this.slug,
      this.iconXs,
      this.iconXl,
      this.bgColor,
      this.navLink});

  Category.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
    iconXs = json['icon_xs'];
    iconXl = json['icon_xl'];
    bgColor = json['bg_color'];
    navLink = json['nav_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['icon_xs'] = this.iconXs;
    data['icon_xl'] = this.iconXl;
    data['bg_color'] = this.bgColor;
    data['nav_link'] = this.navLink;
    return data;
  }
}