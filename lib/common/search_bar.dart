import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/constants/style.dart';
import 'package:todo_app/providers/todo_list_provider.dart';

class SearchBar extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  void onSearch(BuildContext context) {
    Provider.of<TodoListProvider>(context, listen: false)
        .applySearch(searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    searchController.addListener(() => {onSearch(context)});
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              height: 40,
              child: TextField(
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => {onSearch(context)},
                textAlignVertical: TextAlignVertical.center,
                controller: searchController,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 8),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius:
                            BorderRadius.all(Radius.circular(borderRadius))),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Search...",
                    hintStyle: TextStyle(color: AppColors.gray)),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          // search button
          renderSearchButton(context)
        ],
      ),
    );
  }

  Widget renderSearchButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        onSearch(context);
      },
      style: TextButton.styleFrom(
        backgroundColor: AppColors.pink,
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
      ),
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: const Center(child: Icon(Icons.search, color: AppColors.white)),
      ),
    );
  }
}
