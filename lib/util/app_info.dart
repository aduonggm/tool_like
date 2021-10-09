import 'package:tool_tang_tuong_tac/util/util.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> sendFeedbackApp({required String appName, String? body}) async {
  final Uri params = Uri(
    scheme: 'mailto',
    path: "support@yobimi.com",
    query: 'subject=$appName Feedback&body=${body ?? ''}', //add subject and body here
  );

  bool success = await openLink(params.toString());
  if (!success) toast('Cannot send email');
  return success;
}

Future<void> shareAppInfo({required String appId, required String appName}) async {
  // await Share.share("I'm in love with app $appName, you can install here https://play.google.com/store/apps/details?id=$appId");
}

Future<bool> openLink(String text) async {
  if (await canLaunch(text)) {
    launch(text);
    return true;
  }
  return false;
}
