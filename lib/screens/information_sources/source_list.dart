import 'package:admin/models/information_source.model.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/constants.dart';

class SourceList extends StatelessWidget {
  const SourceList({
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
            "Sources",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            height: 200,
            child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 500,
              columns: [
                DataColumn2(
                  label: Text("Organization"),
                  size: ColumnSize.L,
                ),
                DataColumn2(
                  label: Text("Type"),
                  size: ColumnSize.S,
                ),
                DataColumn2(label: Text("Source"), size: ColumnSize.S, fixedWidth: 170),
              ],
              rows: List.generate(
                sources.length,
                (index) => bankAccountDataRow(context, sources[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow bankAccountDataRow(BuildContext context, InformationSource source) {
  String parseLink(String link) {
    return link.replaceAll('https://', '').split('/').first;
  }

  return DataRow(
    cells: [
      DataCell(
        Container(
          padding: EdgeInsets.all(defaultPadding * 0.1),
          height: 30,
          width: 80,
          decoration: BoxDecoration(
            color: source.color.withOpacity(0.4),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: Text(
              source.organization.toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ),
      DataCell(
        Row(
          children: [
            Text(source.type),
          ],
        ),
      ),
      DataCell(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(parseLink(source.link)),
            IconButton(
              onPressed: () {
                launchUrl(Uri.parse(source.link));
              },
              icon: Icon(
                Icons.open_in_new,
                size: 15,
              ),
            )
          ],
        ),
      ),
    ],
  );
}
