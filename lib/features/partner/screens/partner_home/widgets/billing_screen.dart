import 'package:final_year_project/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';

class BillingScreen extends StatelessWidget {
  const BillingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bill detail",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const CustomerDetails(),
              const Gap(TSizes.spaceBtwItems),
              const Divider(),
              const Gap(TSizes.spaceBtwItems),
              const BillSummary(),
              const Gap(TSizes.spaceBtwItems),
              const Divider(),
              const Gap(TSizes.spaceBtwItems),
              FittedBox(
                child: DataTable(
                    border: TableBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.08);
                      }
                      return Colors.green.shade100; // Use the default value.
                    }),
                    columns: [
                      DataColumn(
                        label: Text(
                          "Material",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Rate",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Qty",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Amount",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text(
                          "Aluminium",
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                        DataCell(
                          Text(
                            "57/kg",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        DataCell(Text(
                          "2 kg",
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                        DataCell(Text(
                          "114",
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                      ]),
                      DataRow(cells: [
                        DataCell(Text(
                          "Aluminium",
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                        DataCell(
                          Text(
                            "57/kg",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        DataCell(Text(
                          "2 kg",
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                        DataCell(Text(
                          "114",
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                      ]),
                      DataRow(cells: [
                        DataCell(Text(
                          "Aluminium",
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                        DataCell(
                          Text(
                            "57/kg",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        DataCell(Text(
                          "2 kg",
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                        DataCell(Text(
                          "114",
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                      ]),
                    ]),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          child: const Text("Complete"),
          onPressed: () {},
        ),
      ),
    );
  }
}

class BillSummary extends StatelessWidget {
  const BillSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.all(TSizes.md),
      backgroundColor: Colors.lightBlue.shade100.withOpacity(0.5),
      child: Column(
        children: [
          const BillSummaryItem(
            title: "Total material",
            subTitle: "12",
          ),
          const Gap(
            10,
          ),
          const BillSummaryItem(
              title: 'Total qunatity', subTitle: '12kg,7 pieces'),
          const Gap(
            10,
          ),
          Divider(
            color: Colors.blue.shade200,
          ),
          const BillSummaryItem(
            title: 'Total',
            subTitle: '\$570',
            bold: true,
          )
        ],
      ),
    );
  }
}

class BillSummaryItem extends StatelessWidget {
  const BillSummaryItem({
    super.key,
    required this.title,
    required this.subTitle,
    this.bold = false,
  });

  final String title;
  final String subTitle;
  final bool bold;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          maxLines: 1,
          title,
          style: !bold
              ? Theme.of(context).textTheme.bodyMedium
              : Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          maxLines: 1,
          subTitle,
          style: Theme.of(context).textTheme.titleMedium,
        )
      ],
    );
  }
}

class CustomerDetails extends StatelessWidget {
  const CustomerDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              maxLines: 2,
              'Kishan talekar',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              maxLines: 2,
              '27,oct 2024',
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
        const Gap(TSizes.spaceBtwItems),
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
    );
  }
}
