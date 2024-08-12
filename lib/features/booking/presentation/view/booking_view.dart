import 'package:final_assignment/features/booking/domain/entity/booking_entity.dart';
import 'package:final_assignment/features/booking/presentation/viewmodel/booking_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class BookingView extends ConsumerStatefulWidget {
  const BookingView({super.key});

  @override
  ConsumerState<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends ConsumerState<BookingView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookingViewmodelProvider);
    final viewModel = ref.read(bookingViewmodelProvider.notifier);

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Artist'),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.purple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please fill out the form to book an artist:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _nameController,
                label: 'Name',
                icon: Icons.person,
                isDarkMode: isDarkMode,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _emailController,
                label: 'Email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                isDarkMode: isDarkMode,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _phoneController,
                label: 'Phone',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                isDarkMode: isDarkMode,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildDateField(isDarkMode),
              const SizedBox(height: 16),
              _buildTimeField(isDarkMode),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      const user =
                          'someUser'; // Replace with actual user ID
                      const artist =
                          'someArtist'; // Replace with actual artist ID

                      final booking = BookingEntity(
                        user: user,
                        artist: artist,
                        date: selectedDate!,
                        time: _timeController.text,
                        status: 'pending',
                        paymentMethod: 'Cash on arrival',
                      );

                      // Call the ViewModel to handle the booking submission
                      viewModel.addBooking(booking);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    backgroundColor:
                        isDarkMode ? Colors.grey[850] : Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: state.isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : const Text('Submit Booking'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isDarkMode = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle:
            TextStyle(color: isDarkMode ? Colors.white70 : Colors.black87),
        prefixIcon:
            Icon(icon, color: isDarkMode ? Colors.white70 : Colors.black87),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        filled: true,
        fillColor: isDarkMode ? Colors.grey[800] : Colors.pink[50],
      ),
      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
      validator: validator,
    );
  }

  Widget _buildDateField(bool isDarkMode) {
    return TextFormField(
      controller: _dateController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Preferred Date',
        labelStyle:
            TextStyle(color: isDarkMode ? Colors.white70 : Colors.black87),
        prefixIcon: Icon(Icons.calendar_today,
            color: isDarkMode ? Colors.white70 : Colors.black87),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        filled: true,
        fillColor: isDarkMode ? Colors.grey[800] : Colors.pink[50],
      ),
      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2101),
        );
        if (picked != null && picked != selectedDate) {
          setState(() {
            selectedDate = picked;
            _dateController.text = DateFormat('MM/dd/yyyy').format(picked);
          });
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a preferred date';
        }
        return null;
      },
    );
  }

  Widget _buildTimeField(bool isDarkMode) {
    return TextFormField(
      controller: _timeController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Preferred Time',
        labelStyle:
            TextStyle(color: isDarkMode ? Colors.white70 : Colors.black87),
        prefixIcon: Icon(Icons.access_time,
            color: isDarkMode ? Colors.white70 : Colors.black87),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        filled: true,
        fillColor: isDarkMode ? Colors.grey[800] : Colors.pink[50],
      ),
      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
      onTap: () async {
        TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (picked != null && picked != selectedTime) {
          setState(() {
            selectedTime = picked;
            _timeController.text = picked.format(context);
          });
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a preferred time';
        }
        return null;
      },
    );
  }
}
