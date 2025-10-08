import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/core/base/usecase.dart';
import 'package:invite_flare/core_2/data/remote_service/network/dio_client.dart';
import 'package:invite_flare/core_2/data/remote_service/network/network_exceptions.dart';
import 'package:invite_flare/module/main/model/categories_response_model.dart';
import 'package:invite_flare/module/main/model/category_data_response_model.dart';
import 'package:invite_flare/module/main/widget/use_cases/categories_use_case.dart';
import 'package:invite_flare/shared/domain/entities/category_entity.dart';

class HomeController extends GetxController {
  //  final ExplainerUseCase explainerUseCase;
  // final ExpandableCardUseCase expandableCardUseCase;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  CategoryDataResponseModel categoryDataResponseModel =
      CategoryDataResponseModel();
  List<CategoriesData> cateroiesResponseModel = [];
  // Category
  var isCategoryLoading = false.obs;

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
          .get('v1/invitations/nav-menu', skipAuth: false)
          .then(
        (value) {
          if (value != null) {
            categoryDataResponseModel =
                CategoryDataResponseModel.fromJson(value);
            cateroiesResponseModel.clear(); // old data hatane ke liye
            cateroiesResponseModel
                .addAll(categoryDataResponseModel.categories ?? []);

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
