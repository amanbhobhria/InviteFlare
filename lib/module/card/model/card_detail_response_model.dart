class CardDetailResponseModel {
  CardData? card;
  List<Breadcrumbs>? breadcrumbs;
  List<RelatedCards>? relatedCards;
  SchemaProduct? schemaProduct;
  SchemaBreadcrumb? schemaBreadcrumb;

  CardDetailResponseModel(
      {this.card,
        this.breadcrumbs,
        this.relatedCards,
        this.schemaProduct,
        this.schemaBreadcrumb});

  CardDetailResponseModel.fromJson(Map<dynamic, dynamic> json) {
    card = json['card'] != null ? new CardData.fromJson(json['card']) : null;
    if (json['breadcrumbs'] != null) {
      breadcrumbs = <Breadcrumbs>[];
      json['breadcrumbs'].forEach((v) {
        breadcrumbs!.add(new Breadcrumbs.fromJson(v));
      });
    }
    if (json['related_cards'] != null) {
      relatedCards = <RelatedCards>[];
      json['related_cards'].forEach((v) {
        relatedCards!.add(new RelatedCards.fromJson(v));
      });
    }
    schemaProduct = json['schema_product'] != null
        ? new SchemaProduct.fromJson(json['schema_product'])
        : null;
    schemaBreadcrumb = json['schema_breadcrumb'] != null
        ? new SchemaBreadcrumb.fromJson(json['schema_breadcrumb'])
        : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    if (this.card != null) {
      data['card'] = this.card!.toJson();
    }
    if (this.breadcrumbs != null) {
      data['breadcrumbs'] = this.breadcrumbs!.map((v) => v.toJson()).toList();
    }
    if (this.relatedCards != null) {
      data['related_cards'] =
          this.relatedCards!.map((v) => v.toJson()).toList();
    }
    if (this.schemaProduct != null) {
      data['schema_product'] = this.schemaProduct!.toJson();
    }
    if (this.schemaBreadcrumb != null) {
      data['schema_breadcrumb'] = this.schemaBreadcrumb!.toJson();
    }
    return data;
  }
}

class CardData {
  dynamic id;
  dynamic type;
  dynamic category;
  dynamic title;
  dynamic slug;
  dynamic navLink;
  bool? isFree;
  bool? isPremium;
  dynamic thumb;
  dynamic alt;
  dynamic description;
  dynamic pageContent;
  List<dynamic>? attributes;

  CardData({
    this.id,
    this.type,
    this.category,
    this.title,
    this.slug,
    this.navLink,
    this.isFree,
    this.isPremium,
    this.thumb,
    this.alt,
    this.description,
    this.pageContent,
    this.attributes,
  });

  CardData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    category = json['category'];
    title = json['title'];
    slug = json['slug'];
    navLink = json['nav_link'];
    isFree = json['is_free'];
    isPremium = json['is_premium'];
    thumb = json['thumb'];
    alt = json['alt'];
    description = json['description'];
    pageContent = json['page_content'];
    attributes = json['attributes'] != null ? List<dynamic>.from(json['attributes']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['type'] = type;
    data['category'] = category;
    data['title'] = title;
    data['slug'] = slug;
    data['nav_link'] = navLink;
    data['is_free'] = isFree;
    data['is_premium'] = isPremium;
    data['thumb'] = thumb;
    data['alt'] = alt;
    data['description'] = description;
    data['page_content'] = pageContent;
    if (attributes != null) {
      data['attributes'] = attributes;
    }
    return data;
  }
}





// class Card {
//   dynamic id;
//   dynamic type;
//   dynamic category;
//   dynamic title;
//   dynamic slug;
//   dynamic navLink;
//   bool? isFree;
//   bool? isPremium;
//   dynamic thumb;
//   dynamic alt;
//   dynamic description;
//   dynamic pageContent;
//   List<dynamic>? attributes;
//
//   Card(
//       {this.id,
//         this.type,
//         this.category,
//         this.title,
//         this.slug,
//         this.navLink,
//         this.isFree,
//         this.isPremium,
//         this.thumb,
//         this.alt,
//         this.description,
//         this.pageContent,
//         this.attributes});
//
//   Card.fromJson(Map<dynamic, dynamic> json) {
//     id = json['id'];
//     type = json['type'];
//     category = json['category'];
//     title = json['title'];
//     slug = json['slug'];
//     navLink = json['nav_link'];
//     isFree = json['is_free'];
//     isPremium = json['is_premium'];
//     thumb = json['thumb'];
//     alt = json['alt'];
//     description = json['description'];
//     pageContent = json['page_content'];
//     if (json['attributes'] != null) {
//       attributes = <Null>[];
//       json['attributes'].forEach((v) {
//         attributes!.add(new Null.fromJson(v));
//       });
//     }
//   }
//
//   Map<dynamic, dynamic> toJson() {
//     final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
//     data['id'] = this.id;
//     data['type'] = this.type;
//     data['category'] = this.category;
//     data['title'] = this.title;
//     data['slug'] = this.slug;
//     data['nav_link'] = this.navLink;
//     data['is_free'] = this.isFree;
//     data['is_premium'] = this.isPremium;
//     data['thumb'] = this.thumb;
//     data['alt'] = this.alt;
//     data['description'] = this.description;
//     data['page_content'] = this.pageContent;
//     if (this.attributes != null) {
//       data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class Breadcrumbs {
  dynamic name;
  dynamic url;

  Breadcrumbs({this.name, this.url});

  Breadcrumbs.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class RelatedCards {
  dynamic type;
  dynamic title;
  dynamic slug;
  dynamic navLink;
  dynamic thumb;
  dynamic alt;
  dynamic id;
  bool? isFree;
  bool? isPremium;
  List<dynamic>? attributes;

  RelatedCards({
    this.type,
    this.title,
    this.slug,
    this.navLink,
    this.thumb,
    this.alt,
    this.id,
    this.isFree,
    this.isPremium,
    this.attributes,
  });

  RelatedCards.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    slug = json['slug'];
    navLink = json['nav_link'];
    thumb = json['thumb'];
    alt = json['alt'];
    id = json['id'];
    isFree = json['is_free'];
    isPremium = json['is_premium'];
    attributes = json['attributes'] != null
        ? List<dynamic>.from(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['type'] = type;
    data['title'] = title;
    data['slug'] = slug;
    data['nav_link'] = navLink;
    data['thumb'] = thumb;
    data['alt'] = alt;
    data['id'] = id;
    data['is_free'] = isFree;
    data['is_premium'] = isPremium;
    if (attributes != null) {
      data['attributes'] = attributes;
    }
    return data;
  }
}


class SchemaProduct {
  dynamic context;
  dynamic type;
  dynamic name;
  dynamic image;
  dynamic url;
  dynamic sku;
  Brand? brand;
  dynamic description;
  bool? isAccessibleForFree;
  Offers? offers;
  IsRelatedTo? isRelatedTo;

  SchemaProduct(
      {this.context,
        this.type,
        this.name,
        this.image,
        this.url,
        this.sku,
        this.brand,
        this.description,
        this.isAccessibleForFree,
        this.offers,
        this.isRelatedTo});

  SchemaProduct.fromJson(Map<dynamic, dynamic> json) {
    context = json['@context'];
    type = json['@type'];
    name = json['name'];
    image = json['image'];
    url = json['url'];
    sku = json['sku'];
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    description = json['description'];
    isAccessibleForFree = json['isAccessibleForFree'];
    offers =
    json['offers'] != null ? new Offers.fromJson(json['offers']) : null;
    isRelatedTo = json['isRelatedTo'] != null
        ? new IsRelatedTo.fromJson(json['isRelatedTo'])
        : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['@context'] = this.context;
    data['@type'] = this.type;
    data['name'] = this.name;
    data['image'] = this.image;
    data['url'] = this.url;
    data['sku'] = this.sku;
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    data['description'] = this.description;
    data['isAccessibleForFree'] = this.isAccessibleForFree;
    if (this.offers != null) {
      data['offers'] = this.offers!.toJson();
    }
    if (this.isRelatedTo != null) {
      data['isRelatedTo'] = this.isRelatedTo!.toJson();
    }
    return data;
  }
}

class Brand {
  dynamic type;
  dynamic name;

  Brand({this.type, this.name});

  Brand.fromJson(Map<dynamic, dynamic> json) {
    type = json['@type'];
    name = json['name'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['@type'] = this.type;
    data['name'] = this.name;
    return data;
  }
}

class Offers {
  dynamic type;
  dynamic priceCurrency;
  dynamic price;
  dynamic availability;
  dynamic itemCondition;
  dynamic url;
  dynamic category;
  dynamic description;
  HasMerchantReturnPolicy? hasMerchantReturnPolicy;
  dynamic priceValidUntil;

  Offers(
      {this.type,
        this.priceCurrency,
        this.price,
        this.availability,
        this.itemCondition,
        this.url,
        this.category,
        this.description,
        this.hasMerchantReturnPolicy,
        this.priceValidUntil});

  Offers.fromJson(Map<dynamic, dynamic> json) {
    type = json['@type'];
    priceCurrency = json['priceCurrency'];
    price = json['price'];
    availability = json['availability'];
    itemCondition = json['itemCondition'];
    url = json['url'];
    category = json['category'];
    description = json['description'];
    hasMerchantReturnPolicy = json['hasMerchantReturnPolicy'] != null
        ? new HasMerchantReturnPolicy.fromJson(json['hasMerchantReturnPolicy'])
        : null;
    priceValidUntil = json['priceValidUntil'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['@type'] = this.type;
    data['priceCurrency'] = this.priceCurrency;
    data['price'] = this.price;
    data['availability'] = this.availability;
    data['itemCondition'] = this.itemCondition;
    data['url'] = this.url;
    data['category'] = this.category;
    data['description'] = this.description;
    if (this.hasMerchantReturnPolicy != null) {
      data['hasMerchantReturnPolicy'] = this.hasMerchantReturnPolicy!.toJson();
    }
    data['priceValidUntil'] = this.priceValidUntil;
    return data;
  }
}

class HasMerchantReturnPolicy {
  dynamic type;
  dynamic returnFees;

  HasMerchantReturnPolicy({this.type, this.returnFees});

  HasMerchantReturnPolicy.fromJson(Map<dynamic, dynamic> json) {
    type = json['@type'];
    returnFees = json['returnFees'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['@type'] = this.type;
    data['returnFees'] = this.returnFees;
    return data;
  }
}

class IsRelatedTo {
  dynamic type;
  dynamic name;
  dynamic url;

  IsRelatedTo({this.type, this.name, this.url});

  IsRelatedTo.fromJson(Map<dynamic, dynamic> json) {
    type = json['@type'];
    name = json['name'];
    url = json['url'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['@type'] = this.type;
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class SchemaBreadcrumb {
  dynamic context;
  dynamic type;
  List<ItemListElement>? itemListElement;

  SchemaBreadcrumb({this.context, this.type, this.itemListElement});

  SchemaBreadcrumb.fromJson(Map<dynamic, dynamic> json) {
    context = json['@context'];
    type = json['@type'];
    if (json['itemListElement'] != null) {
      itemListElement = <ItemListElement>[];
      json['itemListElement'].forEach((v) {
        itemListElement!.add(new ItemListElement.fromJson(v));
      });
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
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

  ItemListElement.fromJson(Map<dynamic, dynamic> json) {
    type = json['@type'];
    position = json['position'];
    name = json['name'];
    item = json['item'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['@type'] = this.type;
    data['position'] = this.position;
    data['name'] = this.name;
    data['item'] = this.item;
    return data;
  }
}