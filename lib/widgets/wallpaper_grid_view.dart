import 'package:flutter/material.dart';

class WallpaperGridView extends StatelessWidget {

  final List<String> wallpapers;
  const WallpaperGridView({super.key, required this.wallpapers});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2) , itemCount: wallpapers.length ,itemBuilder: (context, index) {
      return Image.network(wallpapers[index], fit: BoxFit.cover,);
    },);
  }
}