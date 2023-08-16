import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottomnavbar_state.dart';

class BottomnavbarCubit extends Cubit<int> {
  BottomnavbarCubit() : super(0);
  void onchanged(int index) {
    emit(index);
  }
}
