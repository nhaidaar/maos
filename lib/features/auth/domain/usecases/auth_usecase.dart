import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/user_model.dart';
import '../repositories/auth_repository.dart';

class AuthUsecase {
  final AuthRepository _authRepository;
  const AuthUsecase(this._authRepository);

  Future<Either<Exception, UserModel>> checkSession() {
    return _authRepository.checkSession();
  }

  Future<Either<Exception, UserModel>> register({
    required String name,
    required String email,
    required String password,
  }) {
    return _authRepository.register(name: name, email: email, password: password);
  }

  Future<Either<Exception, UserModel>> login({
    required String email,
    required String password,
  }) {
    return _authRepository.login(email: email, password: password);
  }

  Future<Either<Exception, void>> logout() {
    return _authRepository.logout();
  }

  Future<Either<Exception, void>> resetPassword({required String email}) {
    return _authRepository.resetPassword(email: email);
  }

  Future<Either<Exception, void>> resetEmail({required String email}) {
    return _authRepository.resetEmail(email: email);
  }

  Future<Either<Exception, UserModel>> editProfile({
    required String uid,
    String? name,
    XFile? image,
  }) {
    return _authRepository.editProfile(uid: uid, name: name, image: image);
  }
}
