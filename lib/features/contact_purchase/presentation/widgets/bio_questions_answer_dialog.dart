import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class BioQuestionsAnswerDialog extends StatefulWidget {
  final List<String> questions;
  final Function(String answers) onSubmit;

  const BioQuestionsAnswerDialog({
    super.key,
    required this.questions,
    required this.onSubmit,
  });

  @override
  State<BioQuestionsAnswerDialog> createState() => _BioQuestionsAnswerDialogState();
}

class _BioQuestionsAnswerDialogState extends State<BioQuestionsAnswerDialog> {
  final List<TextEditingController> _controllers = [];
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    for (var _ in widget.questions) {
      _controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String _buildAnswersString() {
    // Format: ===question_0=={q}===answer_0=={a}===question_1=={q}===answer_1=={a}...
    final buffer = StringBuffer();
    for (int i = 0; i < widget.questions.length; i++) {
      buffer.write('===question_$i==${widget.questions[i]}');
      buffer.write('===answer_$i==${_controllers[i].text.trim()}');
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('প্রশ্নের উত্তর দিন'),
      content: SizedBox(
        width: double.maxFinite,
        child: Form(
          key: _formKey,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.questions.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.questions[index],
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _controllers[index],
                      decoration: InputDecoration(
                        hintText: 'উত্তর লিখুন...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                      maxLines: 3,
                      minLines: 2,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'অনুগ্রহ করে উত্তর লিখুন';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.pop(context),
          child: const Text('বাতিল'),
        ),
        ElevatedButton(
          onPressed: _isSubmitting
              ? null
              : () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() => _isSubmitting = true);
                    
                    final answersString = _buildAnswersString();
                    await widget.onSubmit(answersString);
                    
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  }
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
          ),
          child: _isSubmitting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('জমা দিন'),
        ),
      ],
    );
  }
}
