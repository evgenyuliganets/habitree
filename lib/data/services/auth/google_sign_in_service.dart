import 'package:google_sign_in/google_sign_in.dart';
import 'package:habitree/data/models/auth/google_token_dto.dart';
import 'package:habitree/domain/entities/auth/google_token.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GoogleSignInService {
  GoogleSignInService();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );

  Future<GoogleToken> signIn() async {
    final account = await _googleSignIn.signIn();
    if (account == null) {
      throw Exception('Google sign-in cancelled');
    }

    final auth = await account.authentication;

    final accessToken = auth.accessToken;
    final idToken = auth.idToken;

    if (accessToken == null || idToken == null) {
      throw Exception('Failed to retrieve Google tokens');
    }

    final dto = GoogleTokenDto(
      accessToken: accessToken,
      idToken: idToken,
    );

    return dto.toDomain();
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
