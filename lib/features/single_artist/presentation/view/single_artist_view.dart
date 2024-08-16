import 'package:final_assignment/features/mybooking/presentation/viewmodel/booking_list_view_model.dart';
import 'package:final_assignment/features/single_artist/presentation/viewmodel/single_artist_view_model.dart';
import 'package:final_assignment/features/single_artist/presentation/widgets/my_single_artist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
class SingleArtistView extends ConsumerStatefulWidget {
  final String artistId;
 
  const SingleArtistView({required this.artistId, super.key});
 
  @override
  _SingleArtistViewState createState() => _SingleArtistViewState();
}
 
class _SingleArtistViewState extends ConsumerState<SingleArtistView> {
  @override
  void initState() {
    super.initState();
    _fetchArtistDetails();
  }
 
  void _fetchArtistDetails() {
    Future.microtask(() {
      ref
          .read(singleArtistViewModelProvider.notifier)
          .getSingleArtist(widget.artistId);
    });
  }
 
  @override
  Widget build(BuildContext context) {
    final artistState = ref.watch(singleArtistViewModelProvider);
 
    return Scaffold(
      body: artistState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : artistState.error != null
              ? Center(child: Text(artistState.error!))
              : artistState.singleArtist != null
                  ? SingleView(
                      singleArtist: artistState.singleArtist!,
                      selectedQuantity: artistState.selectedQuantity,
                      onAddToBag: () {
                        ref.read(bookingListViewModelProvider.notifier).getBookings(
                            artistState.singleArtist!.id!,
                            artistState.selectedQuantity,
                            artistState.singleArtist!.artistRate);
                      },
                      onIncreaseQuantity: () {
                        ref
                            .read(singleArtistViewModelProvider.notifier)
                            .updateSelectedQuantity(
                                artistState.selectedQuantity + 1);
                      },
                      onDecreaseQuantity: () {
                        ref
                            .read(singleArtistViewModelProvider.notifier)
                            .updateSelectedQuantity(
                                artistState.selectedQuantity - 1);
                      },
                    )
                  : const Center(child: Text('Product not found')),
    );
  }
}