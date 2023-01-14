import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double width, height;

  const CachedImage(
      {super.key,
      required this.imageUrl,
      required this.width,
      required this.height});

  Widget _imageBulder(ImageProvider imageProvider) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      imageBuilder: ((context, imageProvider) {
        return _imageBulder(imageProvider);
      }),
      placeholder: (context, url) {
        return Container(
          width: height,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
          ),
          child: const Center(child: CircularProgressIndicator()),
        );
      },
      errorWidget: (context, url, error) {
        return const SizedBox.shrink();
      },
    );
  }
}
