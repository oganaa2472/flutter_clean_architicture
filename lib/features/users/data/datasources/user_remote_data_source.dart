
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/core/exceptions.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers();  
}
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});
  @override
  Future<List<UserModel>> getUsers() async  {
    try{
      final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
      final response = await client.get(url, headers: {
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        final List decoded = json.decode(response.body) as List;
        return decoded.map((json) => UserModel.fromJson(json)).toList();
      } else {
        throw ServerException();
      }
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      throw ServerException();
    }
     
  }
}