import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/components/main_snackbar.dart';
import 'package:single_vendor_admin_panel/functions/build_image_url.dart';
import 'package:single_vendor_admin_panel/functions/shell_function.dart';
import 'package:single_vendor_admin_panel/models/product_model.dart';
import 'package:single_vendor_admin_panel/providers/products/px_product.dart';
import 'package:single_vendor_admin_panel/providers/products/px_product_images.dart';
import 'package:single_vendor_admin_panel/theme/theme.dart';

class ImagesEditComponent extends StatefulWidget {
  const ImagesEditComponent({super.key});

  @override
  State<ImagesEditComponent> createState() => _ImagesEditComponentState();
}

class _ImagesEditComponentState extends State<ImagesEditComponent>
    with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    context.read<PxProductImages>().selectImages(
          ProductImages(
            productId: context.read<PxProduct>().product.productId,
            images: const [],
          ),
        );
    await context.read<PxProductImages>().getProductImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(
                  title: const Text('Edit Images'),
                  tileColor: Colors.green.shade200,
                  trailing: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        late String? path;
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          dialogTitle: "Pick Image File...",
                          allowedExtensions: ['webp', 'jpg', 'png', 'jpeg'],
                        );

                        if (result != null) {
                          path = result.files.single.path;
                          bool isPathValid = path != null;
                          bool isSupportedExtention = (isPathValid &&
                              (path.endsWith('.webp') ||
                                  path.endsWith('.jpg') ||
                                  path.endsWith('.png') ||
                                  path.endsWith('.jpeg')));

                          print((path, isPathValid, isSupportedExtention));
                          if (!isSupportedExtention && context.mounted) {
                            showInfoSnackbar(
                              context,
                              'Unsupported File Type, Expected Image File: { .webp, .jpg, .png, .jpeg }...',
                              Colors.red,
                            );
                            path = null;
                          }
                        } else {
                          // User canceled the picker
                          path = null;
                          return;
                        }
                        if (mounted && path != null) {
                          await shellFunction(
                            context,
                            toExecute: () {
                              context
                                  .read<PxProductImages>()
                                  .addProductImage(path!);
                            },
                          );
                        }
                      },
                      icon: const Icon(Icons.save),
                      label: const Text("Upload image"),
                    ),
                  ),
                ),
                Expanded(
                  child: Consumer<PxProductImages>(
                    builder: (context, i, c) {
                      while (i.images.images.isEmpty) {
                        return const Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("No Images Found..."),
                              ),
                            ),
                          ),
                        );
                      }
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisExtent: 300,
                        ),
                        itemCount: i.images.images.length,
                        itemBuilder: (context, index) {
                          final String imageId = i.images.images[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Image.network(
                                        buildImageUrl(imageId),
                                      ),
                                    ),
                                    GridTileBar(
                                      backgroundColor: primaryColor,
                                      leading: CircleAvatar(
                                        child: Text(index.toString()),
                                      ),
                                      title: Text(i.images.images[index]),
                                      trailing: FloatingActionButton.small(
                                        heroTag: 'img-delete-$index',
                                        onPressed: () async {
                                          await shellFunction(
                                            context,
                                            toExecute: () {
                                              i.deleteProductImage(imageId);
                                            },
                                          );
                                        },
                                        child: const Icon(Icons.delete),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
