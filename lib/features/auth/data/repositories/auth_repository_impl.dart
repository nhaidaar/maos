import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _authRemoteDataSource;
  const AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<Either<Exception, UserModel>> checkSession() async {
    return await _authRemoteDataSource.checkSession();
  }

  @override
  Future<Either<Exception, UserModel>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    return await _authRemoteDataSource.register(name: name, email: email, password: password);
  }

  @override
  Future<Either<Exception, UserModel>> login({
    required String email,
    required String password,
  }) async {
    return await _authRemoteDataSource.login(email: email, password: password);
  }

  @override
  Future<Either<Exception, void>> logout() async {
    return await _authRemoteDataSource.logout();
  }

  @override
  Future<Either<Exception, void>> resetPassword({required String email}) async {
    return await _authRemoteDataSource.resetPassword(email: email);
  }

  @override
  Future<Either<Exception, void>> resetEmail({required String email}) async {
    return await _authRemoteDataSource.resetEmail(email: email);
  }

  @override
  Future<Either<Exception, UserModel>> editProfile({
    required String uid,
    String? name,
    XFile? image,
  }) async {
    return await _authRemoteDataSource.editProfile(uid: uid, name: name, image: image);
  }
}
