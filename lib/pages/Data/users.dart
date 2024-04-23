import '../../models/user.dart';

List<User> getUsers() {
  return [
    User(
      id: 1,
      name: 'John Doe',
      email: 'john@example.com',
      password: 'xc',
    ),
    User(
      id: 2,
      name: 'Alice Smith',
      email: 'alice@example.com',
      password: 'xx',
    ),
    // Add more users here if needed
  ];
}