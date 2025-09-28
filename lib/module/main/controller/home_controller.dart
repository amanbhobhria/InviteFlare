import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/core/base/usecase.dart';
import 'package:invite_flare/core_2/data/remote_service/network/dio_client.dart';
import 'package:invite_flare/core_2/data/remote_service/network/network_exceptions.dart';
import 'package:invite_flare/module/main/model/categories_response_model.dart';
import 'package:invite_flare/module/main/widget/use_cases/categories_use_case.dart';
import 'package:invite_flare/shared/domain/entities/category_entity.dart';

class HomeController extends GetxController {
  //  final ExplainerUseCase explainerUseCase;
  // final ExpandableCardUseCase expandableCardUseCase;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<CateroiesResponseModel> cateroiesResponseModel = [];
  // Category
  var isCategoryLoading = false.obs;
  var categories = <CategoryEntity>[
    CategoryEntity.fromJson({
      'title': 'Birthday',
      'slug': 'birthday',
      'bg_color': '#F2F2FF',
      'icon_xs':
          'https://paperpost-ce6b5.web.app/assets/images/home-category/birthday.svg',
    }),
    CategoryEntity.fromJson({
      'title': 'Wedding',
      'slug': 'wedding',
      'bg_color': '#FFF6F7',
      'icon_xs':
          'https://paperpost-ce6b5.web.app/assets/images/home-category/wedding.svg',
    }),
    CategoryEntity.fromJson({
      'title': 'Baby Shower',
      'slug': 'baby-shower',
      'bg_color': '#F1F7FF',
      'icon_xs':
          'https://paperpost-ce6b5.web.app/assets/images/home-category/baby-shower.svg',
    }),
    CategoryEntity.fromJson({
      'title': 'Graduation',
      'slug': 'graduation',
      'bg_color': '#ECFFF7',
      'icon_xs':
          'https://paperpost-ce6b5.web.app/assets/images/home-category/graduation.svg',
    }),
    CategoryEntity.fromJson({
      'title': 'New Year',
      'slug': 'new-year',
      'bg_color': '#FFF9F0',
      'icon_xs':
          'https://paperpost-ce6b5.web.app/assets/images/home-category/new-year.svg',
    }),
  ].obs; // <-- RxList<CategoryEntity>

  // Explainer Section
  var isExplainerLoading = false.obs;
  var explainerData = <String, dynamic>{
    'heading': 'Create Stunning Invitations in Just 3 Simple Steps',
    'section': [
      {
        'step': 'Step-1',
        'title': 'Choose the Perfect Design',
        'subTitle': '''
Browse stunning templates for every occasion, perfectly crafted for you.''',
        'lottieJson': 'assets/lottie/envelope-and-letter.json',
        'colorBg': 0x3499BCE9,
      },
      {
        'step': 'Step-2',
        'title': 'Make It Uniquely Yours',
        'subTitle': '''
Personalize colors, text, and photos to match your celebration theme.''',
        'lottieJson': 'assets/lottie/greeting-card.json',
        'colorBg': 0x13ED6157,
      },
      {
        'step': 'Step-3',
        'title': 'Share the Joy',
        'subTitle': '''
Send invitations instantly online or download for printing with ease.''',
        'lottieJson': 'assets/lottie/sending-letter.json',
        'colorBg': 0xFFFCF1E6,
      },
    ]
  }.obs;

  // Expandable Cards
  var isExpandableLoading = false.obs;
  var expandableCardData = <String, dynamic>{
    'heading': 'Birthday',
    'description': '''
Fill their inbox with cheer with Christmas cards you can email, text, or share''',
    'cards': [
      {
        'image':
            'https://images.greetingsisland.com/images/invitations/birthday/kids/previews/celebrate-with-us-22601.jpeg?auto=format,compress',
        'name': 'Celebrate with us',
      },
      {
        'image':
            'https://marketplace.canva.com/EAF30pqerkY/1/0/1143w/canva-gold-and-black-birthday-party-invitation-portrait-qam3ouC3JPY.jpg',
        'name': 'Party Zone',
      },
      {
        'image':
            'https://i.pinimg.com/736x/b6/16/af/b616af2a4183a44ba4e34ccde13ac639.jpg',
        'name': 'Glitter Bubbly',
      },
    ]
  }.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAll();
  }

  Future<void> fetchAll() async {
    fetchCategories();
    // fetchExpandableCards();
  }

  Future<void> fetchCategories() async {
    try {
      isCategoryLoading.value = true;
      await DioClient(Dio())
          .get('api/v1/invitations/mob/categories', skipAuth: false)
          .then(
        (value) {
          if (value != null) {
            if (value is List) {
              cateroiesResponseModel.clear(); // old data hatane ke liye
              cateroiesResponseModel.addAll(
                value.map((e) => CateroiesResponseModel.fromJson(e)).toList(),
              );
            }
            print(
                'Cateriiiiiiiiiiiiiiii--------------${cateroiesResponseModel.length}');
            update();
          }
        },
      ).onError(
        (error, stackTrace) {
          print('Error---$error');
          print('Error---$stackTrace');
          NetworkExceptions.getDioException(error);
        },
      );
    } finally {
      isCategoryLoading.value = false;
    }
  }

  // Future<void> fetchExplainerSection() async {
  //   try {
  //     isExplainerLoading.value = true;
  //     final result = await explainerUseCase();
  //     explainerData.assignAll(result);
  //   } finally {
  //     isExplainerLoading.value = false;
  //   }
  // }

  // Future<void> fetchExpandableCards() async {
  //   try {
  //     isExpandableLoading.value = true;
  //     final result = await expandableCardUseCase();
  //     expandableCardData.assignAll(result);
  //   } finally {
  //     isExpandableLoading.value = false;
  //   }
  // }
}
