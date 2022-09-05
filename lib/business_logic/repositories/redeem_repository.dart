import 'package:greeny_flutter_app/connection.dart';

class RedeemRepository {
  Future<String> redeemCode(String code) async {
    var url = "${conn.getUrl()}/api/rewardcodes/redeem/$code";

    var message = await httpClient.get(Uri.parse(url),
        headers: await conn.getAuthorizationHeaders());

    return message.body;
  }
}
