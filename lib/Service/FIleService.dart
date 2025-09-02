import 'dart:io';
import 'dart:typed_data';
import 'package:mime/mime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FileService {
  String bucketName;
  FileService(this.bucketName);
  Future<String?> uploadFile(File imageFile) async {
      final supabase = Supabase.instance.client;
    final session = supabase.auth.currentSession;
// Check if the session is valid.
final bool? isSessionExpired = session?.isExpired;

if(!isSessionExpired!){
    try {
      final bytes = await imageFile.readAsBytes();
      final fileExt = imageFile.path.split('.').last;
      final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
      final filePath = fileName;
      final mimeType = lookupMimeType(imageFile.path);

      await supabase.storage.from(bucketName).uploadBinary(
            filePath,
            bytes,
            fileOptions: FileOptions(contentType: mimeType),
          );

      final imageUrlResponse = await supabase.storage
          .from(bucketName)
          .createSignedUrl(filePath, 60 * 60 * 24 * 365 * 10); //this url is accessible for next 10 years of the time image is uploaded

      return imageUrlResponse;
    } on StorageException {
      return null;
    } catch (error) {
      return null;
    }
    }

    return null;
  }

  Future<File> downloadFile(String imagePath) async {
    try {
      final supabase = Supabase.instance.client;
      Uint8List res=  await supabase.storage.from(bucketName).download(imagePath);
      File image = File.fromRawPath(res);
      return image;
    } catch (e) {
      rethrow;
    }
  }
}


/**
 * Future<void> _upload() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
      maxHeight: 300,
    );
    if (imageFile == null) {
      return;
    }
    setState(() => _isLoading = true);
    try {
      final bytes = await imageFile.readAsBytes();
      final fileExt = imageFile.path.split('.').last;
      final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
      final filePath = fileName;
      await supabase.storage.from('avatars').uploadBinary(
            filePath,
            bytes,
            fileOptions: FileOptions(contentType: imageFile.mimeType),
          );
      final imageUrlResponse = await supabase.storage
          .from('avatars')
          .createSignedUrl(filePath, 60 * 60 * 24 * 365 * 10);
      widget.onUpload(imageUrlResponse);
    } on StorageException catch (error) {
      if (mounted) {
        context.showSnackBar(error.message, isError: true);
      }
    } catch (error) {
      if (mounted) {
        context.showSnackBar('Unexpected error occurred', isError: true);
      }
    }
    setState(() => _isLoading = false);
  }
}
 */