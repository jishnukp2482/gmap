import 'package:dio/dio.dart';
import 'package:gmap/core/api_provider.dart';
import 'package:gmap/data/remote/modals/response/GMap_ResponseModal.dart';
import 'package:gmap/data/remote/modals/response/formRes.dart';
import 'package:gmap/data/remote/remote_routes/app_remote_routes.dart';
import 'package:gmap/presentation/routes/utlities.dart';

import '../modals/request/Gmap_RequestModal.dart';

abstract class AppDataSource {
  Future<GmapResponseModel> getRoute(GmapRequestModal requestModal);
  Future<FormResponse> form(FormData formdata);
}

class AppDataSourceImpl extends AppDataSource {
  final ApiProvider apiProvider;

  AppDataSourceImpl(this.apiProvider);
  @override
  Future<GmapResponseModel> getRoute(GmapRequestModal requestModal) async {
    final url =
        "${AppRemoteRoutes.direction}origin=${requestModal.from}&destination=${requestModal.to}&key=${LocalStorageKeyWords.apikey}";
    print("url==$url");
    return GmapResponseModel.fromJson(await apiProvider.get(url));
  }

  @override
  Future<FormResponse> form( formdata) async {
    return FormResponse.fromJson(
        await apiProvider.request(AppRemoteRoutes.company, formdata));
  }
}
