class AppwriteConstants{
  static const String databaseId = '64a412b1dc325513ceab';
  static const String projectId = '649689c32fe188b22e2b';
  static const String endPoint = 'http://192.168.100.52/v1';
  static const String usersCollection = '64a418f14cefee182bf0';
  static const String tweetsCollection = '64a569863ac173138571';
  static const String notificationsCollection = '64a69155b0aa33f09bc0';
 
  static const String imagesBucket = '64a5f2a5e8f0e1c72d95';
  static String imageUrl(String imageId) => 
    '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}