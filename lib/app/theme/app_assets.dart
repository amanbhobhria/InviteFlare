mixin AppAssets {
  static String assetSVGPath(String icon) => 'assets/images/svg/$icon.svg';

  static String get homeNavIcon => assetSVGPath('ic_home_nav');

  static String get searchNavIcon => assetSVGPath('ic_search_nav');

  static String get categoryNavIcon => assetSVGPath('ic_category_nav');

  static String get settingNavIcon => assetSVGPath('ic_setting_nav');
}
