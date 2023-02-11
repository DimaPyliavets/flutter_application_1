import 'dart:convert';
import 'package:http/http.dart' as http;

String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiI3MzE2MGExZS01NDQ2LTQ4NTUtODBhYy0xNTVmYzE3MjUyNmUiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTY3MDc4OTQyMSwiZXhwIjoxNjg2MzQxNDIxfQ.cDo2M1DNwaI1ktOwdiCudDDWwFBPKlLFaFs1CRoBH7c";

Future<String> createMeeting() async {
  final http.Response httpResponse = await http.post(
    Uri.parse("https://api.videosdk.live/v2/rooms"),
    headers: {'Authorization': token},
  );

  return json.decode(httpResponse.body)['roomId'];
}
