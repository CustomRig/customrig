import 'package:customrig/model/base_item.dart';
import 'package:customrig/model/item.dart';
import 'package:customrig/widgets/dialogs/item_details_dialog.dart';
import 'package:customrig/widgets/global_widgets/my_badge.dart';
import 'package:flutter/material.dart';
import '../../utils/helpers.dart';

class RigItemTable extends StatelessWidget {
  final BaseItem item;
  const RigItemTable(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(1, 1),
            blurRadius: 3,
          ),
        ],
      ),
      columns: const [
        DataColumn(
          label: Text(
            'ITEM',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          numeric: true,
          label: Text(
            'PRICE (₹)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
      rows: [
        if (item.motherboard != null)
          _buildRow(
            context,
            item: item.motherboard,
          ),

        if (item.processor != null)
          _buildRow(
            context,
            item: item.processor,
          ),

        if (item.ram != null)
          _buildRow(
            context,
            item: item.ram,
          ),

        if (item.storage != null)
          _buildRow(
            context,
            item: item.storage,
          ),

        if (item.powerSupply != null)
          _buildRow(
            context,
            item: item.powerSupply,
          ),

        if (item.wifiAdapter != null)
          _buildRow(
            context,
            item: item.wifiAdapter,
          ),

        if (item.operatingSystem != null)
          _buildRow(
            context,
            item: item.operatingSystem,
          ),

        // Total price Row
        DataRow(
          selected: true,
          cells: [
            DataCell(
              Text(
                item.type == 'RIG' ? 'TOTAL PRICE' : 'PRICE',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataCell(
              MyBadge(text: '₹ ' + formatCurrency(item.price!)),
            ),
          ],
        ),
      ],
    );
  }

  DataRow _buildRow(
    BuildContext context, {
    required Item? item,
  }) {
    final screenSize = MediaQuery.of(context).size;
    return DataRow(
      cells: [
        DataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item?.category?.snakeCaseToTitleCase().toUpperCase() ?? '',
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(
                width: screenSize.width * 0.4,
                child: Text(
                  item?.title ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          onTap: () {
            showMyDialog(context, ItemDetailsDialog(item!));
          },
        ),
        DataCell(
          Text(
            formatCurrency(item?.price ?? 0),
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
      ],
    );
  }
}
