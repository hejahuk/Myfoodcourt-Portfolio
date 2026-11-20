import 'package:flutter/material.dart';
import 'package:food_court/features/controller/singup_controller.dart';
import 'package:food_court/utilies/valitation.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Mysingup extends StatelessWidget {
  const Mysingup({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: dark ? const Color(0xFF121212) : const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: dark ? Colors.grey[900] : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Iconsax.arrow_left,
            color: dark ? Colors.white : Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Let's create your account",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              Form(
                key: controller.signupFormKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller.firstName,
                            validator: (value) => TValidator.volidateEmptyText(
                              'First Name',
                              value,
                            ),
                            decoration: InputDecoration(
                              labelText: "First Name",
                              prefixIcon: const Icon(
                                Iconsax.user,
                                color: Colors.redAccent,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: controller.lastName,
                            validator: (value) => TValidator.volidateEmptyText(
                              'Last Name',
                              value,
                            ),
                            decoration: InputDecoration(
                              labelText: "Last Name",
                              prefixIcon: const Icon(
                                Iconsax.user,
                                color: Colors.redAccent,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: controller.username,
                      validator: (value) =>
                          TValidator.volidateEmptyText('User Name', value),
                      decoration: InputDecoration(
                        labelText: "Username",
                        prefixIcon: const Icon(
                          Iconsax.user_edit,
                          color: Colors.redAccent,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: controller.email,
                      validator: (value) => TValidator.volidateEmail(value),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "E-Mail",
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Colors.redAccent,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: controller.phoneNumber,
                      validator: (value) =>
                          TValidator.volidatePhoneNumber(value),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        prefixIcon: const Icon(
                          Iconsax.call,
                          color: Colors.redAccent,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Obx(
                      () => TextFormField(
                        controller: controller.password,
                        validator: (value) =>
                            TValidator.validatePassword(value),
                        obscureText: controller.hidePassword.value,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: const Icon(
                            Iconsax.password_check,
                            color: Colors.redAccent,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => controller.hidePassword.value =
                                !controller.hidePassword.value,
                            icon: Icon(
                              controller.hidePassword.value
                                  ? Iconsax.eye_slash
                                  : Iconsax.eye,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Obx(
                            () => Checkbox(
                              value: controller.privacypolicy.value,
                              activeColor: Colors.redAccent,
                              onChanged: (value) =>
                                  controller.privacypolicy.value =
                                      !controller.privacypolicy.value,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: InkWell(
                            onTap: () => controller.privacypolicy.value =
                                !controller.privacypolicy.value,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "I agree to ",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                  TextSpan(
                                    text: "Privacy Policy",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .apply(
                                          color: Colors.redAccent,
                                          fontWeightDelta: 2,
                                          decoration: TextDecoration.underline,
                                        ),
                                  ),
                                  TextSpan(
                                    text: " and ",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                  TextSpan(
                                    text: "Terms of use",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .apply(
                                          color: Colors.redAccent,
                                          fontWeightDelta: 2,
                                          decoration: TextDecoration.underline,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => controller.signup(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Create Account",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Divider(
                      color: dark ? Colors.grey[700] : Colors.grey,
                      thickness: 0.5,
                      indent: 40,
                      endIndent: 10,
                    ),
                  ),
                  Text(
                    "or sign up with",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Flexible(
                    child: Divider(
                      color: dark ? Colors.grey[700] : Colors.grey,
                      thickness: 0.5,
                      indent: 10,
                      endIndent: 40,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
