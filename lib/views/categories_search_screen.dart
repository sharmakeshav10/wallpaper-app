import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/services/api_services.dart';
import 'package:wallpaper_app/widgets/appbar.dart';
import 'package:wallpaper_app/widgets/wallpaper_grid_view.dart';

class CategorySearchScreen extends StatefulWidget {
  final String categoryName;
  const CategorySearchScreen({super.key, required this.categoryName});

  @override
  State<CategorySearchScreen> createState() => _CategorySearchScreenState();
}

class _CategorySearchScreenState extends State<CategorySearchScreen> {
  List<String> wallpapers = [];

  displayCategorySearches(String categoryQuery) async {
    try {
      final response =
          await ApiServices().getSearchWallpapers(widget.categoryName);
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> photos = jsonData['photos'];
      List<String> portraitUrl =
          photos.map((photo) => photo['src']['portrait'] as String).toList();

          setState(() {
            wallpapers = portraitUrl;
          });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    displayCategorySearches(widget.categoryName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customAppBar(),
      ),
      body: SingleChildScrollView(
          child: Container(
        child: Column(children: [
          wallpapers.isEmpty
              ? Center(child: CircularProgressIndicator())
              : WallpaperGridView(wallpapers: wallpapers)
        ]),
      )),
    );
  }
}
