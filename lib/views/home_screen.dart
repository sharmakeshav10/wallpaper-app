import 'package:flutter/material.dart';
import 'package:wallpaper_app/data/category_data.dart';
import 'package:wallpaper_app/models/category_model.dart';
import 'package:wallpaper_app/widgets/appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
List<CategoryModel> categories = [];

 @override
  void initState() {
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customAppBar(),
      ),
      body: Column(
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
                    decoration: InputDecoration(
                      hintText: "Search",
                      border: InputBorder.none
                    
                    ),
                  ),
                ),
                Icon(Icons.search),
              ],
            ),
          ),
          SizedBox(height: 15,),
Container(
  height: 100,
  child: ListView.builder(shrinkWrap: true, scrollDirection: Axis.horizontal, itemCount: categories.length, itemBuilder: (context, index) {
    return CategoryBox(imgUrl: categories[index].categoryImg!, name: categories[index].categoryName!);
  },),
)
        ],
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
      width: 100,
      child: Stack(
        children: [
          Container(
            
            child: Image.network(imgUrl),
          ),
          Container(
            child: Text(name),
          )
        ],
      ),
    );
  }
}