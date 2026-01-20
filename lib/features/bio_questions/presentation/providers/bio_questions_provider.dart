import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/dio_provider.dart';
import '../../data/datasources/bio_questions_remote_datasource.dart';
import '../../data/models/bio_questions_model.dart';

// Datasource Provider
final bioQuestionsRemoteDataSourceProvider = Provider<BioQuestionsRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return BioQuestionsRemoteDataSource(dioClient);
});

// Get My Questions Provider (for biodata owner)
final myBioQuestionsProvider = FutureProvider<BioQuestionsModel?>((ref) async {
  final dataSource = ref.watch(bioQuestionsRemoteDataSourceProvider);
  return await dataSource.getMyQuestions();
});

// Get Questions By User ID Provider (for buyers)
final bioQuestionsByUserProvider = FutureProvider.family<BioQuestionsModel?, String>((ref, userId) async {
  final dataSource = ref.watch(bioQuestionsRemoteDataSourceProvider);
  return await dataSource.getQuestionsByUser(userId);
});

// State Provider for managing questions list in UI
final questionsListProvider = StateProvider<List<String>>((ref) => []);

// Provider for saving questions
final saveBioQuestionsProvider = Provider<Future<void> Function(List<String>)>((ref) {
  return (List<String> questions) async {
    final dataSource = ref.read(bioQuestionsRemoteDataSourceProvider);
    await dataSource.upsertQuestions(questions);
    ref.invalidate(myBioQuestionsProvider);
  };
});

// Provider for deleting questions
final deleteBioQuestionsProvider = Provider<Future<void> Function()>((ref) {
  return () async {
    final dataSource = ref.read(bioQuestionsRemoteDataSourceProvider);
    await dataSource.deleteQuestions();
    ref.invalidate(myBioQuestionsProvider);
  };
});
