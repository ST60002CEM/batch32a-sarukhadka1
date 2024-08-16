import 'package:final_assignment/features/mybooking/presentation/viewmodel/booking_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class BookingListView extends ConsumerWidget {
  const BookingListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bookingListViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Booking List'),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(child: Text('Error: ${state.error}'))
              : state.bookings.isEmpty
                  ? const Center(child: Text('No bookings available'))
                  : SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 16.0,
                          columns: const [
                            // DataColumn(label: Text('Property')),
                            DataColumn(label: Text('Time')),
                            DataColumn(label: Text('Date')),
                            // DataColumn(label: Text('Payment Method')),
                            DataColumn(label: Text('Action')),
                          ],
                          rows: state.bookings.map((booking) {
                            final formattedDate =
                                DateFormat('yyyy-MM-dd').format(booking.date);
                            return DataRow(cells: [
                              // DataCell(Text(booking.property)),
                              DataCell(Text(booking.time)),
                              DataCell(Text(formattedDate)),
                              // DataCell(Text(booking.paymentMethod)),
                              DataCell(
                                ElevatedButton(
                                  onPressed: () {
                                    // _handleProceedToPayment(
                                    //   context,
                                    //   booking.id!,

                                    // );
                                    ref
                                        .read(bookingListViewModelProvider
                                            .notifier)
                                        .openKhaltiView();
                                  },
                                  child: const Text('Proceed to payment'),
                                ),
                              ),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
    );
  }

  void _handleProceedToPayment(BuildContext context, String bookingId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose a Payment Method'),
        content: const Text('Please select a payment method:'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _updatePaymentMethod(context, bookingId, 'Pay on arrival');
            },
            child: const Text('Pay on Arrival'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _updatePaymentMethod(context, bookingId, 'Khalti Payme/nt');
            },
            child: const Text('Khalti Payment'),
          ),
        ],
      ),
    );
  }

  void _updatePaymentMethod(
      BuildContext context, String bookingId, String paymentMethod) {
    // Implement the logic to update the payment method in your booking
    // You might want to call a method in your ViewModel to perform the update
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Payment Method Selected'),
        content: Text('You have selected $paymentMethod.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
