import 'package:invite_flare/core_2/data/remote_service/network/dio_client.dart';
import 'package:invite_flare/core_2/data/remote_service/network/network_exceptions.dart';
import 'package:invite_flare/export.dart';
import 'package:invite_flare/module/card/model/card_list_response_model.dart';

class CardListController extends GetxController {
  var slug;
  CardListResponseModel cardListResponseModel = CardListResponseModel();
  RxList<CardsListData> cardsListData = <CardsListData>[].obs;
  RxBool isLoading = true.obs;
  @override
  void onInit() {
    getArgument();
    super.onInit();
  }

  getArgument() {
    if (Get.arguments != null) {
      slug = Get.arguments['slug'] ?? "";
      print('object-------${Get.arguments}');
    }
  }

  @override
  void onReady() {
    callGetCArdList();
    super.onReady();
  }

  callGetCArdList() async {
    try {
      isLoading.value = true;
      await DioClient(Dio())
          .get('v1/invitations/category/cards/$slug', skipAuth: false)
          .then(
        (value) {
          if (value != null) {
            cardListResponseModel = CardListResponseModel.fromJson(value);
            cardsListData.value.addAll(cardListResponseModel.cards ?? []);

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
      isLoading.value = false;
    }
  }
}
