import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  final List<Map<String, dynamic>> _faqItems = [
    {
      'question': 'PNC নিকাহ এর বিশেষত্ব কি?',
      'answer': 'হাই প্রোফাইল/বায়োডাটার ক্ষেত্রে অনেক বেশী রিকুয়েস্ট পেলে রিজেকশনের প্রবণতা তৈরী হতে পারে! বায়োডাটা দাতা হয়তও এভাবে ভাবেন না যে অপরদিক থেকে প্রত্যেকে টাকা পে করে! PNC নিকাহ চায় বায়ো-ক্রেতাদের লসকে মিনিমাইজ করার লক্ষে ২টি স্টেপ ইন্ট্রোডিউস করেছে!',
      'isExpanded': false,
    },
    {
      'question': 'প্রথম স্টেপ কি?',
      'answer': 'প্রথম স্টেপে বায়ো-ক্রেতা ৩০% পেমেন্ট করে (৩০ পয়েন্ট) নিজের বায়োডাটা তার ক্রয়কৃত বায়োডাটার ব্যক্তির সাথে শেয়ার করতে পারবে। তারপর অ্যাপ্রুভাল পেলেই কেবল সামনে আগাতে পারবে। এ পদ্ধতিতে বায়ো ক্রেতাকে পুরো টাকা পে করতে হচ্ছে না।',
      'isExpanded': false,
    },
    {
      'question': '২য় স্টেপ কি?',
      'answer': 'এটি বায়োডাটা ক্রয় করার ২য় স্টেপ। প্রথম স্টেপে শেয়ার করা বায়োডাটাসহ তথ্যের ভিত্তিতে অ্যাপ্রুভাল পেলেই শুধুমাত্র ২য় স্টেপের জন্য ৭০ পয়েন্ট খরচ করে ফাইনালি অভিভাবকের তথ্য পেতে পারবে।',
      'isExpanded': false,
    },
    {
      'question': 'পয়েন্ট এর রেট কত?',
      'answer': 'বর্তমান রেট অনুযায়ী ১ টাকা = ১.২ পয়েন্ট। তবে PNC নিকাহ কর্তৃপক্ষ যেকোনোসময় এই রেট পরিবর্তন করতে পারে!',
      'isExpanded': false,
    },
    {
      'question': 'আমি কি আমার একাউন্ট দিয়ে আমার ছেলে/মেয়ে/আত্মীয়দের জন্য বায়োডাটা তৈরি করতে পারবো?',
      'answer': 'হ্যাঁ, আপনি অভিভাবক হিসেবে রেজি করে আপনার অধিনস্থ/নিকটাত্মীয়দের জন্য বায়োডাটা পাবলিশ করতে পারবেন ইনশাআল্লহ।',
      'isExpanded': false,
    },
    {
      'question': 'অভিভাবকের অনুমতি ছাড়া কি আমি বায়োডাটা দিতে পারবো?',
      'answer': 'না! অভিভাবকের পারমিশন ছাড়া আপনার বায়োডাটা অ্যাপ্রুভ করা হবে না। PNC নিকাহ আপনার প্রদত্ত অভিভাবকের তথ্য অনুযায়ী তাদের সম্মতি সাপেক্ষে বায়োডাটার অ্যাপ্রুভাল দিবে। ভুল তথ্য দিয়ে প্রতারণা করলে বায়োডাটাসহ একাউন্ট ব্যান করে দেওয়া হবে।',
      'isExpanded': false,
    },
    {
      'question': 'আমি কি নগদ/রকেট/ব্যাংকিং মেথড দিয়ে পেমেন্ট করে বায়োডাটা কিনতে পারবো?',
      'answer': 'না। আপাতত আমরা শুধুমাত্র বিকাশ পেমেন্ট গ্রহণ করে থাকি।',
      'isExpanded': false,
    },
    {
      'question': 'প্রথম স্টেপে রিজেকশন পেলে করনীয় কি?',
      'answer': 'এটা পুরোটাই বায়োডাটা দাতার উপর নির্ভর করে। রিজেকশনের পর আর ঐ বায়োডাটার তথ্য দেখা সম্ভব না।',
      'isExpanded': false,
    },
    {
      'question': '২য় স্টেপে প্রশ্নগুলো কিসের এবং কেন?',
      'answer': '২য় স্টেপে কিছু প্রশ্ন থাকে যা বায়োডাটা দাতা তার পছন্দ অনুযায়ী সেট করে থাকেন। এতে বায়োডাটা ক্রেতার সম্পর্কে আরও বিস্তারিত জানা যায় এবং সঠিক সিদ্ধান্ত নিতে সাহায্য করে।',
      'isExpanded': false,
    },
    {
      'question': 'প্রথম স্টেপে অ্যাপ্রুভাল পেয়েছি, এখন করনীয় কি?',
      'answer': 'যে বায়োডাটায় প্রথম স্টেপে অ্যাপ্রুভাল পেয়েছেন, ওই বায়োডাটার ডিটেইলসে গিয়ে একেবারে শেষের(নিচে) দিকে ২য় স্টেপের জন্য পেমেন্ট করার লিংক পাবেন। অথবা, আপনার ড্যাশবোর্ডের বাম পাশের সাইডবারেও \'আমার ক্রয়সমুহ\' সেকশনে/পেইজে গিয়ে আপনার সকল ক্রয়(১ম ও ২য় স্টেপ) দেখতে পারবেন।',
      'isExpanded': false,
    },
    {
      'question': 'কিভাবে এবং কোন স্টেপে অভিভাবকের তথ্য দেখতে পারবো?',
      'answer': '২য় স্টেপের পেমেন্ট করার সাথে সাথেই অভিভাবকের তথ্য দেখতে পারবেন। এক্ষেত্রে বায়োডাটার ডিটেইলস পেইজের একেবারে শেষের দিকে অভিভাবকের তথ্য দেখতে পারবেন।',
      'isExpanded': false,
    },
    {
      'question': 'প্রথম স্টেপে অ্যাপ্রুভাল/রিজেকশনের বিষয়ে কখন জানতে পারবো?',
      'answer': 'বায়োডাটা দাতার সক্রিয়তার উপর নির্ভর করে। সাধারণত ২৪-৭২ ঘন্টার মধ্যে জানতে পারবেন। তবে কিছু ক্ষেত্রে বেশি সময় লাগতে পারে।',
      'isExpanded': false,
    },
    {
      'question': 'কোনো বায়োডাটার অ্যাপ্রুভাল রেট কিংবা রিজেকশন রেট কি?',
      'answer': 'প্রতিটি বায়োডাটার জন্য অ্যাপ্রুভাল এবং রিজেকশন রেট দেখানো হয়। এটা বায়োডাটা দাতার আগের সিদ্ধান্তগুলোর উপর ভিত্তি করে তৈরি। এতে ক্রেতা সিদ্ধান্ত নিতে সাহায্য পান।',
      'isExpanded': false,
    },
    {
      'question': 'বায়োডাটার রিজেকশন রেট বেশি। এর অর্থ কি?',
      'answer': 'এর অর্থ হলো বায়োডাটা দাতা বেশিরভাগ রিকুয়েস্ট রিজেক্ট করে থাকেন। এক্ষেত্রে সতর্কতার সাথে সিদ্ধান্ত নিন। রিজেকশন রেট বেশি হলে আপনার রিকুয়েস্টও রিজেক্ট হওয়ার সম্ভাবনা বেশি।',
      'isExpanded': false,
    },
    {
      'question': 'ফিচার্ড বায়োডাটা কি?',
      'answer': 'এটা মুলত বিজ্ঞাপনের মতো। আপনার বায়োডাটা ফিচার করতে ১৫০ পয়েন্ট (১০০/১.২)= ১২৫ টাকা পেমেন্ট করতে হবে। এতে আপনার বায়োডাটা PNC নিকাহ ওয়েবসাইটের হোমপেইজের \'ফিচার্ড\' সেকশনে থাকবে এবং বেশি ভিজিটর/ভিউ পেতে পারেন।',
      'isExpanded': false,
    },
    {
      'question': 'আমার বিয়ের কথাবার্তা চলছে! আমার কি কোনো করণীয় আছে?',
      'answer': 'এই ক্ষেত্রে \'PNC নিকাহ\' জোরালোভাবে সাজেস্ট করে বায়োডাটা \'হাইড\' করতে। হাইড না করলে এঅবস্থায় কেউ টাকা খরচ করে আপনার বায়োডাটা ক্রয় করুক, PNC নিকাহ এটা কখনওই সমর্থন করে না এবং চায় না।',
      'isExpanded': false,
    },
    {
      'question': 'আমার বায়োডাটা কিভাবে হাইড করবো?',
      'answer': 'আপনি সাময়িকভাবে কোনো বায়ো-রিকুয়েস্ট না পেতে চাইলে আপনার বায়োডাটা আপনার ড্যাশবোর্ড থেকে \'সেটিংস\' পেইজে গিয়ে হাইড/শো করাতে পারবেন।',
      'isExpanded': false,
    },
    {
      'question': 'আমার বিয়ে হয়ে গেছে। এখন করণীয় কি?',
      'answer': 'আপনাকে অবশ্যই বায়োডাটা হাইড করতে হবে। অন্যথায়, আপনার বায়োডাটা কেউ কিনলে সে দায়ভার PNC নিকাহ কখনওই নিবে না। বিয়ে হয়ে যাওয়ার পরও বায়োডাটা পাবলিশড রাখলে তা হবে অনৈতিক।',
      'isExpanded': false,
    },
    {
      'question': '১৮ বছরের কম বয়সী মেয়ে কিংবা ২১ বছরের কম বয়সী ছেলেদের বায়োডাটা কি অ্যাপ্রুভ করা হয়?',
      'answer': 'না। বাংলাদেশের আইন অনুযায়ী মেয়েদের বিয়ের সর্বনিম্ন বয়স ১৮ বছর এবং ছেলেদের ২১ বছর। PNC নিকাহ এই আইন মেনে চলে এবং নির্ধারিত বয়সের কম হলে বায়োডাটা অ্যাপ্রুভ করা হয় না।',
      'isExpanded': false,
    },
    {
      'question': 'বায়োডাটা অ্যাপ্রুভ/রিজেক্ট কখন হবে এবং কিভাবে বুঝবো?',
      'answer': 'বায়োডাটা সাবমিট করার পর আমাদের টিম যাচাই করে অ্যাপ্রুভ/রিজেক্ট করবে। সাধারণত ২৪-৪৮ ঘন্টার মধ্যে জানতে পারবেন। আপনার ড্যাশবোর্ডে এবং ইমেইল/নোটিফিকেশনের মাধ্যমে জানানো হবে।',
      'isExpanded': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('সচরাচর জিজ্ঞাসা'),
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
                    Icons.help_center,
                    color: Colors.white,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'সচরাচর জিজ্ঞাসা (FAQ)',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'আপনার প্রশ্নের উত্তর খুঁজুন',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // FAQ Items
            ..._faqItems.asMap().entries.map((entry) {
              final index = entry.key;
              final faq = entry.value;
              return _buildFaqItem(index, faq);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem(int index, Map<String, dynamic> faq) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          leading: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ),
          title: Text(
            faq['question'] as String,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          iconColor: AppTheme.primaryColor,
          collapsedIconColor: Colors.grey,
          children: [
            Text(
              faq['answer'] as String,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[700],
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
