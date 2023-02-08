import 'package:admin/models/bank_accout.model.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/constants.dart';

class BankAccountList extends StatelessWidget {
  const BankAccountList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bank Accounts",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            height: 530,
            child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 1000,
              columns: [
                DataColumn2(
                  label: Text("IBAN"),
                  size: ColumnSize.L,
                ),
                DataColumn2(
                  label: Text("Swift Code"),
                  size: ColumnSize.S,
                ),
                DataColumn2(
                  label: Text("Currency"),
                  size: ColumnSize.S,
                ),
                DataColumn2(
                  label: Text("Bank"),
                  size: ColumnSize.M,
                ),
                DataColumn2(
                  label: Text("Organization"),
                  size: ColumnSize.S,
                ),
              ],
              rows: List.generate(
                bankAccounts.length,
                (index) => bankAccountDataRow(context, bankAccounts[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow bankAccountDataRow(BuildContext context, BankAccount bankAccount) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: bankAccount.iban));

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('IBAN copied to clipboard'),
                ));
              },
              icon: Icon(Icons.copy),
            ),
            Text(bankAccount.iban),
          ],
        ),
      ),
      DataCell(
        Text(
          bankAccount.swiftCode.toString(),
        ),
      ),
      DataCell(
        Text(bankAccount.currency.toString()),
      ),
      DataCell(
        Container(
          height: 30,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  bankAccount.bankName.toUpperCase(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
      DataCell(
        Container(
          padding: EdgeInsets.all(defaultPadding * 0.1),
          height: 30,
          width: 80,
          decoration: BoxDecoration(
            color: bankAccount.organizationColor.withOpacity(0.4),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: Text(
              bankAccount.organizationName.toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ),
    ],
  );
}
