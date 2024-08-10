import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'iot_control_state.dart';

class IotControlCubit extends Cubit<IotControlState> {
  IotControlCubit() : super(IotControlInitial());
}
