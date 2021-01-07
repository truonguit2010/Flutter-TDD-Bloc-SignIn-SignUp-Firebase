

part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
  unknown
}

class AuthenticationState extends Equatable {

  final AuthenticationStatus status;
  final User user;


  ///
  /// Const constructor creates a "canonicalized" instance.
  ///
  ///That is, all constant expressions begin canonicalized, and later these "canonicalized" symbols are used to recognize equivalence of these constants.
  ///
  ///Canonicalization:
  ///
  ///A process for converting data that has more than one possible representation into a "standard" canonical representation. This can be done to compare different representations for equivalence, to count the number of distinct data structures, to improve the efficiency of various algorithms by eliminating repeated calculations, or to make it possible to impose a meaningful sorting order.
  ///
  ///This means that const expressions like const Foo(1, 1) can represent any usable form that is useful for comparison in virtual machine.
  ///
  ///The VM only needs to take into account the value type and arguments in the order in which they occur in this const expression. And, of course, they are reduced for optimization.
  ///
  const AuthenticationState._({this.status = AuthenticationStatus.unknown, this.user = User.empty});

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user) : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated() : this._(status: AuthenticationStatus.unauthenticated);

  AuthenticationState(this.status, this.user);

  @override
  List<Object> get props => [status, user];
}
