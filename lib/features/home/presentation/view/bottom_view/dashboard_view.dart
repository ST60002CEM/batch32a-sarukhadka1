import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_assignment/core/common/show_my_snackbar.dart';
import 'package:final_assignment/core/common/widgets/my_artist_cart.dart';
import 'package:final_assignment/features/home/presentation/viewmodel/artist_view_model.dart';
import 'package:final_assignment/features/home/presentation/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  final ScrollController _scrollController = ScrollController();
  late bool isDark;

  @override
  void initState() {
    // isDark = ref.read(isDarkThemeProvider);
    isDark = false;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(artistViewModelProvider);

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            _scrollController.position.extentAfter == 0) {
          ref.read(artistViewModelProvider.notifier).getArtists();
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard View'),
          actions: [
            IconButton(
              onPressed: () {
                showMySnackBar(message: 'Refreshing...');
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                ref.read(homeViewModelProvider.notifier).logout();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
            Switch(
                value: isDark,
                onChanged: (value) {
                  setState(() {
                    isDark = value;
                    // ref.read(isDarkThemeProvider.notifier).updateTheme(value);
                  });
                }),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Hey Saru, Choose what you need !',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Search Artists',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 200,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 2.0,
                          onPageChanged: (index, reason) {
                            // Optional: Handle carousel page change
                          },
                        ),
                        items: [
                          'https://img.freepik.com/free-vector/realistic-beauty-sale-banner-with-discount_52683-94990.jpg',
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS087W93QU9rYWcnqWJzzqAx4UpfKF1tUT3YQ&s',
                          'https://images.summitmedia-digital.com/cosmo/images/2019/06/21/sephora-buys-under-1000-1561081927.jpg',
                        ].map((imageUrl) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: state.artists.length,
                        itemBuilder: (context, index) {
                          final artist = state.artists[index];
                          return MyArtistCard(artist: artist);
                        },
                      ),
                      if (state.isLoading)
                        const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:final_assignment/core/common/show_my_snackbar.dart';
// import 'package:final_assignment/features/home/presentation/viewmodel/home_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class DashboardView extends ConsumerStatefulWidget {
//   const DashboardView({super.key});

//   @override
//   ConsumerState<DashboardView> createState() => _DashboardViewState();
// }

// class _DashboardViewState extends ConsumerState<DashboardView> {
//   late bool isDark;
//   @override
//   void initState() {
//     // isDark = ref.read(isDarkThemeProvider);
//     isDark = false;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dashboard View'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               // ref.read(batchViewModelProvider.notifier).getBatches();
//               // ref.read(courseViewModelProvider.notifier).getCourses();
//               showMySnackBar(message: 'Refressing...');
//             },
//             icon: const Icon(
//               Icons.refresh,
//               color: Colors.white,
//             ),
//           ),
//           IconButton(
//             onPressed: () {
//               ref.read(homeViewModelProvider.notifier).logout();
//             },
//             icon: const Icon(
//               Icons.logout,
//               color: Colors.white,
//             ),
//           ),
//           Switch(
//               value: isDark,
//               onChanged: (value) {
//                 setState(() {
//                   isDark = value;
//                   // ref.read(isDarkThemeProvider.notifier).updateTheme(value);
//                 });
//               }),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             const SizedBox(height: 10),
//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Hey Saru, Choose what you need !',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             const TextField(
//               decoration: InputDecoration(
//                 hintText: 'Search Artists',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: ListView(
//                 children: const [],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
