import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/core_2/routes/app_routes.dart';
import 'package:invite_flare/features/search/presentation/widgets/recent_search_view/recent_search_view.dart';
import 'package:invite_flare/module/main/controller/search_page_controller.dart';
import 'package:invite_flare/module/main/model/search_category_response_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/features/search/presentation/widgets/recent_search_view/recent_search_view.dart';
import 'package:invite_flare/module/main/controller/search_page_controller.dart';
import 'package:invite_flare/module/main/model/search_category_response_model.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchPageController());

    return GetBuilder<SearchPageController>(
      init: controller,
      builder: (controller) => Scaffold(
        backgroundColor: Colors.grey[50],
        body: CustomScrollView(
          slivers: [
            /// AppBar + Search Field
            SliverAppBar(
              pinned: true,
              floating: true,
              stretch: true,
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 1,
              surfaceTintColor: Colors.white,
              title: const IFHeading(
                text: 'Search',
                headingSize: IFHeadingSize.xxxL,
                textWeight: IFTextWeight.light,
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(56),
                child: Container(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      hintText: "Search categories...",
                      border: InputBorder.none, // ✅ remove underline
                      enabledBorder: InputBorder.none, // ✅
                      focusedBorder: InputBorder.none, // ✅
                      icon: const Icon(Icons.search, color: Colors.grey),
                      suffixIcon: controller.searchController.text.isEmpty
                          ? const SizedBox()
                          : InkWell(
                        onTap: () {
                          controller.searchController.clear();
                          controller.searchCategory('');
                        },
                        child: const Icon(Icons.close, color: Colors.grey),
                      ),
                    ),
                    onChanged: (query) {
                      controller.searchCategory(query);
                    },
                  ),
                ),
              ),
            ),

            /// Content (Recent / Results)
            Obx(() {
              if (controller.isLoading.value) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                );
              }

              /// If results exist
              if (controller.searchResponse != null &&
                  controller.searchResponse?.data.isNotEmpty == true) {
                List<Data> items = controller.searchResponse!.data;

                return SliverPadding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final item = items[index];
                        return InkWell(
                          onTap: () {
                            debugPrint("Tapped: ${item.uuid}");
                            Get.toNamed(AppRoutes.cardDetailScreen, arguments: {
                              'id': item.uuid
                            });


                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                /// Image
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(16)),
                                  child: item.thumb != null
                                      ? Image.network(
                                    item.thumb!,
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                      : Container(
                                    height: 120,
                                    color: Colors.grey[200],
                                    child: const Icon(Icons.image,
                                        size: 48, color: Colors.grey),
                                  ),
                                ),

                                /// Title
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      item.title
                                          .toString()
                                          .capitalizeFirst ??
                                          "",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: items.length,
                    ),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                  ),
                );
              }

              /// No results → show recent searches
              if (controller.recentSearches.isNotEmpty) {
                return SliverToBoxAdapter(
                  child: RecentSearchView(
                    heading: "Recent Searches",
                    recentSearches: controller.recentSearches,
                    onTapDelete: (query) => controller.deleteRecent(query),
                    onTapSearch: (query) => controller.onRecentSearchTap(query),
                  ),
                );
              }

              /// No recent, no results
              return const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Center(
                    child: Text(
                      "No results found",
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}






// class SearchScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(SearchPageController());
//
//     return GetBuilder<SearchPageController>(
//       init: controller,
//       builder: (controller) => Scaffold(
//         body: CustomScrollView(
//           slivers: [
//             /// AppBar + Search Field
//             SliverAppBar(
//               pinned: true,
//               floating: true,
//               stretch: true,
//               centerTitle: true,
//               backgroundColor: Colors.white,
//               surfaceTintColor: Colors.white,
//               title: const IFHeading(
//                 text: 'Search',
//                 headingSize: IFHeadingSize.xxxL,
//                 textWeight: IFTextWeight.regular,
//               ),
//               bottom: PreferredSize(
//                 preferredSize: const Size.fromHeight(56),
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: TextField(
//                     controller: controller.searchController,
//                     decoration: InputDecoration(
//                       hintText: "Search categories...",
//                       border: InputBorder.none,
//                       suffixIcon: controller.searchController.text.isEmpty
//                           ? SizedBox()
//                           : InkWell(
//                               onTap: () {
//                                 controller.searchController.clear();
//                                 controller.searchCategory('');
//                               },
//                               child: const Icon(Icons.close)),
//                     ),
//                     onChanged: (query) {
//                       controller.searchCategory(query);
//                     },
//                   ),
//                 ),
//               ),
//             ),
//
//             /// Content (Recent / Results)
//             SliverToBoxAdapter(
//               child: Obx(() {
//                 if (controller.isLoading.value) {
//                   return const Padding(
//                     padding: EdgeInsets.all(24.0),
//                     child: Center(child: CircularProgressIndicator()),
//                   );
//                 }
//
//                 // If results exist, show results
//                 if (controller.searchResponse != null &&
//                     controller.searchResponse?.data.isNotEmpty == true) {
//                   List<Data> items = controller.searchResponse!.data;
//
//                   return ListView.separated(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     padding: const EdgeInsets.all(12),
//                     itemCount: items.length,
//                     separatorBuilder: (_, __) => const Divider(),
//                     itemBuilder: (context, index) {
//                       final item = items[index];
//                       return InkWell(
//                         onTap: () {
//                           debugPrint("Tapped: ${item.uuid}");
//                         },
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             item.thumb != null
//                                 ? Image.network(
//                                     item.thumb!,
//                                     height: 180,
//                                     width: double.infinity,
//                                     fit: BoxFit.cover,
//                                   )
//                                 : const Icon(Icons.image, size: 120),
//                             const SizedBox(height: 8),
//                             Text(
//                               item.title.toString().capitalizeFirst ?? "",
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 }
//
//                 // No results -> show recent searches
//                 if (controller.recentSearches.isNotEmpty) {
//                   return RecentSearchView(
//                     heading: "Recent search",
//                     recentSearches: controller.recentSearches,
//                     onTapDelete: (query) => controller.deleteRecent(query),
//                     onTapSearch: (query) => controller.onRecentSearchTap(query),
//                   );
//                 }
//
//                 // No recent, no results
//                 return const Padding(
//                   padding: EdgeInsets.all(24.0),
//                   child: Center(child: Text("No results found")),
//                 );
//               }),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
