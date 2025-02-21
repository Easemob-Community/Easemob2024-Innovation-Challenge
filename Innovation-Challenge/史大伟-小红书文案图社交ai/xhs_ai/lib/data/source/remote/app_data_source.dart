

import 'package:third_party_base/third_party_base.dart';
import '../../model/login_model.dart';
import '../../../data/model/params/ai_param.dart';
import '../../../data/model/responses/ai_response.dart';
import 'package:third_party_base/tools/net/dio_utli.dart';
import '../../../app/config.dart';
import '../../model/params/ai2_param.dart';
import '../../model/responses/ai2_response.dart';
import '../../services/api_service.dart';

abstract class IAppDataSource {

  Future<AiResponse> chatcompletionPro(AiParma payload);

  Future<Ai2Response> chatcompletionV2(Ai2Parma payload);

}

class AppDataSource extends BaseRemoteDataSource
    implements IAppDataSource {
  var rest = RestClient(DioUtil.getDio(VmAppConfig.baseDio));

  @override
  Future<AiResponse> chatcompletionPro(AiParma payload) {
    return rest.chatcompletionPro(payload);
  }

  @override
  Future<Ai2Response> chatcompletionV2(Ai2Parma payload) {
    return rest.chatcompletionV2(payload);

  }


}
