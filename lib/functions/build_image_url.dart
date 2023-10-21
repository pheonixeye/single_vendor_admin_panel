import 'package:single_vendor_admin_panel/constants/creds.dart';

String buildImageUrl(String imageId) {
  return 'https://cloud.appwrite.io/v1/storage/buckets/${CREDS.PRODUCT_IMAGES_BUCKET_ID}/files/$imageId/view?project=${CREDS.PROJECT_ID}';
}
