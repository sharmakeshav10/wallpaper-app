import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/data/category_data.dart';
import 'package:wallpaper_app/models/category_model.dart';
import 'package:wallpaper_app/services/api_services.dart';
import 'package:wallpaper_app/views/search_screen.dart';
import 'package:wallpaper_app/widgets/appbar.dart';
import 'package:wallpaper_app/widgets/wallpaper_grid_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> categories = [];
  List<String> wallpapers = [];

  TextEditingController searchController = new TextEditingController();

  displayCuratedWallpapers() async {
    try {
      final response = await ApiServices().getCuratedWallpapers();
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> photos = jsonData['photos'];
      List<String> portraitUrl =
          photos.map((photo) => photo['src']['portrait'] as String).toList();
      print(portraitUrl);
      setState(() {
        wallpapers = portraitUrl;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    displayCuratedWallpapers();
    categories = getCategories();
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => SearchScreen(
                                    searchQuery: searchController.text,
                                  )));
                        },
                        child: Icon(Icons.search)),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryBox(
                        imgUrl: categories[index].categoryImg!,
                        name: categories[index].categoryName!);
                  },
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

class CategoryBox extends StatelessWidget {
  const CategoryBox({super.key, required this.imgUrl, required this.name});

  final String imgUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      // color: Colors.green,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imgUrl,
                height: 55,
                width: 110,
                fit: BoxFit.cover,
              )),
          Container(
            height: 55,
            width: 110,
            color: Colors.black.withOpacity(0.3),
            child: Center(
                child: Text(
              name,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            )),
          )
        ],
      ),
    );
  }
}
