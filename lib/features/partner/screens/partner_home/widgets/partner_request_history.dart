import 'package:final_year_project/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:final_year_project/utils/constants/colors.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}

class PartnerRequestHistory extends StatefulWidget {
  const PartnerRequestHistory({super.key});

  @override
  State<PartnerRequestHistory> createState() => _PartnerRequestHistoryState();
}

class _PartnerRequestHistoryState extends State<PartnerRequestHistory> {
  int selectedIndex = 0;

  void updateSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<CustomChip> customChipsList =
        ["All", "Completed", "Rejected", "Cancelled"]
            .mapIndexed((e, i) => CustomChip(
                  title: e,
                  selected: selectedIndex,
                  index: i,
                  updateSelectedIndex: updateSelectedIndex,
                ))
            .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request history"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
                child: ListView.separated(
                  itemCount: customChipsList.length,
                  separatorBuilder: (context, index) =>
                      const Gap(TSizes.spaceBtwItems),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Row(
                        children: [
                          const Gap(TSizes.spaceBtwItems),
                          customChipsList[index]
                        ],
                      );
                    }
                    return customChipsList[index];
                  },
                ),
              ),
              const Gap(20),
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    return const OrderCard();
                  }),
                  separatorBuilder: (context, index) =>
                      const Gap(TSizes.spaceBtwItems),
                  itemCount: 4)
            ],
          ),
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Gap(10),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
              padding: const EdgeInsets.all(TSizes.sm),
              child: Text(
                "Completed",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: TColors.white),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(TSizes.md),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(22)),
          child: Column(
            children: [
              Row(
                children: [
                  const Image(
                    image: AssetImage(
                      TImages.user,
                    ),
                    width: 60,
                    height: 60,
                  ),
                  const Gap(10),
                  Column(
                    children: [
                      Text("Placed by",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.grey)),
                      const Gap(2),
                      Text("Kishan",
                          style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  )
                ],
              ),
              const Gap(10),
              const Divider(),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Pickup date and time",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.green.shade700)),
                      const Gap(2),
                      Text("jun 12 may ",
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Estimated weight",
                          style: Theme.of(context).textTheme.bodyLarge!),
                      const Gap(2),
                      Text("25",
                          style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  )
                ],
              ),
              const Gap(10),
              const Divider(),
              const Gap(10),
              Row(
                children: [
                  Icon(
                    Iconsax.location,
                    color: Colors.green.shade800,
                  ),
                  const Gap(TSizes.spaceBtwItems),
                  Expanded(
                    child: Text(
                      maxLines: 2,
                      'sadashivgad ,karwar halgejoog 581328 halgejoog ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.title,
    required this.selected,
    required this.index,
    required this.updateSelectedIndex,
  });

  final String title;
  final int selected;
  final int index;
  final Function(int) updateSelectedIndex;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        updateSelectedIndex(index);
      },
      child: Chip(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(34),
        ),
        label: Text(
          title,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: selected == index ? TColors.light : TColors.black),
        ),
        backgroundColor: selected == index ? Colors.green.shade800 : null,
      ),
    );
  }
}
