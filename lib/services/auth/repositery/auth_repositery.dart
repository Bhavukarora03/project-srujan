import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:srujan/services/auth/models/user_modal.dart' as models;
import 'package:srujan/services/auth/repositery/local_storage_repositery.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    googleSignIn: GoogleSignIn(),
    client: http.Client(),
    localStorageRepository: LocalStorageRepository()));

final userProvider = StateProvider<models.User?>((ref) {
  return null;
});

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final http.Client _client;
  final LocalStorageRepository _localStorageRepository;

  AuthRepository(
      {required GoogleSignIn googleSignIn,
      required http.Client client,
      required LocalStorageRepository localStorageRepository})
      : _googleSignIn = googleSignIn,
        _localStorageRepository = localStorageRepository,
        _client = client;

  Future<models.ErrorModel> signInWithGoogle(BuildContext context) async {
    models.ErrorModel error =
        models.ErrorModel(error: "Unexpected error", data: "data");
    final baseUrl = dotenv.env['BASE_URL'];
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final userData = models.User(
          name: googleUser.displayName!,
          email: googleUser.email,
          profilePicture: googleUser.photoUrl!,
          token: "",
          uid: "",
        );
        final res = await _client.post(Uri.parse('$baseUrl/v1/auth/signup'),
            body: jsonEncode(userData.toJson()),
            headers: {
              'Content-Type': 'application/json',
            });
        switch (res.statusCode) {
          case 200:
            final newUser = userData.copywith(
              uid: jsonDecode(res.body)['user']['_id'],
              token: jsonDecode(res.body)['token'],
            );
            error = models.ErrorModel(error: null, data: newUser);
            _localStorageRepository.setToken(newUser);

            break;
          case 400:
            print('User Already Exists');
            break;
          default:
            print('Something Went Wrong');
        }
      }
    } catch (e) {
      error = models.ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }

  Future<models.ErrorModel> getToken() async {
    final baseUrl = dotenv.env['BASE_URL'];
    try {
      String? token = await _localStorageRepository.getToken();
      if (token != null) {
        final res = await _client.get(Uri.parse('$baseUrl/'), headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token,
        });

        switch (res.statusCode) {
          case 200:

          case 400:
            print('User Already Exists');
            break;
          default:
            print('Something Went Wrong');
        }
      }
    } catch (e) {
      print(e);
    }
    return models.ErrorModel(error: "Unexpected error", data: "data");
  }
}
