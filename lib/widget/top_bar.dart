import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar(
      {super.key, required this.changeLocation, required this.switchLoading});

  final void Function(List<double>) changeLocation;
  final void Function() switchLoading;

  @override
  Widget build(BuildContext context) {
    SearchController searchController = SearchController();
    FocusScope.of(context).unfocus();
    searchController.clear();
    return SearchBar(
      leading: const Icon(Icons.search),
      autoFocus: false,
      onTap: () {
        Navigator.of(context).pushNamed('/searchPage',
            arguments: [changeLocation, switchLoading]);
      },
      onChanged: (String value) {
        searchController.clear();
        FocusScope.of(context).unfocus();
        Navigator.of(context).pushNamed('/searchPage',
            arguments: [changeLocation, switchLoading, value]);
      },
    );
  }
}
