import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nakobase/core/service_locator.dart';
import 'package:nakobase/presentations/components/snackbar.dart';
import 'package:nakobase/translations/locale_keys.g.dart';
import 'package:nakobase/utils/commons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/models/profile.dart';

class Avatar extends StatefulWidget {
  const Avatar({
  super.key,
  required this.imageUrl,
  required this.onUpload,
  });

  final String? imageUrl;
  final void Function(String) onUpload;

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  bool _isLoading = false;
  late SupabaseClient supabase;

  @override
  void initState() {
    init();
    super.initState();
  }

  init(){
    supabase = supabaseService.init();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // if (widget.imageUrl == null || widget.imageUrl!.isEmpty)
        //   Container(
        //     width: 150,
        //     height: 150,
        //     color: Colors.grey,
        //     child: const Center(
        //       child: Text('No Image'),
        //     ),
        //   )
        // else
        //   Image.network(
        //     widget.imageUrl!,
        //     width: 150,
        //     height: 150,
        //     fit: BoxFit.cover,
        //   ),
        commonCachedNetworkImage(widget.imageUrl, radius: 8, height: 100, width: 100, fit: BoxFit.cover),
        const SizedBox(height: 20,),
        ElevatedButton(
          onPressed: _isLoading ? null : _upload,
          child: Text(LocaleKeys.update_image.tr()),
        ),
      ],
    );
  }

  Future<void> _upload() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      // maxWidth: 300,
      // maxHeight: 300,
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

      Profile? map = await profileRepository.getUserProfile();
      if(map?.avatarUrl != null){
        final Uri uri = Uri.parse(map!.avatarUrl!);
        final List<String> pathSegments = uri.pathSegments;
        final String filename = pathSegments.last;

        print('got the $filename');
        await supabase.storage.from('avatars').remove([
          '${map.id}/${filename}'
        ]);
      }

      await supabase.storage.from('avatars/${map!.id}/').uploadBinary(
        '$filePath',
        bytes,
        fileOptions: FileOptions(contentType: imageFile.mimeType),
      );
      final imageUrlResponse = await supabase.storage
          .from('avatars/${map.id}/')
          .createSignedUrl(filePath, 60 * 60 * 24 * 365 * 10);
      widget.onUpload(imageUrlResponse);
    } on StorageException catch (error) {
      if (mounted) {
        context.showErrorSnackBar(message: error.message);
      }
    } catch (error) {
      if (mounted) {
        context.showErrorSnackBar(message: 'Unexpected error occurred');
      }
    }

    setState(() => _isLoading = false);
  }
}