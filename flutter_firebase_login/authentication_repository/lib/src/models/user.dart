


import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';


/// The User class is extending equatable in order to override equality comparisons
/// so that we can compare different instances of User by value.
class User extends Equatable {
  final String email;
  final String id;
  final String name;
  final String photo;

  const User({
    @required this.email,
    @required this.id,
    @required this.name,
    @required this.photo
  }) :  assert(email != null),
        assert(id != null);

  /// Tip: It's useful to define a static empty User so that we don't have to
  /// handle null Users and can always work with a concrete User object.
  static const empty = User(email: '', id: '', name: null, photo: null);

  @override
  List<Object> get props => [email, id, name, photo];
}