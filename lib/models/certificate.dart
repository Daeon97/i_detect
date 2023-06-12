// ignore_for_file: public_member_api_docs

class Certificate {
  const Certificate({
    required this.rootCertificateAuthorityAssetPath,
    required this.privateKeyAssetPath,
    required this.deviceCertificateAssetPath,
  });

  final String rootCertificateAuthorityAssetPath;
  final String privateKeyAssetPath;
  final String deviceCertificateAssetPath;
}