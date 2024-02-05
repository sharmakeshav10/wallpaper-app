import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/services/api_services.dart';
import 'package:wallpaper_app/widgets/appbar.dart';
import 'package:wallpaper_app/widgets/wallpaper_grid_view.dart';

class SearchScreen extends StatefulWidget {
  final String searchQuery;
  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = new TextEditingController();
  List<String> wallpapers = [];

  displaySearchWallpapers(String search) async {
    try {
      final response =
          await ApiServices().getSearchWallpapers(widget.searchQuery);
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
    displaySearchWallpapers(searchController.text);
    super.initState();
    searchController.text = widget.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customAppBar(),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                margin: EdgeInsets.symmetric(horizontal: 28),
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            hintText: "Search", border: InputBorder.none),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          displaySearchWallpapers(searchController.text);
                        },
                        child: Icon(Icons.search)),
                  ],
                ),
              ),
              wallpapers.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : WallpaperGridView(wallpapers: wallpapers)
            ],
          ),
        ),
      ),
    );
  }
}
