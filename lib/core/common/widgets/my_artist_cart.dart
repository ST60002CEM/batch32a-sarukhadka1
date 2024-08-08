import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/features/home/domain/entity/artist_entity.dart';
import 'package:flutter/material.dart';

class MyArtistCard extends StatelessWidget {
  final ArtistEntity artist;

  const MyArtistCard({required this.artist, super.key});

  @override
  Widget build(BuildContext context) {
    final imageUrl = '${ApiEndpoints.imageUrl}${artist.artistImage}';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      artist.artistName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      artist.artistDescription,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      artist.artistGenre,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      artist.artistRate.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Positioned(
          //   top: 0,
          //   right: 0,
          //   child: Padding(
          //     padding: const EdgeInsets.all(1),
          //     child: IconButton(
          //       icon: const Icon(
          //         Icons.favorite_border,
          //         color: Colors.red,
          //       ),
          //       onPressed: () {
          //         // Add your favorite button logic here
          //       },
          //     ),
          //   ),
          // ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(
                Icons.book_online,
                color: Colors.purple,
              ),
              onPressed: () {
                // Add your add to cart button logic here
              },
            ),
          ),
        ],
      ),
    );
  }
}
