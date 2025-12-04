import 'package:flutter/material.dart';
// باقي الـ imports غير ضرورية لهذا المثال
import 'package:wejha_app/models/institute_model.dart'; // افترض أن هذا هو المسار الصحيح

// هذا مثال لكيفية استخدام الكود داخل Widget
class ExampleWidget extends StatefulWidget {
  final Institute institute;

  const ExampleWidget({super.key, required this.institute});

  @override
  State<ExampleWidget> createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  @override
  Widget build(BuildContext context) {
    // الطريقة الصحيحة لكتابة المنطق
    String programsTabTitle;
    if (widget.institute.type == "جامعات") {
      programsTabTitle = "الكليات";
    } else if (widget.institute.type == "مدارس") {
      programsTabTitle = "المراحل";
    } else if (widget.institute.type == "مراكز تدريب") {
      programsTabTitle = "الدورات";
    } else {
      programsTabTitle = "البرامج";
    }

    // يمكنك الآن استخدام المتغير programsTabTitle هنا
    return Text(programsTabTitle);
  }
}
