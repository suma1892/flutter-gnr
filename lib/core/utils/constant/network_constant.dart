import 'package:flutter_dotenv/flutter_dotenv.dart';

final apiUrl = dotenv.env['URL_API'];
final env = dotenv.env['ENV'];
final appUrl = dotenv.env['APP_URL'];
final imageUrl = dotenv.env['URL_IMAGE'];
final midtransClientKey = dotenv.env['MIDTRANS_CLIENT_KEY'];
final apiMidtrans = dotenv.env['API_MIDTRANS'];
final appId = dotenv.env['APP_ID'];