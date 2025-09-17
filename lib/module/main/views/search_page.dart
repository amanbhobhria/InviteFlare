import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/features/search/presentation/widgets/recent_search_view/recent_search_view.dart';
import 'package:invite_flare/module/main/controller/search_page_controller.dart';
import 'package:invite_flare/shared/presentation/pages/wrapper/search_field_wrapper/search_field_wrapper.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchPageController());

    return GetBuilder<SearchPageController>(
      init: controller,
      // ignore: prefer_expression_function_bodies
      builder: (controller) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: true,
                stretch: true,
                centerTitle: true,
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                title: IFHeading(
                  text: 'Search',
                  headingSize: IFHeadingSize.xxxL,
                  textWeight: IFTextWeight.regular,
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(56),
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: const SearchFieldWrapper(),
                  ),
                ),
              ),

              // Recent Search
              SliverToBoxAdapter(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (controller.recentSearches.isEmpty) {
                    return const Center(child: Text("No recent searches"));
                  } else {
                    return RecentSearchView(
                      heading: "Recent search",
                      recentSearches: controller.recentSearches,
                      onTapDelete: (query) => controller.deleteRecent(query),
                    );
                  }
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
