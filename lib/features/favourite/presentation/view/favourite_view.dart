import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/common/show_my_snackbar.dart';
import 'package:final_assignment/features/favourite/domain/entity/favourite_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data to simulate the static UI
    final favouriteArtists = [
      FavouriteEntity(
          id: '1',
          artists: Artist(
              id: '1',
              artistName: 'John Doe',
              artistGenre: 'Rock',
              artistImage: 'image_url')),
      FavouriteEntity(
          id: '2',
          artists: Artist(
              id: '2',
              artistName: 'Jane Smith',
              artistGenre: 'Jazz',
              artistImage: 'image_url')),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Artists'),
        elevation: 0,
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: favouriteArtists.length,
                itemBuilder: (context, index) {
                  final artist = favouriteArtists[index];
                  return _buildArtistCard(context, artist);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArtistCard(BuildContext context, FavouriteEntity artist) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Slidable(
        key: Key(artist.artists.id!),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {
            // Static UI, so no real deletion occurs
            showMySnackBar(
                message: 'Artist removed from favourites', color: Colors.red);
          }),
          children: [
            SlidableAction(
              onPressed: (context) {
                // Static UI, so no real deletion occurs
                showMySnackBar(
                    message: 'Artist removed from favourites',
                    color: Colors.red);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Remove',
            ),
          ],
        ),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            // leading: CircleAvatar(
            //   radius: 30,
            //   backgroundImage: NetworkImage(
            //       ApiEndpoints.imageUrl + artist.artists.artistImage),
            // ),
            title: Text(
              artist.artists.artistName,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.purple),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  artist.artists.artistGenre,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
              ],
            ),
            trailing: const Icon(Icons.delete, color: Colors.purple),
            onTap: () {
              // Static UI, so no navigation occurs
            },
          ),
        ),
      ),
    );
  }
}

class FavouriteEntity {
  final String id;
  final Artist artists;

  FavouriteEntity({required this.id, required this.artists});
}

class Artist {
  final String id;
  final String artistName;
  final String artistGenre;
  final String artistImage;

  Artist(
      {required this.id,
      required this.artistName,
      required this.artistGenre,
      required this.artistImage});
}

void showMySnackBar({required String message, required Color color}) {
  // Snackbar implementation
}


// import 'package:final_assignment/app/constants/api_endpoint.dart';
// import 'package:final_assignment/core/common/show_my_snackbar.dart';
// import 'package:final_assignment/features/favourite/domain/entity/favourite_entity.dart';
// import 'package:final_assignment/features/favourite/presentation/state/favourite_state.dart';
// import 'package:final_assignment/features/favourite/presentation/viewmodel/favourite_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// class FavouriteView extends ConsumerStatefulWidget {
//   const FavouriteView({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _FavouriteViewState();
// }

// class _FavouriteViewState extends ConsumerState<FavouriteView> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(favouriteViewModelProvider.notifier).fetchFavourite();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(favouriteViewModelProvider);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Favourite Artists'),
//         elevation: 0,
//       ),
//       body: RefreshIndicator(
//         onRefresh: () async {
//           await ref.read(favouriteViewModelProvider.notifier).fetchFavourite();
//         },
//         child: _buildBody(state),
//       ),
//     );
//   }

//   Widget _buildBody(FavouriteState state) {
//     if (state.isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     } else if (state.error != null) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Error: ${state.error}', textAlign: TextAlign.center),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 ref.read(favouriteViewModelProvider.notifier).fetchFavourite();
//               },
//               child: const Text('Retry'),
//             ),
//           ],
//         ),
//       );
//     } else if (state.favourite.isEmpty) {
//       return const Center(
//         child: Text(
//           'No favourite artists',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//         ),
//       );
//     } else {
//       return ListView.builder(
//         itemCount: state.favourite.length,
//         itemBuilder: (context, index) {
//           final artists = state.favourite[index];
//           return _buildArtistCard(artists);
//         },
//       );
//     }
//   }

//   Widget _buildArtistCard(FavouriteEntity artist) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Slidable(
//         key: Key(artist.artists.id!),
//         endActionPane: ActionPane(
//           motion: const ScrollMotion(),
//           dismissible: DismissiblePane(onDismissed: () {
//             ref
//                 .read(favouriteViewModelProvider.notifier)
//                 .removeFavourite(artist.id);
//             showMySnackBar(
//                 message: 'Artist removed from favourites', color: Colors.red);
//           }),
//           children: [
//             SlidableAction(
//               onPressed: (context) {
//                 ref
//                     .read(favouriteViewModelProvider.notifier)
//                     .removeFavourite(artist.id);
//                 showMySnackBar(
//                     message: 'Artist removed from favourites',
//                     color: Colors.red);
//               },
//               backgroundColor: Colors.red,
//               foregroundColor: Colors.white,
//               icon: Icons.delete,
//               label: 'Remove',
//             ),
//           ],
//         ),
//         child: Card(
//           elevation: 2,
//           child: ListTile(
//             contentPadding: const EdgeInsets.all(16),
//             leading: CircleAvatar(
//               radius: 30,
//               backgroundImage: NetworkImage(
//                   ApiEndpoints.imageUrl + artist.artists.artistImage),
//             ),
//             title: Text(
//               artist.artists.artistName,
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//             ),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 4),
//                 Text(
//                   artist.artists.artistGenre,
//                   style: TextStyle(color: Colors.grey[600]),
//                 ),
//                 const SizedBox(height: 8),
//                 // Text(
//                 //   'Experience: ${artist.artist.artistExperience} years',
//                 //   style: TextStyle(color: Colors.grey[600]),
//                 // ),
//               ],
//             ),
//             trailing: const Icon(Icons.chevron_right),
//             onTap: () {
//               // Navigate to doctor details page
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
