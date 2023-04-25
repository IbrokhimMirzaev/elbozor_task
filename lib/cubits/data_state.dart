part of 'data_cubit.dart';

class DataState extends Equatable {
  final List<DataModel> listData;
  final Status state;
  final String? errorText;
  final bool hasMoreData;

  const DataState({
    required this.listData,
    this.state = Status.PURE,
    this.errorText,
    this.hasMoreData = true,
  });

  DataState copyWith({
    List<DataModel>? listData,
    Status? state,
    String? errorText,
    bool? hasMoreData,
  }) {
    return DataState(
      listData: listData ?? this.listData,
      state: state ?? this.state,
      errorText: errorText,
      hasMoreData: hasMoreData ?? this.hasMoreData,
    );
  }

  @override
  List<Object?> get props => [listData, state, errorText, hasMoreData];
}
