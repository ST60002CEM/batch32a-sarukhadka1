
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/common/show_my_snackbar.dart';
import 'package:final_assignment/features/home/presentation/favourite_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
class FavouriteView extends ConsumerWidget {
  const FavouriteView({super.key});
 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteArtist = ref.watch(favoriteArtistProvider);
 
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Artists'),
      ),
      body: ListView.builder(
        itemCount: favoriteArtist.length,
        itemBuilder: (context, index) {
          final artist = favoriteArtist[index];
          return ListTile(
            leading: Image.network(
              '${ApiEndpoints.imageUrl}${artist.artistImage}',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(artist.artistName),
            subtitle: Text(artist.artistGenre),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Rs ${artist.artistRate}',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    ref
                        .read(favoriteArtistProvider.notifier)
                        .removeArtist(artist);
                    showMySnackBar(message: 'Artist removed from favorites');
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}