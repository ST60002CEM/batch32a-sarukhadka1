import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/features/home/domain/entity/artist_entity.dart';
import 'package:flutter/material.dart';

 
class SingleView extends StatelessWidget {
  final ArtistEntity singleArtist;
  final int selectedQuantity;
  final VoidCallback onAddToBag;
  final VoidCallback onIncreaseQuantity;
  final VoidCallback onDecreaseQuantity;
 
  const SingleView({
    Key? key,
    required this.singleArtist,
    required this.selectedQuantity,
    required this.onAddToBag,
    required this.onIncreaseQuantity,
    required this.onDecreaseQuantity,
  }) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    final imageUrl = '${ApiEndpoints.imageUrl}${singleArtist.artistImage}';
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Colors.blue.shade800;
    final secondaryColor = Colors.blue.shade400;
 
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppBar(
              title: const Text('Artist Details'),
              backgroundColor: primaryColor,
              elevation: 0,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image
                      AspectRatio(
                        aspectRatio: 4 / 3,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 16.0),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: primaryColor,
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Product Name
                      Text(
                        singleArtist.artistName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Price
                      Text(
                        'Rs.${singleArtist.artistRate.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Quantity Selector and Add to Cart
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: primaryColor,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  child: IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: singleArtist.artistRate > 0
                                        ? onDecreaseQuantity
                                        : null,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    '$selectedQuantity',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  child: IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: singleArtist.artistRate > 0
                                        ? onIncreaseQuantity
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: singleArtist.artistRate > 0
                                ? onAddToBag
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: singleArtist.artistRate > 0
                                  ? primaryColor
                                  : Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            icon: const Icon(Icons.shopping_bag_outlined,
                                color: Colors.white),
                            label: const Text(
                              "Add to Cart",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Product Description Box
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: primaryColor,
                            width: 1,
                          ),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Description Points
                            Text(
                              '• High-quality material ensures durability and longevity.\n'
                              '• Stylish design that fits seamlessly with your home decor.\n'
                              '• Easy to use with intuitive controls and features.\n'
                              '• Affordable pricing without compromising on quality.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black, // Dark text for contrast
                              ),
                            ),
                            SizedBox(height: 16),
                            // Rating and Reviews
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 20),
                                SizedBox(width: 4),
                                Text(
                                  '5.0',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black, // Dark text for contrast
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  '(2 reviews)',
                                  style: TextStyle(fontSize: 16, color: Colors.black), // Dark text for contrast
                                ),
                              ],
                            ),
                          ],
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