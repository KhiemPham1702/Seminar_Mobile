import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingCubit extends Cubit<int> {
  LoadingCubit() : super(0);

  update(int value) {
    emit(value);
  }
}
