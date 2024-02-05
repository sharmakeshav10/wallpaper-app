import 'package:flutter/material.dart';

class WallpaperGridView extends StatelessWidget {
  final List<String> wallpapers;
  const WallpaperGridView({super.key, required this.wallpapers});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 6.0),
        itemCount: wallpapers.length,
        itemBuilder: (context, index) {
          return GridTile(
            
            child: Container(
              padding: EdgeInsets.all(2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  wallpapers[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
