import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invite_flare/features/search/presentation/widgets/recent_search_view/recent_search_view.dart';
import 'package:invite_flare/module/main/controller/search_page_controller.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchPageController());

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
            title: const Text(
              "Search",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Search your event cards",
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      controller.callSearchApi(value);
                    }
                  },
                ),
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
  }
}
