import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_aws_s3_client/flutter_aws_s3_client.dart';
import 'package:mime/mime.dart';
import 'package:recipe_app/View/all_libs.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FileService {
  String bucketName = 'User_Profile_Pic';
  String dir;
  String id;
  FileService(this.dir,this.id);

  Future<String?> uploadFile(File imageFile) async {
    final supabase = Supabase.instance.client;

// Check if the session is valid.
    final session = supabase.auth.currentSession;
    final bool? isSessionExpired = session?.isExpired;

    if (!isSessionExpired!) {
      try {
        final bytes = await imageFile.readAsBytes();
        final uuiidd = id;
        final fileExt = imageFile.path.split('.').last;
        final fileName = '${DateTime.now().toString()}.$fileExt';
        final mimeType = 'image/$fileExt'; // lookupMimeType(imageFile.path);
        // var  o = await s3client.getObject(bucketName);
        StorageFileApi storageFileApi = supabase.storage.from(bucketName);
        String uploadPath = 'public/$dir/$uuiidd/$fileName';
        storageFileApi.uploadBinary(
          uploadPath,
          bytes,
          fileOptions: FileOptions(contentType: mimeType),
        );
        
        String publicUrl = storageFileApi.getPublicUrl(uploadPath);
        return publicUrl;
      } on StorageException catch (se) {
        
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
      Uint8List res =
          await supabase.storage.from(bucketName).download(imagePath);
      File image = File.fromRawPath(res);
      return image;
    } catch (e) {
      rethrow;
    }
  }
}


/**
 * 
await dotenv.load(); 

const region = "ap-south-1";
  final AwsS3Client s3client = AwsS3Client(
      region: region,
      host: "s3.$region.ydwggqstgekucdzxbktc.storage.supabase.co",
      bucketId: bucketName,
      accessKey: session!.accessToken,
      secretKey: dotenv.env['SUPABASE_SECRET_KEY'] ?? '');

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