import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class RefundPolicyPage extends StatelessWidget {
  const RefundPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final policies = [
      {
        'question': 'আমি কি রিফান্ড রিকুয়েস্ট করতে পারবো?',
        'answer': 'জ্বি। আপনি আপনার একাউন্টে পর্যাপ্ত পয়েন্ট থাকা সাপেক্ষে রিফান্ড রিকুয়েস্ট করতে পারবেন।',
      },
      {
        'question': 'রিফান্ড পলিসি কিরকম?',
        'answer': 'আপনার একাউন্টে পর্যাপ্ত পয়েন্ট থাকা সাপেক্ষে শুধু রিফান্ড রিকুয়েস্ট করতে পারবেন! পেমেন্ট করার ৬ ঘন্টার মধ্যে রিফান্ড রিকুয়েস্ট করলে স্বাভাবিক রিফান্ড পাবেন ইনশাআল্লহ। পেমেন্ট করার ৬ ঘন্টা পর কিংবা ৩ দিনের মধ্যে রিফান্ড রিকুয়েস্ট করলে ১.৫ পয়েন্ট=১৳ রেটে রিফান্ড পাবেন।',
      },
      {
        'question': 'কতদিন পর্যন্ত রিফান্ড রিকুয়েস্ট করতে পারবো?',
        'answer': '৩ দিন পর্যন্ত রিফান্ড রিকুয়েস্ট করতে পারবেন।',
      },
      {
        'question': 'কাস্টম এমাউন্ট রিফান্ড করতে পারবো?',
        'answer': 'না, পারবেন না। আপনার করা ট্রান্সজেকশনের বিপরীতে শুধুমাত্র রিফান্ড রিকুয়েস্ট করতে পারবেন।',
      },
      {
        'question': 'রিফান্ড পেতে কতদিন লাগতে পারে?',
        'answer': 'নির্ভর করে। সর্বোচ্চ ৩ কার্যদিবসের মধ্যে রিফান্ড পাবেন।',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('রিফান্ড পলিসি'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primaryColor, AppTheme.primaryColor.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.policy,
                    color: Colors.white,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'রিফান্ড পলিসি',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'আপনার পেমেন্ট নিরাপদ আমাদের কাছে',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Policies
            ...policies.map((policy) => _buildPolicyCard(
              policy['question'] as String,
              policy['answer'] as String,
            )),

            const SizedBox(height: 16),

            // Note
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info, color: Colors.blue[700]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'রিফান্ড সংক্রান্ত যেকোনো সমস্যায় আমাদের সাথে যোগাযোগ করুন। আমরা সর্বদা আপনাকে সাহায্য করতে প্রস্তুত।',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blue[900],
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicyCard(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.help_outline,
                color: AppTheme.primaryColor,
                size: 22,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  question,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Text(
              answer,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
