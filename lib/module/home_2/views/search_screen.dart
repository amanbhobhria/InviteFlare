import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invite_flare/module/home_2/controlller/search_controller.dart';
import 'package:invite_flare/module/home_2/model/search_category_response_model.dart';


class SearchCategoryScreen extends StatelessWidget {

  final SearchCategoryController controller =
  Get.put(SearchCategoryController());

  SearchCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: TextField(
        controller: controller.searchController,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: "Search categories...",
          border: InputBorder.none,
        ),
        onChanged: (query) {
          controller.searchCategory(query);
        },
      ),
    ),

      body: GetBuilder<SearchCategoryController>(
        builder: (ctrl) {
          if (ctrl.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (ctrl.searchResponse == null ||
              ctrl.searchResponse?.data.isEmpty == true) {
            return const Center(child: Text("No results found"));
          }

          List<Data> items = ctrl.searchResponse!.data;
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final item = items[index];
              return InkWell(
                onTap: () {
                  debugPrint("Tapped: ${item.uuid}");
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    item.thumb != null
                        ? Image.network(
                      item.thumb,
                      height: 180, // bigger height
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                        : const Icon(Icons.image, size: 120),
                    const SizedBox(height: 8),
                    Text(
                      item.title ?? "",
                      style: const TextStyle(
                        fontSize: 14, // smaller than default
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          );






          // return ListView.separated(
          //   padding: const EdgeInsets.all(12),
          //   itemCount: items.length,
          //   separatorBuilder: (_, __) => const Divider(),
          //   itemBuilder: (context, index) {
          //     final item = items[index];
          //     return ListTile(
          //       leading: item.thumb != null
          //           ? Image.network(
          //         item.thumb,
          //         width: 50,
          //         height: 50,
          //         fit: BoxFit.cover,
          //       )
          //           : const Icon(Icons.image, size: 50),
          //       title: Text(item.title ?? ""),
          //
          //
          //       trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          //       onTap: () {
          //         // TODO: handle navigation (maybe open detail screen using item.navLink or uuid)
          //         debugPrint("Tapped: ${item.uuid}");
          //       },
          //     );
          //   },
          // );
        },
      ),
    );
}

