import 'package:dio/src/form_data.dart';
import 'package:gmap/data/remote/data_source/appdata_source.dart';
import 'package:gmap/data/remote/modals/request/Gmap_RequestModal.dart';
import 'package:gmap/data/remote/modals/response/GMap_ResponseModal.dart';
import 'package:gmap/data/remote/modals/response/formRes.dart';
import 'package:gmap/data/repository/app_repository.dart';

class AppRepositoryImpl extends AppRepository {
  final AppDataSource appDataSource;

  AppRepositoryImpl(this.appDataSource);

  @override
  Future<GmapResponseModel> getRoute(GmapRequestModal requestModal) {
    return appDataSource.getRoute(requestModal);
  }

  @override
  Future<FormResponse> form(FormData formdata) {
    return appDataSource.form(formdata);
  }
}
