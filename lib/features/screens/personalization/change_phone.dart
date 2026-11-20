import 'package:flutter/material.dart';
import 'package:food_court/features/controller/user_controller.dart';
import 'package:food_court/utilies/valitation.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ChangePhone extends StatelessWidget {
  const ChangePhone({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final textController = TextEditingController(text: controller.user.value.phoneNumber);
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Change Phone Number')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Update your contact number for stall pickup updates.'),
              const SizedBox(height: 16),
              TextFormField(
                controller: textController,
                validator: (value) => TValidator.volidatePhoneNumber(value),
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Phone Number', prefixIcon: Icon(Iconsax.call)),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await controller.updatePhoneNumber(textController.text.trim());
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                  child: const Text('Save', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}