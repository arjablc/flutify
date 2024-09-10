import 'dart:convert';

import 'package:dio/dio.dart' show Dio, DioException, Options;
import 'package:dartz/dartz.dart' show Either, Right, Left;
import 'package:flutify/core/data/remote/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/user_model.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/data/remote/exception_helper.dart';
import '../../../core/failure/failure.dart';

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(AuthRemoteRepositoryRef ref) {
  final dio = ref.read(httpServceProvider).getDio();
  return AuthRemoteRepository(client: dio);
}

class AuthRemoteRepository {
  final Dio client;

  AuthRemoteRepository({required this.client});

  Future<Either<AppFailure, UserModel>> loginUser(
      {required String email, required String password}) async {
    try {
      final payload = jsonEncode({'email': email, 'password': password});
      final response = await client.post(
          AppConstants.baseUrlDev + AppConstants.loginRoute,
          data: payload);
      final user = UserModel.fromJson(response.data['user']);
      user.accessToken = response.data['accessToken'];

      return Right(user);
    } on DioException catch (error) {
      final failure = ExceptionHelper.dioExceptionToFailure(error);
      return Left(failure);
    } catch (error) {
      return const Left(AppFailure(message: 'An Unknown error occured'));
    }
  }

  Future<Either<AppFailure, UserModel>> signupUser(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final payload =
          jsonEncode({'email': email, 'password': password, 'name': name});
      final response = await client.post(
          AppConstants.baseUrlDev + AppConstants.signupRoute,
          data: payload);
      debugPrint(response.toString());
      return Right(UserModel.fromJson(response.data));
    } on DioException catch (error) {
      final failure = ExceptionHelper.dioExceptionToFailure(error);
      return Left(failure);
    } catch (error) {
      return const Left(AppFailure(message: 'An Unknown error occured'));
    }
  }

  Future<Either<AppFailure, UserModel>> getMe(String accessToken) async {
    try {
      final response = await client.get(
        AppConstants.baseUrlDev + AppConstants.aboutMeRoute,
        options: Options(
          headers: {'authorization': 'Bearer $accessToken'},
        ),
      );
      debugPrint(response.toString());

      return Right(UserModel.fromJson(response.data));
    } on DioException catch (error) {
      final failure = ExceptionHelper.dioExceptionToFailure(error);
      debugPrint(failure.toString());
      return Left(failure);
    } catch (error) {
      debugPrint(error.toString());
      return const Left(AppFailure(message: 'An Unknown error occured'));
    }
  }
}
