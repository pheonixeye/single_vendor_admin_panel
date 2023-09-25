import 'package:flutter/material.dart';

class MainInfoDialog extends StatelessWidget {
  const MainInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      insetAnimationDuration: const Duration(milliseconds: 300),
      contentPadding: const EdgeInsets.all(12),
      title: ListTile(
        leading: const CircleAvatar(
          child: Icon(
            Icons.info,
            color: Colors.white,
          ),
        ),
        title: const Text('Info'),
        trailing: IconButton.filled(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
      ),
      content: const Column(
        children: [
          SelectableText(
            """
              Nullam porttitor risus id pellentesque accumsan. Quisque non mi turpis. 
              Sed euismod erat eget sagittis volutpat. Sed fringilla non sem eget vestibulum.
              In a porttitor leo. Nullam luctus at leo vel dignissim. Morbi eget tellus odio.
              Etiam efficitur molestie augue, nec tincidunt elit rhoncus eget.
              Integer sed lobortis velit. Nunc gravida justo vel enim rutrum, eget volutpat lacus aliquet.
              Pellentesque orci odio, ultrices sed pulvinar consectetur, faucibus a risus. 
              Mauris vitae ultricies diam. Aenean convallis sollicitudin diam a sodales. 
              Proin laoreet aliquet eros, ac pulvinar diam pretium tempus. Pellentesque finibus ipsum 
              lobortis est pulvinar, eget bibendum diam condimentum. Interdum et malesuada fames ac 
              ante ipsum primis in faucibus.Praesent tristique congue porttitor. Suspendisse potenti. 
              Duis posuere mi quis justo vehicula, in cursus urna elementum. Suspendisse quis est id mi
              lobortis tincidunt at quis nisi. Interdum et malesuada fames ac ante ipsum primis in faucibus.
              Integer aliquam sapien viverra vulputate eleifend. Vestibulum faucibus scelerisque nibh quis 
              suscipit. Fusce malesuada arcu consectetur, sodales nunc eget, rhoncus nunc.Etiam sit amet 
              dictum est, eu rhoncus augue. Vivamus nec dignissim ligula, ut maximus orci.
              Quisque fermentum dui id dui pulvinar tincidunt. In et metus commodo, eleifend 
              odio a, consequat est. Aenean feugiat lectus at nisi suscipit, eu semper erat 
              venenatis. Morbi id velit ut ante aliquet ultrices. Cras non diam 
              et nunc cursus tempor. Nulla in ligula eget risus viverra rutrum. 
              Ut dictum nec arcu ut faucibus.""",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

Future<dynamic> showMainDialog(BuildContext context) async {
  if (context.mounted) {
    return await showAdaptiveDialog(
        context: context,
        builder: (context) {
          return const MainInfoDialog();
        });
  }
}
