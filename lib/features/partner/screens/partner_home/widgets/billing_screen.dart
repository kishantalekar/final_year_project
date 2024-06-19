import 'package:final_year_project/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:final_year_project/common/widgets/texts/section_heading.dart';
import 'package:final_year_project/core/custom_enums.dart';
import 'package:final_year_project/features/home/models/picup_request_model.dart';
import 'package:final_year_project/features/home/models/scrap_item.dart';
import 'package:final_year_project/features/partner/controller/partner_controller.dart';
import 'package:final_year_project/utils/constants/enums.dart';
import 'package:final_year_project/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class BillingScreen extends StatefulWidget {
  BillingScreen({super.key, required this.request});
  final PickupRequestModel request;

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();

    // Initialize Razorpay instance
    _razorpay = Razorpay();

    // Register event listeners
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    // Dispose of Razorpay instance and unregister event listeners
    _razorpay.clear();
    //  / Re-initialize or clear the instance
    super.dispose();
  }

  var options = {
    'key': 'rzp_test_GcZZFDPPOjHtC4',
    'amount': 1000,
    'name': 'Ecobarter',
    'description': 'Payment for scraps',
    'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
  };

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle payment success
    print("Payment successful: ${response.paymentId}");
    PartnerController.instance.completePickup(widget.request);
    // Perform actions on success, e.g., update UI, navigate to next screen, etc.
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure
    print("Payment error: ${response.code} - ${response.message}");
    // Perform actions on failure, e.g., show error message, retry payment, etc.
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet selection
    print("External wallet selected: ${response.walletName}");
    // Perform actions for external wallet, e.g., initiate payment through the wallet, etc.
  }

  @override
  Widget build(BuildContext context) {
    final controller = PartnerController.instance;

    void handlePay() {
      var options = {
        'key': 'rzp_test_WHDwkn3KLG9Dqe',
        'amount': (widget.request.totalCost * 100).toInt(), // Amount in paise
        'name': 'Ecobarter',
        'description': 'Payment for scraps',
        'prefill': {
          'contact': widget.request.number,
          'email': 'test@razorpay.com'
        }
      };
      try {
        _razorpay.open(options);
      } catch (e) {
        print("Error opening Razorpay: $e");
      }
    }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomerDetails(
                username: "Kishan",
                time: THelperFunctions.getFormattedDate(
                    widget.request.scheduledTime),
                address: widget.request.address,
              ),
              const Gap(TSizes.spaceBtwItems),
              const Divider(),
              const Gap(TSizes.spaceBtwItems),
              BillSummary(
                totalMaterial: widget.request.items.length,
                totalQuantity: THelperFunctions.calculateTotalQuantities(
                    widget.request.items),
                totalCost: widget.request.totalCost,
              ),
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
                  rows: widget.request.items
                      .map((item) => DataRow(cells: [
                            DataCell(Text(
                              item.title,
                              style: Theme.of(context).textTheme.titleMedium,
                            )),
                            DataCell(
                              Text(
                                "${item.cost}",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            DataCell(Text(
                              item.unitType == UnitType.kg
                                  ? "${item.kg}/kg"
                                  : "${item.pcs}/pieces",
                              style: Theme.of(context).textTheme.titleMedium,
                            )),
                            DataCell(Text(
                              (item.cost * item.kg).toString(),
                              style: Theme.of(context).textTheme.titleMedium,
                            )),
                          ]))
                      .toList(),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(TSizes.defaultSpace),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "₹${widget.request.totalCost}",
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                  ],
                ),
              ),
              Text(
                "Payment method ",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        'Cash on Delivery',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      leading: Radio<PaymentMethods>(
                        activeColor: TColors.primary,
                        value: PaymentMethods.cod,
                        groupValue: controller.paymentMethod.value,
                        onChanged: (value) =>
                            controller.updatePaymentMethod(value),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'razor pay',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      leading: Radio<PaymentMethods>(
                        activeColor: TColors.primary,
                        value: PaymentMethods.razorPay,
                        groupValue: controller.paymentMethod.value,
                        onChanged: (value) =>
                            controller.updatePaymentMethod(value),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: controller.paymentMethod.value == PaymentMethods.cod
              ? ElevatedButton(
                  child: Text(
                      "proceed to pay ₹${widget.request.totalCost} with cod"),
                  onPressed: () =>
                      PartnerController.instance.completePickup(widget.request),
                )
              : ElevatedButton(
                  child: Text(
                      "Proceed to pay ₹${widget.request.totalCost} with Razorpay"),
                  onPressed: () {
                    handlePay();
                  },
                ),
        ),
      ),
    );
  }
}

class BillSummary extends StatelessWidget {
  const BillSummary({
    super.key,
    required this.totalCost,
    required this.totalQuantity,
    required this.totalMaterial,
  });

  final double totalCost;
  final String totalQuantity;
  final int totalMaterial;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.all(TSizes.md),
      backgroundColor: Colors.lightBlue.shade100.withOpacity(0.5),
      child: Column(
        children: [
          BillSummaryItem(
            title: "Total material",
            subTitle: "$totalMaterial",
          ),
          const Gap(
            10,
          ),
          BillSummaryItem(title: 'Total qunatity', subTitle: '$totalQuantity'),
          const Gap(
            10,
          ),
          Divider(
            color: Colors.blue.shade200,
          ),
          BillSummaryItem(
            title: 'Total',
            subTitle: '₹$totalCost',
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
    required this.username,
    required this.time,
    required this.address,
  });
  final String username;
  final String time;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              maxLines: 2,
              username,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              maxLines: 2,
              time,
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
                address,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          ],
        )
      ],
    );
  }
}
