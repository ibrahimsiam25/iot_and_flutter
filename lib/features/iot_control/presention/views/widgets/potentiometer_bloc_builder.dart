import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../manger/potentiometer/potentiometer_cubit.dart';
import '../../../../../core/widgets/custom_half_circle_progress.dart';


class PotentiometerBlocBuilder extends StatelessWidget {
  const PotentiometerBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PotentiometerCubit, PotentiometerState>(
      builder: (context, state) {
        if (state is PotentiometerSuccess) {
          return CustomHalfCircleProgress(percentage: state.potentiometer);
        }
        else {
          return Container();
        }
      },  
    );
  }
}