import 'package:flutter/material.dart';
import 'package:food_court/features/controller/user_controller.dart';
import 'package:food_court/utilies/valitation.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ChangeUsername extends StatelessWidget {
  const ChangeUsername({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final textController = TextEditingController(text: controller.user.value.username);
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Change Username')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Update your unique campus handle for easier identification.'),
              const SizedBox(height: 16),
              TextFormField(
                controller: textController,
                validator: (value) => TValidator.volidateEmptyText('Username', value),
                decoration: const InputDecoration(labelText: 'Username', prefixIcon: Icon(Iconsax.user_edit)),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await controller.updateUsername(textController.text.trim());
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