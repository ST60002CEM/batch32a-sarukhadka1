import 'package:final_assignment/features/mybooking/presentation/viewmodel/booking_list_view_model.dart';
import 'package:final_assignment/features/mybooking/presentation/widgets/dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class BookingListView extends ConsumerWidget {
  const BookingListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bookingListViewModelProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Static mapping of artist IDs to names
    final artistNameMap = {
      '1': 'Sabita',
      '2': 'Simran',
      '3': 'Slesha',
      // Add more mappings as needed
    };

    // Function to get artist name from ID
    String getArtistName(String artistId) {
      return artistNameMap[artistId] ??
          'Simran'; // Default to 'Simran' if ID not found
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Booking List',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.purple,
        elevation: 0,
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600;

          return Center(
            child: Container(
              width: isTablet ? 800 : double.infinity,
              color: isDarkMode ? Colors.black : Colors.pink[50],
              padding: EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 8.0,
              ),
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.error != null
                      ? Center(
                          child: Text(
                            'Error: ${state.error}',
                            style: TextStyle(
                              color: isDarkMode ? Colors.redAccent : Colors.red,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : state.bookings.isEmpty
                          ? const Center(
                              child: Text(
                                'No bookings available',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: DataTable(
                                      columnSpacing: isTablet ? 150.0 : 24.0,
                                      headingRowColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => isDarkMode
                                                  ? Colors.grey[800]!
                                                  : Colors.purple[100]!),
                                      columns: [
                                        DataColumn(
                                          label: Text(
                                            'Time',
                                            style: TextStyle(
                                              color: isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Date',
                                            style: TextStyle(
                                              color: isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Artist',
                                            style: TextStyle(
                                              color: isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Action',
                                            style: TextStyle(
                                              color: isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                      rows: state.bookings.map((booking) {
                                        final formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(booking.date);
                                        return DataRow(cells: [
                                          DataCell(
                                            Text(
                                              booking.time,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: isDarkMode
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              formattedDate,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: isDarkMode
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              getArtistName(booking.artist),
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: isDarkMode
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return const KhaltiPaymentDialog();
                                                  },
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: isDarkMode
                                                    ? Colors.white
                                                    : Color.fromARGB(
                                                        255, 172, 88, 185),
                                                foregroundColor: isDarkMode
                                                    ? Colors.black
                                                    : Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              child: const Text(
                                                'Pay Now',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]);
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
            ),
          );
        },
      ),
    );
  }
}
