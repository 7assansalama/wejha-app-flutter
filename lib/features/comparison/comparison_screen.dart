import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';

class ComparisonScreen extends StatelessWidget {
  const ComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("مقارنة المدارس", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: DataTable(
              columnSpacing: 20.w,
              columns: const [
                DataColumn(label: Text('المميزات')),
                DataColumn(label: Text('مدرسة المستقبل')),
                DataColumn(label: Text('مدرسة النيل')),
              ],
              rows: const [
                DataRow(cells: [
                  DataCell(Text('التقييم', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataCell(Text('4.8 ⭐')),
                  DataCell(Text('4.6 ⭐')),
                ]),
                DataRow(cells: [
                  DataCell(Text('المصاريف', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataCell(Text('25,000 ر.س')),
                  DataCell(Text('5,000 ر.س')),
                ]),
                DataRow(cells: [
                  DataCell(Text('المنهج', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataCell(Text('IGCSE')),
                  DataCell(Text('ناشونال')),
                ]),
                DataRow(cells: [
                  DataCell(Text('باص', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataCell(Icon(Icons.check_circle, color: Colors.green)),
                  DataCell(Icon(Icons.cancel, color: Colors.red)),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
