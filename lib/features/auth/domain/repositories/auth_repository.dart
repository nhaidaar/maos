import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Exception, UserModel>> checkSession();

  Future<Either<Exception, UserModel>> register({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Exception, UserModel>> login({
    required String email,
    required String password,
  });

  Future<Either<Exception, void>> logout();

  Future<Either<Exception, void>> resetPassword({required String email});

  Future<Either<Exception, void>> resetEmail({required String email});

  Future<Either<Exception, UserModel>> editProfile({
    required String uid,
    String? name,
    XFile? image,
  });
}
