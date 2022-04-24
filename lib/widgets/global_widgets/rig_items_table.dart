import 'package:customrig/model/base_item.dart';
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
        DataColumn(label: Text('ITEM')),
        DataColumn(numeric: true, label: Text('PRICE (₹)')),
      ],
      rows: [
        if (item.motherboard != null)
          _buildRow(
            context,
            title: item.motherboard?.title ?? '',
            price: item.motherboard?.price ?? 0,
            category: item.motherboard?.category ?? '',
          ),

        if (item.processor != null)
          _buildRow(
            context,
            title: item.processor?.title ?? '',
            price: item.processor?.price ?? 0,
            category: item.processor?.category ?? '',
          ),

        if (item.ram != null)
          _buildRow(
            context,
            title: item.ram?.title ?? '',
            price: item.ram?.price ?? 0,
            category: item.ram?.category ?? '',
          ),

        if (item.storage != null)
          _buildRow(
            context,
            title: item.storage?.title ?? '',
            price: item.storage?.price ?? 0,
            category: item.storage?.category ?? '',
          ),

        if (item.powerSupply != null)
          _buildRow(
            context,
            title: item.powerSupply?.title ?? '',
            price: item.powerSupply?.price ?? 0,
            category: item.powerSupply?.category ?? '',
          ),

        if (item.wifiAdapter != null)
          _buildRow(
            context,
            title: item.wifiAdapter?.title ?? '',
            price: item.wifiAdapter?.price ?? 0,
            category: item.wifiAdapter?.category ?? '',
          ),

        if (item.operatingSystem != null)
          _buildRow(
            context,
            title: item.operatingSystem?.title ?? '',
            price: item.operatingSystem?.price ?? 0,
            category: item.operatingSystem?.category ?? '',
          ),

        // Total price Row
        DataRow(
          selected: true,
          cells: [
            const DataCell(
              Text(
                'TOTAL',
                style: TextStyle(fontWeight: FontWeight.bold),
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
    required String title,
    required int price,
    required String category,
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
                category.snakeCaseToTitleCase().toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(
                width: screenSize.width * 0.4,
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Text(
            formatCurrency(price),
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
