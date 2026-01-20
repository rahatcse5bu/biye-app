import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/bio_questions_provider.dart';

class BioQuestionsScreen extends ConsumerStatefulWidget {
  const BioQuestionsScreen({super.key});

  @override
  ConsumerState<BioQuestionsScreen> createState() => _BioQuestionsScreenState();
}

class _BioQuestionsScreenState extends ConsumerState<BioQuestionsScreen> {
  final List<TextEditingController> _controllers = [];
  bool _isLoading = false;

  // Default questions (in Bangla, matching backend)
  final List<String> _defaultQuestions = [
    'আপনি কেন আমার বায়োডাটায় আগ্রহী?',
    'আপনার পরিবার সম্পর্কে কিছু বলুন',
    'আপনার শিক্ষাগত যোগ্যতা কী?',
    'আপনার পেশা সম্পর্কে জানাতে চাই',
    'আপনার ধর্মীয় অনুশীলন সম্পর্কে বলুন',
    'আপনার ভবিষ্যৎ পরিকল্পনা কী?',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadQuestions();
    });
  }

  Future<void> _loadQuestions() async {
    final myQuestions = await ref.read(myBioQuestionsProvider.future);
    
    if (myQuestions != null && myQuestions.questions.isNotEmpty) {
      // Load existing questions
      for (var question in myQuestions.questions) {
        _controllers.add(TextEditingController(text: question));
      }
    } else {
      // Load default questions
      for (var question in _defaultQuestions) {
        _controllers.add(TextEditingController(text: question));
      }
    }
    
    setState(() {});
  }

  void _addQuestion() {
    if (_controllers.length >= 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('সর্বোচ্চ ১০টি প্রশ্ন যোগ করতে পারবেন'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _controllers.add(TextEditingController());
    });
  }

  void _removeQuestion(int index) {
    if (_controllers.length <= 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('কমপক্ষে ১টি প্রশ্ন থাকতে হবে'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _controllers[index].dispose();
      _controllers.removeAt(index);
    });
  }

  Future<void> _saveQuestions() async {
    // Validate questions
    final questions = _controllers
        .map((controller) => controller.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();

    if (questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('কমপক্ষে ১টি প্রশ্ন লিখুন'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (questions.length > 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('সর্বোচ্চ ১০টি প্রশ্ন যোগ করতে পারবেন'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final saveFunction = ref.read(saveBioQuestionsProvider);
      await saveFunction(questions);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('প্রশ্নগুলি সফলভাবে সংরক্ষণ করা হয়েছে'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('ত্রুটি: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('আমার প্রশ্ন সেট করুন'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue.shade700, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'যারা আপনার বায়োডাটা ক্রয় করবেন তাদেরকে এই প্রশ্নগুলোর উত্তর দিতে হবে। সর্বনিম্ন ১টি এবং সর্বোচ্চ ১০টি প্রশ্ন যোগ করতে পারবেন।',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blue.shade900,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),

            // Questions List
            if (_controllers.isEmpty)
              const Center(
                child: CircularProgressIndicator(),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _controllers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Question Number
                        Container(
                          width: 32,
                          height: 32,
                          margin: const EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        
                        const SizedBox(width: 12),
                        
                        // Question Input
                        Expanded(
                          child: TextField(
                            controller: _controllers[index],
                            decoration: InputDecoration(
                              hintText: 'প্রশ্ন লিখুন...',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: AppTheme.primaryColor,
                                  width: 2,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(16),
                            ),
                            maxLines: 3,
                            minLines: 1,
                          ),
                        ),
                        
                        const SizedBox(width: 8),
                        
                        // Remove Button
                        IconButton(
                          onPressed: () => _removeQuestion(index),
                          icon: const Icon(Icons.delete_outline),
                          color: Colors.red.shade600,
                          tooltip: 'মুছে ফেলুন',
                        ),
                      ],
                    ),
                  );
                },
              ),

            // Add Question Button
            if (_controllers.length < 10)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: OutlinedButton.icon(
                  onPressed: _addQuestion,
                  icon: const Icon(Icons.add),
                  label: const Text('নতুন প্রশ্ন যোগ করুন'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primaryColor,
                    side: const BorderSide(color: AppTheme.primaryColor),
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 24),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _saveQuestions,
                icon: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.save_outlined),
                label: Text(_isLoading ? 'সংরক্ষণ হচ্ছে...' : 'সংরক্ষণ করুন'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
