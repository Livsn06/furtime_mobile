import '../utils/_constant.dart';

String parseNetworkImage(String url) {
  return "${API_BASE_URL.value}/storage/$url";
}
