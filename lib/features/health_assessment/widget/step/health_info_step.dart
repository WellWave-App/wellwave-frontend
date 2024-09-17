import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/common/widget/custom_text_form_field.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/health_assessment_bloc.dart';
import 'package:wellwave_frontend/features/health_assessment/presentation/bloc/health_assessment_event.dart';

class HealthInfoStep extends StatelessWidget {
  const HealthInfoStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AssessmentBloc>().state;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "ข้อมูลสุขภาพ",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "หากทราบข้อมูล โปรดระบุเพื่อผลลัพธ์ที่แม่นยำยิ่งขึ้น",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: 48,
          ),
          CustomTextFormField(
            labelText: 'ความดันโลหิตขณะบีบตัว',
            hintText: 'ความดันโลหิตขณะบีบตัว',
            suffixText: 'มิลลิเมตรปรอท',
            keyboardType: TextInputType.number,
            initialValue: state.formData['sbp'] ?? '',
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            onChanged: (value) =>
                context.read<AssessmentBloc>().add(UpdateField('sbp', value)),
          ),
          const SizedBox(
            height: 24,
          ),
          CustomTextFormField(
            labelText: 'ความดันโลหิตขณะคลายตัว',
            hintText: 'ความดันโลหิตขณะคลายตัว',
            suffixText: 'มิลลิเมตรปรอท',
            keyboardType: TextInputType.number,
            initialValue: state.formData['dbp'] ?? '',
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            onChanged: (value) =>
                context.read<AssessmentBloc>().add(UpdateField('dbp', value)),
          ),
          const SizedBox(
            height: 24,
          ),
          CustomTextFormField(
            labelText: 'รอบเอว',
            hintText: 'รอบเอว',
            suffixText: 'ซม.',
            keyboardType: TextInputType.number,
            initialValue: state.formData['waist'] ?? '',
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            onChanged: (value) =>
                context.read<AssessmentBloc>().add(UpdateField('waist', value)),
          ),
          const SizedBox(
            height: 24,
          ),
          CustomTextFormField(
            labelText: 'น้ำตาลในเลือด',
            hintText: 'น้ำตาลในเลือด',
            suffixText: 'มก./ดล.',
            keyboardType: TextInputType.number,
            initialValue: state.formData['glucose'] ?? '',
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            onChanged: (value) => context
                .read<AssessmentBloc>()
                .add(UpdateField('glucose', value)),
          ),
          const SizedBox(
            height: 24,
          ),
          CustomTextFormField(
            labelText: 'ไขมันในเลือด Cholesterol',
            hintText: 'ไขมันในเลือด Cholesterol',
            suffixText: 'มก./ดล.',
            keyboardType: TextInputType.number,
            initialValue: state.formData['cholesterol'] ?? '',
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            onChanged: (value) => context
                .read<AssessmentBloc>()
                .add(UpdateField('cholesterol', value)),
          ),
          const SizedBox(
            height: 24,
          ),
          CustomTextFormField(
            labelText: 'ไขมันในเลือด Triglyceride',
            hintText: 'ไขมันในเลือด Triglyceride',
            suffixText: 'มก./ดล.',
            keyboardType: TextInputType.number,
            initialValue: state.formData['triglyceride'] ?? '',
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            onChanged: (value) => context
                .read<AssessmentBloc>()
                .add(UpdateField('triglyceride', value)),
          ),
        ],
      ),
    );
  }
}
