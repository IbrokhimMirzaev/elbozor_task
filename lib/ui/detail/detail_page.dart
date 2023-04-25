import 'package:elbozor_task/data/models/data_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.item}) : super(key: key);

  final DataModel item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CachedNetworkImage(imageUrl: item.thumb, width: double.infinity, height: 350, fit: BoxFit.fill),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(item.title, style: const TextStyle(fontSize: 20, height: 1.3)),
            )
          ],
        ),
      ),
    );
  }
}
