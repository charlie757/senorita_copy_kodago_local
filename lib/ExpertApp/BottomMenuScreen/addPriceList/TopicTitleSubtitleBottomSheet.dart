import 'package:flutter/material.dart';

class TopicTitleSubtitleBottomSheet extends StatelessWidget {
  final String titleSubtitle;
  final String actionType;
  final String titleSubtitleType;
  final Function(String) onAddUpdateTopicTitleSubtitle;
  final VoidCallback onDeleteTopicTitleSubtitle;

  const TopicTitleSubtitleBottomSheet({super.key, 
    required this.titleSubtitle,
    required this.actionType,
    required this.titleSubtitleType,
    required this.onAddUpdateTopicTitleSubtitle,
    required this.onDeleteTopicTitleSubtitle,
  });

  void _checkValidation(BuildContext context, String titleSubtitleTemp) {
    if (titleSubtitleTemp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please type $titleSubtitleType')),
      );
    } else {
      Navigator.of(context).pop();
      onAddUpdateTopicTitleSubtitle(titleSubtitleTemp);
    }
  }

  @override
  Widget build(BuildContext context) {
    final headerText = actionType == 'update' ? 'Update' : 'Add';
    final hintText = titleSubtitleType == 'subtitle' ? 'Type subtitle' : 'Type title';

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$headerText $titleSubtitleType', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(hintText: hintText),
              controller: TextEditingController(text: titleSubtitle),
              onSubmitted: (value) => _checkValidation(context, value),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (actionType == 'update')
                  ElevatedButton(
                    onPressed: onDeleteTopicTitleSubtitle,
                    child: const Text('Delete'),
                  ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _checkValidation(context, titleSubtitle),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

