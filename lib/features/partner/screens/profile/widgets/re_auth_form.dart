// import 'package:ecommerce_app/common/widgets/appbar/appbar.dart';
// import 'package:ecommerce_app/features/authentication/screens/signup/signup.dart';
// import 'package:ecommerce_app/features/personalization/controllers/user_controller.dart';
// import 'package:ecommerce_app/utils/constants/sizes.dart';
// import 'package:ecommerce_app/utils/constants/text_strings.dart';
// import 'package:ecommerce_app/utils/validators/validation.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';

// class ReAuthLoginForm extends StatelessWidget {
//   const ReAuthLoginForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = UserController.instance;
//     return Scaffold(
//       appBar: TAppBar(
//         title: Text("Reauth form"),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(TSizes.defaultSpace),
//           child: Form(
//             key: controller.reAuthFormKey,
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
//               child: Column(
//                 children: [
//                   TextFormField(
//                     controller: controller.verifyEmail,
//                     validator: (value) => TValidator.validateEmail(value),
//                     decoration: const InputDecoration(
//                         prefix: Icon(Iconsax.direct_right),
//                         labelText: TTexts.email),
//                   ),
//                   const SizedBox(
//                     height: TSizes.spaceBtwInputFields,
//                   ),
//                   Obx(
//                     () => TextFormField(
//                       obscureText: controller.hidePassword.value,
//                       validator: (value) => TValidator.validatePassword(value),
//                       controller: controller.verifyPassword,
//                       decoration: InputDecoration(
//                           prefix: const Icon(Iconsax.password_check),
//                           labelText: TTexts.password,
//                           suffixIcon: IconButton(
//                               onPressed: () => controller.hidePassword.value =
//                                   !controller.hidePassword.value,
//                               icon: Icon(controller.hidePassword.value
//                                   ? Iconsax.eye_slash
//                                   : Iconsax.eye))),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: TSizes.spaceBtwInputFields / 2,
//                   ),

//                   //remember me and forgot password

//                   const SizedBox(
//                     height: TSizes.spaceBtwSections,
//                   ),

//                   const SizedBox(
//                     height: TSizes.spaceBtwItems,
//                   ),
//                   SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                           onPressed: () => controller.reAuthEmailAndPassword(),
//                           child: const Text("Verify"))),

//                   const SizedBox(
//                     height: TSizes.spaceBtwSections,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
