import 'package:bloc/bloc.dart';
import 'package:elbozor_task/cubits/state.dart';
import 'package:elbozor_task/data/models/data_model.dart';
import 'package:elbozor_task/data/repos/my_repo.dart';
import 'package:equatable/equatable.dart';

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit({required MyRepo myRepo}) : _myRepo = myRepo,
        super(const DataState(listData: []));

  final MyRepo _myRepo;

  int _currentPage = 0;

  Future<void> fetchData() async {
    if (state.state == Status.LOADING) return;

    try {
      if (_currentPage == 0) emit(state.copyWith(state: Status.LOADING));
      final myData = await _myRepo.fetchData(page: _currentPage);
      if (myData.isEmpty) {
        emit(state.copyWith(state: Status.SUCCESS, hasMoreData: false));
      } else {
        emit(state.copyWith(
          state: Status.SUCCESS,
          listData: List.of(state.listData)..addAll(myData),
          hasMoreData: true,
        ));
        _currentPage++;
      }
    } catch (e) {
      emit(state.copyWith(state: Status.ERROR, errorText: e.toString()));
    }
  }

  void refreshData() {
    _currentPage = 0;
    emit(const DataState(listData: []));
    fetchData();
  }
}
