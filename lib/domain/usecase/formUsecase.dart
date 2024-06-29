import 'package:dio/dio.dart';
import 'package:gmap/core/usecase.dart';
import 'package:gmap/data/remote/modals/response/formRes.dart';
import 'package:gmap/data/repository/app_repository.dart';

class FormUsecase extends UseCase<FormResponse, FormData> {
  final AppRepository appRepository;

  FormUsecase(this.appRepository);

  @override
  Future<FormResponse> call(FormData params) {
    return appRepository.form(params);
  }
}
