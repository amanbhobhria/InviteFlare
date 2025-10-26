import 'package:invite_flare/core_2/data/remote_service/network/dio_client.dart';
import 'package:invite_flare/core_2/data/remote_service/network/network_exceptions.dart';
import 'package:invite_flare/export.dart';
import 'package:invite_flare/module/card/model/card_detail_response_model.dart';

class CardDetailController extends GetxController {
  var id;
  RxBool isLoading = true.obs;

  CardDetailResponseModel cardDetailResponseModel = CardDetailResponseModel();

  var cardData = Rxn<CardData>();

  var relatedCards = <RelatedCards>[].obs;

  var breadcrumbs = <Breadcrumbs>[].obs;




  onInit() {
    getArgument();
    super.onInit();
  }

  getArgument() {
    print("arguments in card_Detail =${Get.arguments}");
    if (Get.arguments != null) {
      id = Get.arguments['id'] ?? "";
    }
  }

  callCardDetailApi() async {
    try {
      isLoading.value = true;
      await DioClient(Dio())
          .get('v1/invitations/category/card/display/$id', skipAuth: false)
          .then(
        (value) {
          if (value != null) {
            cardDetailResponseModel = CardDetailResponseModel.fromJson(value);
            cardData.value =cardDetailResponseModel.card;
            relatedCards.value =cardDetailResponseModel.relatedCards??[];
            breadcrumbs.value =cardDetailResponseModel.breadcrumbs??[];
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
      isLoading.value = false;;
    }
  }

  @override
  void onReady() {
    callCardDetailApi();
    super.onReady();
  }
}
