import 'dart:convert';

import 'package:dio/dio.dart';
import "package:dartz/dartz.dart" show Either, Right, Left;
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/http/exception_helper.dart';
import '../../../core/failure/failure.dart';
import "../../../core/http/dio.dart";

class AuthRemoteRepository {
  final Dio client = HttpService().getDio();

  Future<Either<AppFailure, UserModel>> loginUser(
      {required String email, required String password}) async {
    try {
      final payload = jsonEncode({'email': email, 'password': password});
      final response = await client.post(
          AppConstants.baseUrlDev + AppConstants.loginRoute,
          data: payload);
      debugPrint(response.toString());
      return Right(UserModel.fromRawJson(jsonDecode(response.toString())));
    } on DioException catch (error) {
      debugPrint(error.toString());
      return Left(ExceptionHelper.dioExceptionToFailure(error));
    } catch (error) {
      debugPrint(error.toString());
      return Left(AppFailure(message: "An Unknown error occured"));
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
      return Right(UserModel.fromRawJson(jsonDecode(response.toString())));
    } on DioException catch (error) {
      debugPrint(error as String?);

      return Left(ExceptionHelper.dioExceptionToFailure(error));
    } catch (error) {
      debugPrint(error.toString());
      return Left(AppFailure(message: "An Unknown error occured"));
    }
  }
}
