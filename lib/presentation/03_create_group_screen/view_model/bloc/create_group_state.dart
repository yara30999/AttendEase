part of 'create_group_bloc.dart';

sealed class CreateGroupState extends Equatable {
  const CreateGroupState();
  
  @override
  List<Object> get props => [];
}

final class CreateGroupInitial extends CreateGroupState {}
