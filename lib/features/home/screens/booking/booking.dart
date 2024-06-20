import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:final_year_project/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:final_year_project/data/repo/auth/auth_repository.dart';
import 'package:final_year_project/features/home/controller/booking_controller.dart';
import 'package:final_year_project/features/home/controller/user_controller.dart';
import 'package:final_year_project/features/home/screens/booking/scrap_collector_search.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:final_year_project/features/home/screens/booking/widgets/custom_app_bar.dart';
import 'package:final_year_project/features/home/screens/booking/widgets/scrap_item_selection_page.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:final_year_project/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';

import '../../../../utils/constants/colors.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final PageController _pageController = PageController();
  int activeStep = 0;
  void _updateCurrentPageIndex() {
    if (activeStep == 2) {
      // activeStep++;
      Get.to(() => const ScrapCollectorSearch());
    } else {
      setState(() {
        activeStep++;
      });
    }
    _pageController.animateToPage(
      activeStep,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();

  DateTime _focusDate = DateTime.now().add(
    const Duration(hours: 24),
  );
  final DateTime _initialDate = DateTime.now().add(
    const Duration(hours: 24),
  );

  String formatDateTime(String datetimeStr) {
    // Parse the datetime string
    final datetime = DateTime.parse(datetimeStr);

    // Format the datetime object in the desired format
    final formattedDate = DateFormat('d MMM yyyy').format(datetime);
    final weekday =
        DateFormat('EEEE').format(datetime); // Use 'EEEE' for full weekday

    // Combine date and weekday with comma and space
    return '$weekday, $formattedDate';
  }

  @override
  Widget build(BuildContext context) {
    var inputDecoration = InputDecoration(
      errorMaxLines: 3,
      prefixIconColor: TColors.darkGrey,
      suffixIconColor: TColors.darkGrey,
      // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
      labelStyle: const TextStyle()
          .copyWith(fontSize: TSizes.fontSizeMd, color: TColors.black),
      hintStyle: const TextStyle()
          .copyWith(fontSize: TSizes.fontSizeSm, color: TColors.black),
      errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
      floatingLabelStyle:
          const TextStyle().copyWith(color: TColors.black.withOpacity(0.8)),
      labelText: "Add additional info",
      border: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey, // Set your desired color
          width: 2.0, // Set your desired thickness
        ),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey, // Set your desired color
          width: 2.0, // Set your desired thickness
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: TColors.primary
              .withOpacity(0.6), // Set your desired focus color (optional)
          width: 2.0, // Set your desired thickness
        ),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red, // Set your desired error color (optional)
          width: 2.0, // Set your desired thickness
        ),
      ),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red, // Set your desired error color (optional)
          width: 2.0, // Set your desired thickness
        ),
      ),
    );

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.max,
            children: [
              Stepper(),
              SizedBox(
                height: THelperFunctions.screenHeight(),
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (value) {
                    setState(() {
                      activeStep = value;
                    });
                  },
                  children: [
                    const ScrapItemSelectionPage(),
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select a date for scrap pickup',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        const Gap(TSizes.spaceBtwSections),
                        EasyInfiniteDateTimeLine(
                          showTimelineHeader: false,
                          controller: _controller,
                          firstDate: _initialDate,
                          focusDate: _focusDate,
                          lastDate: DateTime.now().add(
                            const Duration(days: 24),
                          ),
                          onDateChange: (selectedDate) {
                            setState(() {
                              _focusDate = selectedDate;
                              BookingController.instance.selectedBookingDate
                                  .value = selectedDate;
                            });
                          },
                        ),
                        const Gap(TSizes.spaceBtwItems),
                        Text(
                          'Our pickup executive will call you before coming',
                          style: Theme.of(context).textTheme.labelMedium,
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pickup confirmation',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const Gap(16),
                        const Text("Scrap items"),
                        const Gap(TSizes.spaceBtwItems),
                        Wrap(
                          spacing: TSizes.spaceBtwInputFields /
                              2, // gap between adjacent chips
                          runSpacing:
                              TSizes.spaceBtwItems / 2, // gap between lines
                          children:
                              BookingController.instance.selectedSubCategories
                                  .map((e) => RoundedContainer(
                                        showBorder: true,
                                        backgroundColor: TColors.lightContainer,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Text(
                                          e.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        ),
                                      ))
                                  .toList(),
                        ),
                        const Gap(TSizes.spaceBtwSections / 2),
                        const Divider(),
                        const Gap(TSizes.spaceBtwSections / 2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Address ',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Obx(
                              () => Text(
                                "near ${UserController.instance.user.value.address}",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                            TextField(
                              controller:
                                  BookingController.instance.addressController,
                              decoration: inputDecoration,
                            )
                          ],
                        ),
                        const Gap(TSizes.spaceBtwSections / 2),
                        const Divider(),
                        const Gap(TSizes.spaceBtwSections / 2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pickup',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Text(
                              formatDateTime(BookingController
                                  .instance.selectedBookingDate
                                  .toString()),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                        const Gap(TSizes.spaceBtwSections / 2),
                        const Divider(),
                        const Gap(TSizes.spaceBtwSections / 2),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text(
                        //       "Any instructions",
                        //       style: Theme.of(context).textTheme.labelLarge,
                        //     ),
                        //     const Gap(TSizes.spaceBtwItems / 2),
                        //     TextFormField(
                        //       maxLines: 4,
                        //       decoration: InputDecoration(
                        //           hintText:
                        //               "Any instruction for our pickup executive",
                        //           hintStyle:
                        //               Theme.of(context).textTheme.labelMedium),
                        //     )
                        //   ],
                        // )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Padding(
            padding: const EdgeInsets.all(8.0),
            child: BookingController.instance.selectedSubCategories.length > 0
                ? ElevatedButton(
                    onPressed: _updateCurrentPageIndex,
                    child: const Text("Continue"))
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: TColors.primary.withOpacity(0.4),
                        side: const BorderSide(color: Colors.transparent)),
                    onPressed: () {},
                    child: const Text("Continue"))),
      ),
    );
  }

  EasyStepper Stepper() {
    return EasyStepper(
      enableStepTapping: false,
      activeStep: activeStep,
      // steppingEnabled: false,
      lineStyle: LineStyle(
        finishedLineColor: TColors.primary,
        lineSpace: 0,
        lineType: LineType.normal,
        defaultLineColor: Colors.white,
        lineLength: THelperFunctions.screenWidth() * 0.25,
      ),
      activeStepTextColor: Colors.black87,
      finishedStepTextColor: Colors.black87,
      internalPadding: 0,
      showLoadingAnimation: false,
      stepRadius: 8,
      showStepBorder: false,
      // lineDotRadius: 1.5,
      steps: [
        EasyStep(
          customStep: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 7,
              backgroundColor: activeStep >= 0 ? TColors.primary : Colors.white,
            ),
          ),
          title: 'select items',
        ),
        EasyStep(
          customStep: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 7,
              backgroundColor: activeStep >= 1 ? TColors.primary : Colors.white,
            ),
          ),
          title: 'Pickup date',
        ),
        EasyStep(
          customStep: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 7,
              backgroundColor: activeStep >= 2 ? TColors.primary : Colors.white,
            ),
          ),
          title: 'Confirm',
        ),
      ],
      onStepReached: (index) => setState(() => activeStep = index),
    );
  }
}
