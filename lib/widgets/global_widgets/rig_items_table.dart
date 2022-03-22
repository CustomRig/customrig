import 'package:customrig/model/base_item.dart';
import 'package:customrig/widgets/global_widgets/my_badge.dart';
import 'package:flutter/material.dart';

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
        _buildRow(
          title: item.motherboard?.title ?? '',
          price: item.motherboard?.price.toString() ?? '',
        ),
        _buildRow(
          title: item.processor?.title ?? '',
          price: item.processor?.price.toString() ?? '',
        ),
        _buildRow(
          title: item.ram?.title ?? '',
          price: item.ram?.price.toString() ?? '',
        ),
        _buildRow(
          title: item.storage?.title ?? '',
          price: item.storage?.price.toString() ?? '',
        ),
        _buildRow(
          title: item.powerSupply?.title ?? '',
          price: item.powerSupply?.price.toString() ?? '',
        ),
        _buildRow(
          title: item.wifiAdapter?.title ?? '',
          price: item.wifiAdapter?.price.toString() ?? '',
        ),
        _buildRow(
          title: item.operatingSystem?.title ?? '',
          price: item.operatingSystem?.price.toString() ?? '',
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
              MyBadge(text: item.price.toString(), secondary: true),
            ),
          ],
        ),
      ],
    );
  }

  DataRow _buildRow({required String title, required String price}) {
    return DataRow(
      cells: [
        DataCell(Text(title)),
        DataCell(MyBadge(text: price)),
      ],
    );
  }
}
