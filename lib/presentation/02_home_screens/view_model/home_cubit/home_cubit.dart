import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/group_entity.dart';
import '../../../../domain/usecase/groups_stream_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GroupsStreamUsecase _groupsStreamUsecase;
  String _searchQuery = '';

  HomeCubit(this._groupsStreamUsecase) : super(HomeInitial()) {
    _loadGroups();
  }

  void setSearchQuery(String query) {
    _searchQuery = query.toLowerCase();
    _loadGroups();
  }

  void _loadGroups() {
    emit(HomeLoading());
    _groupsStreamUsecase.execute().listen(
      (groups) {
        final filteredGroups =
            groups.where((group) {
              return (_searchQuery.isEmpty ||
                  group.name.toLowerCase().contains(_searchQuery));
            }).toList();
        emit(HomeSuccess(filteredGroups));
      },
      onError: (error) {
        emit(HomeError(error.toString()));
      },
    );
  }
}
