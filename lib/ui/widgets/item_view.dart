import 'package:cached_network_image/cached_network_image.dart';
import 'package:elbozor_task/data/models/data_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ItemView extends StatelessWidget {
  const ItemView({Key? key, required this.item, required this.onTap}) : super(key: key);

  final DataModel item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.orangeAccent.shade100.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      width: 50,
      height: 100,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(5),
          foregroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
          )
        ),
        onPressed: onTap,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: item.thumb,
                fit: BoxFit.fill,
                width: 100,
                height: 100,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(color: Colors.white),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(item.title, style: const TextStyle(color: Colors.deepOrange)),
                  Text(item.added, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
