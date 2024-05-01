

import '../../models/chef.dart';

List<Chef> Chefs = [
  Chef(
    id: 1,
    firstName: 'John',
    lastName: 'Doe',
    email: 'john@example.com',
    password: 'password',
    location: 'New York',
    phoneNumber: '+1234567890',
    bio: 'Experienced chef with a passion for cooking.',
    specialities: ['Italian', 'French'],
    yearsOfExperience: 10,
    imageUrl: '',
  ),
  Chef(
    id: 2,
    firstName: 'Alice',
    lastName: 'Smith',
    email: 'alice@example.com',
    password: 'password',
    location: 'Los Angeles',
    phoneNumber: '+1987654321',
    bio: 'Chef specializing in vegan and vegetarian cuisine.',
    specialities: ['Vegan', 'Vegetarian'],
    yearsOfExperience: 8, imageUrl: '',
  ),
  Chef(
    id: 3,
    firstName: 'Bob',
    lastName: 'Johnson',
    email: 'bob@example.com',
    password: 'password',
    location: 'Chicago',
    phoneNumber: '+1122334455',
    bio: 'Award-winning chef known for his seafood dishes.',
    specialities: ['Seafood'],
    yearsOfExperience: 15, imageUrl: '',
  ),
  Chef(
    id: 4,
    firstName: 'Emma',
    lastName: 'Brown',
    email: 'emma@example.com',
    password: 'password',
    location: "",
    phoneNumber: "",
    bio: "",
    specialities: [],
    yearsOfExperience: 5, imageUrl: '',
  ),
  Chef(
    id: 5,
    firstName: 'Michael',
    lastName: 'Lee',
    email: 'michael@example.com',
    password: 'password',
    location: "",
    phoneNumber: "",
    bio: "",
    specialities: [],
    yearsOfExperience: 3, imageUrl: '',
  ),
];

List<Chef> getAllChefs(){
  return Chefs;
}