import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/common/show_my_snackbar.dart';
import 'package:final_assignment/features/booking/presentation/view/booking_view.dart';
import 'package:final_assignment/features/home/domain/entity/artist_entity.dart';
import 'package:final_assignment/features/home/presentation/favourite_provider.dart';
import 'package:final_assignment/features/single_artist/presentation/widgets/my_single_artist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyArtistCard extends ConsumerWidget {
  final ArtistEntity artist;
  final bool isDark;

  const MyArtistCard({required this.artist, required this.isDark, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageUrl = '${ApiEndpoints.imageUrl}${artist.artistImage}';
    final isFavorite = ref.watch(favoriteArtistProvider).contains(artist);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.black12,
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
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SingleView(
                          singleArtist: artist,
                          selectedQuantity: 1,
                          onAddToBag: () {
                            // Implement add to bag functionality
                          },
                          onIncreaseQuantity: () {
                            // Implement increase quantity functionality
                          },
                          onDecreaseQuantity: () {
                            // Implement decrease quantity functionality
                          },
                        ),
                      ),
                    );
                  },
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
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      artist.artistName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      artist.artistDescription,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.grey[400] : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () {
                  final notifier = ref.read(favoriteArtistProvider.notifier);
                  if (isFavorite) {
                    notifier.removeArtist(artist);
                    showMySnackBar(
                        message: "Artist removed from favourites");
                  } else {
                    notifier.addArtist(artist);
                    showMySnackBar(message: "Artist added to favourites");
                  }
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              icon: Icon(
                Icons.book_online,
                color: isDark
                    ? Colors.purpleAccent
                    : Colors.purple,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingView(artist.id!),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
