import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../providers/biodata_provider.dart';
import '../../domain/entities/biodata_entity.dart';

class BiodataDetailPage extends ConsumerStatefulWidget {
  final String biodataId;
  final String biodataNumber;
  
  const BiodataDetailPage({
    super.key,
    required this.biodataId,
    required this.biodataNumber,
  });
  
  @override
  ConsumerState<BiodataDetailPage> createState() => _BiodataDetailPageState();
}

class _BiodataDetailPageState extends ConsumerState<BiodataDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(biodataDetailNotifierProvider.notifier).loadBiodata(widget.biodataId);
    });
  }
  
  String _calculateAge(DateTime birthDate) {
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age.toString();
  }
  
  String _formatHeight(double heightInCm) {
    final feet = (heightInCm / 30.48).floor();
    final inches = ((heightInCm % 30.48) / 2.54).round();
    return '$feet\' $inches\" (${heightInCm.toStringAsFixed(0)} সেমি)';
  }
  
  String _getBiodataNumber(BiodataEntity biodata) {
    final prefix = biodata.gender == 'মহিলা' ? 'PNCF-' : 'PNCM-';
    return '$prefix${widget.biodataNumber}';
  }
  
  @override
  Widget build(BuildContext context) {
    final biodataState = ref.watch(biodataDetailNotifierProvider);
    
    return Scaffold(
      body: biodataState.when(
        initial: () => const Center(
          child: Text('বায়োডাটা লোড হচ্ছে...'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        loaded: (biodata) => _buildBiodataDetail(context, biodata),
        error: (message) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64.sp, color: Colors.red),
              SizedBox(height: 16.h),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('ফিরে যান'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildBiodataDetail(BuildContext context, BiodataEntity biodata) {
    return CustomScrollView(
      slivers: [
        // App Bar with Profile Header
        SliverAppBar(
          expandedHeight: 250.h,
          pinned: true,
          backgroundColor: biodata.gender == 'মহিলা'
              ? const Color(0xFFC2185B)
              : const Color(0xFF1976D2),
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: biodata.gender == 'মহিলা'
                      ? [const Color(0xFFFF6B9D), const Color(0xFFC2185B)]
                      : [const Color(0xFF1976D2), const Color(0xFF0D47A1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 60.h),
                    // Avatar
                    Container(
                      width: 100.w,
                      // height: 100.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Icon(
                          biodata.gender == 'মহিলা'
                              ? Icons.female
                              : Icons.male,
                          size: 50.sp,
                          color: biodata.gender == 'মহিলা'
                              ? const Color(0xFFC2185B)
                              : const Color(0xFF1976D2),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    // Biodata Number
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        _getBiodataNumber(biodata),
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(height: 8.h),
          
                    // Age and Type
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 12.w,
                        runSpacing: 8.h,
                        children: [
                          _buildHeaderChip(
                            '${_calculateAge(biodata.dateOfBirth)} বছর',
                            Icons.cake,
                          ),
                          _buildHeaderChip(
                            biodata.bioType,
                            biodata.gender == 'মহিলা'
                                ? Icons.female
                                : Icons.male,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                context.showSnackBar('শেয়ার ফিচার শীঘ্রই আসছে');
              },
            ),
          ],
        ),
        
        // Content
        SliverToBoxAdapter(
          child: Column(
            children: [
              // Stats Card
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: _buildStatItem(
                            Icons.visibility,
                            '${biodata.viewsCount ?? 0}',
                            'Views',
                          ),
                        ),
                        Expanded(
                          child: _buildStatItem(
                            Icons.favorite,
                            '${biodata.likesCount ?? 0}',
                            'Likes',
                          ),
                        ),
                        Expanded(
                          child: _buildStatItem(
                            Icons.shopping_cart,
                            '${biodata.purchasesCount ?? 0}',
                            'Purchased',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              // General Info
              _buildSection(
                'সাধারন তথ্য',
                [
                  _buildInfoTile('বায়োডাটার ধরন', biodata.bioType),
                  _buildInfoTile('লিঙ্গ', biodata.gender),
                  _buildInfoTile(
                    'জন্ম তারিখ',
                    '${DateFormat('dd MMMM yyyy').format(biodata.dateOfBirth)} (${_calculateAge(biodata.dateOfBirth)} বছর)',
                  ),
                  _buildInfoTile('উচ্চতা', _formatHeight(biodata.height)),
                  _buildInfoTile('ওজন', '${biodata.weight.toStringAsFixed(0)} কেজি'),
                  _buildInfoTile('গাত্রবর্ন', biodata.screenColor),
                  _buildInfoTile('রক্তের গ্রুপ', biodata.bloodGroup),
                  _buildInfoTile('বৈবাহিক অবস্থা', biodata.maritalStatus),
                  _buildInfoTile('জাতীয়তা', biodata.nationality),
                ],
              ),
              
              // Address Info
              if (biodata.address != null)
                _buildSection(
                  'ঠিকানা',
                  [
                    if (biodata.address!.permanentAddress != null)
                      _buildInfoTile('স্থায়ী ঠিকানা', biodata.address!.permanentAddress!),
                    if (biodata.address!.permanentArea != null)
                      _buildInfoTile('স্থায়ী এলাকা', biodata.address!.permanentArea!),
                    if (biodata.address!.presentAddress != null)
                      _buildInfoTile('বর্তমান ঠিকানা', biodata.address!.presentAddress!),
                    if (biodata.address!.presentArea != null)
                      _buildInfoTile('বর্তমান এলাকা', biodata.address!.presentArea!),
                    if (biodata.address!.grownUp != null)
                      _buildInfoTile('বড় হয়েছেন', biodata.address!.grownUp!),
                    if (biodata.address!.division != null)
                      _buildInfoTile('বিভাগ', biodata.address!.division!),
                    if (biodata.address!.zilla != null)
                      _buildInfoTile('জেলা', biodata.address!.zilla!),
                    if (biodata.address!.upzilla != null)
                      _buildInfoTile('উপজেলা', biodata.address!.upzilla!),
                    if (biodata.address!.city != null)
                      _buildInfoTile('শহর', biodata.address!.city!),
                  ],
                ),
              
              // Educational Qualification
              if (biodata.educationQualification != null)
                _buildSection(
                  'শিক্ষাগত যোগ্যতা',
                  [
                    if (biodata.educationQualification!.educationMedium != null)
                      _buildInfoTile('শিক্ষার মাধ্যম', biodata.educationQualification!.educationMedium!),
                    if (biodata.educationQualification!.highestEduLevel != null)
                      _buildInfoTile('সর্বোচ্চ শিক্ষা', biodata.educationQualification!.highestEduLevel!),
                    if (biodata.educationQualification!.sscYear != null)
                      _buildInfoTile('এসএসসি বছর', '${biodata.educationQualification!.sscYear}'),
                    if (biodata.educationQualification!.sscGroup != null)
                      _buildInfoTile('এসএসসি গ্রুপ', biodata.educationQualification!.sscGroup!),
                    if (biodata.educationQualification!.sscResult != null)
                      _buildInfoTile('এসএসসি ফলাফল', biodata.educationQualification!.sscResult!),
                    if (biodata.educationQualification!.diplomaSub != null)
                      _buildInfoTile('ডিপ্লোমা বিষয়', biodata.educationQualification!.diplomaSub!),
                    if (biodata.educationQualification!.diplomaInst != null)
                      _buildInfoTile('ডিপ্লোমা প্রতিষ্ঠান', biodata.educationQualification!.diplomaInst!),
                    if (biodata.educationQualification!.diplomaPassYear != null)
                      _buildInfoTile('ডিপ্লোমা পাস বছর', '${biodata.educationQualification!.diplomaPassYear}'),
                    if (biodata.educationQualification!.othersEdu != null)
                      _buildInfoTile('অন্যান্য শিক্ষা', biodata.educationQualification!.othersEdu!),
                    if (biodata.educationQualification!.deeniEdu != null && biodata.educationQualification!.deeniEdu!.isNotEmpty)
                      _buildInfoTile('দ্বীনি শিক্ষা', biodata.educationQualification!.deeniEdu!.join(', ')),
                  ],
                ),
              
              // Family Information
              if (biodata.familyStatus != null)
                _buildSection(
                  'পারিবারিক তথ্য',
                  [
                    if (biodata.familyStatus!.fatherName != null)
                      _buildInfoTile('পিতার নাম', biodata.familyStatus!.fatherName!),
                    if (biodata.familyStatus!.isFatherAlive != null)
                      _buildInfoTile('পিতা জীবিত আছেন', biodata.familyStatus!.isFatherAlive!),
                    if (biodata.familyStatus!.fatherOccupation != null)
                      _buildInfoTile('পিতার পেশা', biodata.familyStatus!.fatherOccupation!),
                    if (biodata.familyStatus!.motherName != null)
                      _buildInfoTile('মাতার নাম', biodata.familyStatus!.motherName!),
                    if (biodata.familyStatus!.isMotherAlive != null)
                      _buildInfoTile('মাতা জীবিত আছেন', biodata.familyStatus!.isMotherAlive!),
                    if (biodata.familyStatus!.motherOccupation != null)
                      _buildInfoTile('মাতার পেশা', biodata.familyStatus!.motherOccupation!),
                    if (biodata.familyStatus!.numberOfBrothers != null)
                      _buildInfoTile('ভাইয়ের সংখ্যা', biodata.familyStatus!.numberOfBrothers!),
                    if (biodata.familyStatus!.brotherInfo != null && biodata.familyStatus!.brotherInfo!.isNotEmpty)
                      _buildInfoTile('ভাইদের তথ্য', biodata.familyStatus!.brotherInfo!.join('\n')),
                    if (biodata.familyStatus!.numberOfSisters != null)
                      _buildInfoTile('বোনের সংখ্যা', biodata.familyStatus!.numberOfSisters!),
                    if (biodata.familyStatus!.sisterInfo != null && biodata.familyStatus!.sisterInfo!.isNotEmpty && biodata.familyStatus!.sisterInfo!.first.isNotEmpty)
                      _buildInfoTile('বোনদের তথ্য', biodata.familyStatus!.sisterInfo!.join('\n')),
                    if (biodata.familyStatus!.uncleInfo != null)
                      _buildInfoTile('চাচা/মামার তথ্য', biodata.familyStatus!.uncleInfo!),
                    if (biodata.familyStatus!.ecoConditionType != null)
                      _buildInfoTile('অর্থনৈতিক অবস্থা', biodata.familyStatus!.ecoConditionType!),
                    if (biodata.familyStatus!.familyEcoCondition != null)
                      _buildInfoTile('পারিবারিক অবস্থা', biodata.familyStatus!.familyEcoCondition!),
                    if (biodata.familyStatus!.familyDeeniInfo != null)
                      _buildInfoTile('পরিবারের দ্বীনি অবস্থা', biodata.familyStatus!.familyDeeniInfo!),
                  ],
                ),
              
              // Occupation
              if (biodata.occupation != null)
                _buildSection(
                  'পেশা',
                  [
                    if (biodata.occupation!.occupation != null && biodata.occupation!.occupation!.isNotEmpty)
                      _buildInfoTile('পেশা', biodata.occupation!.occupation!.join(', ')),
                    if (biodata.occupation!.occupationDetails != null)
                      _buildInfoTile('পেশার বিবরন', biodata.occupation!.occupationDetails!),
                    if (biodata.occupation!.monthlyIncome != null && biodata.occupation!.monthlyIncome! > 0)
                      _buildInfoTile('মাসিক আয়', '${biodata.occupation!.monthlyIncome} টাকা'),
                  ],
                ),
              
              // Personal Information
              if (biodata.personalInfo != null)
                _buildSection(
                  'ব্যক্তিগত তথ্য',
                  [
                    if (biodata.personalInfo!.outsideClothings != null)
                      _buildInfoTile('পোশাক', biodata.personalInfo!.outsideClothings!),
                    if (biodata.personalInfo!.isBeard != null && biodata.personalInfo!.isBeard!.isNotEmpty)
                      _buildInfoTile('দাড়ি', biodata.personalInfo!.isBeard!),
                    if (biodata.personalInfo!.fromBeard != null && biodata.personalInfo!.fromBeard!.isNotEmpty)
                      _buildInfoTile('দাড়ি রাখা শুরু', biodata.personalInfo!.fromBeard!),
                    if (biodata.personalInfo!.fromWhenNikhab != null && biodata.personalInfo!.fromWhenNikhab!.isNotEmpty)
                      _buildInfoTile('নিকাব রাখা শুরু', biodata.personalInfo!.fromWhenNikhab!),
                    if (biodata.personalInfo!.isDailyFive != null)
                      _buildInfoTile('পাঁচ ওয়াক্ত নামাজ', biodata.personalInfo!.isDailyFive!),
                    if (biodata.personalInfo!.isDailyFiveJamaat != null && biodata.personalInfo!.isDailyFiveJamaat!.isNotEmpty)
                      _buildInfoTile('জামাতে নামাজ', biodata.personalInfo!.isDailyFiveJamaat!),
                    if (biodata.personalInfo!.qadhaWeekly != null)
                      _buildInfoTile('কাজা নামাজ', biodata.personalInfo!.qadhaWeekly!),
                    if (biodata.personalInfo!.quranTilawat != null)
                      _buildInfoTile('কুরআন তিলাওয়াত', biodata.personalInfo!.quranTilawat!),
                    if (biodata.personalInfo!.fiqh != null)
                      _buildInfoTile('ফিকহ', biodata.personalInfo!.fiqh!),
                    if (biodata.personalInfo!.mahramNonMahram != null)
                      _buildInfoTile('মাহরাম-নন মাহরাম', biodata.personalInfo!.mahramNonMahram!),
                    if (biodata.personalInfo!.natokCinema != null)
                      _buildInfoTile('নাটক/সিনেমা', biodata.personalInfo!.natokCinema!),
                    if (biodata.personalInfo!.mazar != null)
                      _buildInfoTile('মাজার সম্পর্কে মত', biodata.personalInfo!.mazar!),
                    if (biodata.personalInfo!.aboutMiladQiyam != null && biodata.personalInfo!.aboutMiladQiyam!.isNotEmpty)
                      _buildInfoTile('মিলাদ/ক্বিয়াম সম্পর্কে মত', biodata.personalInfo!.aboutMiladQiyam!),
                    if (biodata.personalInfo!.islamicBooks != null)
                      _buildInfoTile('প্রিয় ইসলামিক বই', biodata.personalInfo!.islamicBooks!),
                    if (biodata.personalInfo!.islamicScholars != null)
                      _buildInfoTile('প্রিয় ইসলামিক স্কলার', biodata.personalInfo!.islamicScholars!),
                    if (biodata.personalInfo!.specialDeeniMehnot != null && biodata.personalInfo!.specialDeeniMehnot!.isNotEmpty)
                      _buildInfoTile('বিশেষ দ্বীনি মেহনত', biodata.personalInfo!.specialDeeniMehnot!),
                    if (biodata.personalInfo!.isNeshaDrobbo != null)
                      _buildInfoTile('নেশাজাতীয় দ্রব্য', biodata.personalInfo!.isNeshaDrobbo!),
                    if (biodata.personalInfo!.physicalProblem != null)
                      _buildInfoTile('শারীরিক সমস্যা', biodata.personalInfo!.physicalProblem!),
                    if (biodata.personalInfo!.aboutMe != null)
                      _buildInfoTile('নিজের সম্পর্কে', biodata.personalInfo!.aboutMe!),
                  ],
                ),
              
              // Marital Information
              if (biodata.maritalInfo != null)
                _buildSection(
                  'বিবাহ সম্পর্কিত তথ্য',
                  [
                    if (biodata.maritalInfo!.whyMarriage != null)
                      _buildInfoTile('বিয়ে কেন করতে চান', biodata.maritalInfo!.whyMarriage!),
                    if (biodata.maritalInfo!.isFamilyAgree != null)
                      _buildInfoTile('পরিবার রাজি আছে', biodata.maritalInfo!.isFamilyAgree!),
                    if (biodata.maritalInfo!.isPordaToWife != null && biodata.maritalInfo!.isPordaToWife!.isNotEmpty)
                      _buildInfoTile('স্ত্রীকে পর্দা করাবেন', biodata.maritalInfo!.isPordaToWife!),
                    if (biodata.maritalInfo!.permissionForStudy != null && biodata.maritalInfo!.permissionForStudy!.isNotEmpty)
                      _buildInfoTile('পড়াশুনার অনুমতি', biodata.maritalInfo!.permissionForStudy!),
                    if (biodata.maritalInfo!.permissionForJob != null && biodata.maritalInfo!.permissionForJob!.isNotEmpty)
                      _buildInfoTile('চাকরির অনুমতি', biodata.maritalInfo!.permissionForJob!),
                    if (biodata.maritalInfo!.isRunningStudy != null && biodata.maritalInfo!.isRunningStudy!.isNotEmpty)
                      _buildInfoTile('বিয়ের পর পড়াশুনা', biodata.maritalInfo!.isRunningStudy!),
                    if (biodata.maritalInfo!.afterMarriageRunningJob != null && biodata.maritalInfo!.afterMarriageRunningJob!.isNotEmpty)
                      _buildInfoTile('বিয়ের পর চাকরি', biodata.maritalInfo!.afterMarriageRunningJob!),
                    if (biodata.maritalInfo!.isJoutuk != null && biodata.maritalInfo!.isJoutuk!.isNotEmpty)
                      _buildInfoTile('যৌতুক সম্পর্কে ধারণা', biodata.maritalInfo!.isJoutuk!),
                    if (biodata.maritalInfo!.afterMarriageWhere != null && biodata.maritalInfo!.afterMarriageWhere!.isNotEmpty)
                      _buildInfoTile('বিয়ের পর কোথায় থাকবেন', biodata.maritalInfo!.afterMarriageWhere!),
                    if (biodata.maritalInfo!.divorcedReason != null && biodata.maritalInfo!.divorcedReason!.isNotEmpty)
                      _buildInfoTile('ডিভোর্সের কারণ', biodata.maritalInfo!.divorcedReason!),
                    if (biodata.maritalInfo!.quantityWifeAndChildren != null && biodata.maritalInfo!.quantityWifeAndChildren!.isNotEmpty)
                      _buildInfoTile('স্ত্রী ও সন্তান সংখ্যা', biodata.maritalInfo!.quantityWifeAndChildren!),
                  ],
                ),
              
              // Expected Life Partner
              if (biodata.expectedLifePartner != null)
                _buildSection(
                  'প্রত্যাশিত জীবনসাথী',
                  [
                    if (biodata.expectedLifePartner!.age != null)
                      _buildInfoTile(
                        'বয়স',
                        '${biodata.expectedLifePartner!.age!.min ?? ''} - ${biodata.expectedLifePartner!.age!.max ?? ''} বছর',
                      ),
                    if (biodata.expectedLifePartner!.height != null)
                      _buildInfoTile(
                        'উচ্চতা',
                        '${biodata.expectedLifePartner!.height!.min ?? ''} - ${biodata.expectedLifePartner!.height!.max ?? ''} ফুট',
                      ),
                    if (biodata.expectedLifePartner!.color != null && biodata.expectedLifePartner!.color!.isNotEmpty)
                      _buildInfoTile('বর্ণ', biodata.expectedLifePartner!.color!.join(', ')),
                    if (biodata.expectedLifePartner!.zilla != null && biodata.expectedLifePartner!.zilla!.isNotEmpty)
                      _buildInfoTile('জেলা', biodata.expectedLifePartner!.zilla!.join(', ')),
                    if (biodata.expectedLifePartner!.maritalStatus != null && biodata.expectedLifePartner!.maritalStatus!.isNotEmpty)
                      _buildInfoTile('বৈবাহিক অবস্থা', biodata.expectedLifePartner!.maritalStatus!.join(', ')),
                    if (biodata.expectedLifePartner!.educationalQualifications != null && biodata.expectedLifePartner!.educationalQualifications!.isNotEmpty)
                      _buildInfoTile('শিক্ষাগত যোগ্যতা', biodata.expectedLifePartner!.educationalQualifications!.join(', ')),
                    if (biodata.expectedLifePartner!.occupation != null && biodata.expectedLifePartner!.occupation!.isNotEmpty)
                      _buildInfoTile('পেশা', biodata.expectedLifePartner!.occupation!.join(', ')),
                    if (biodata.expectedLifePartner!.economicalCondition != null && biodata.expectedLifePartner!.economicalCondition!.isNotEmpty)
                      _buildInfoTile('অর্থনৈতিক অবস্থা', biodata.expectedLifePartner!.economicalCondition!.join(', ')),
                    if (biodata.expectedLifePartner!.expectedCharacteristics != null)
                      _buildInfoTile('প্রত্যাশিত গুণাবলী', biodata.expectedLifePartner!.expectedCharacteristics!),
                  ],
                ),
              
              // Contact Button
              Padding(
                padding: EdgeInsets.all(16.w),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showContactDialog(context);
                    },
                    icon: const Icon(Icons.phone),
                    label: const Text('যোগাযোগের তথ্য দেখুন'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(16.w),
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppTheme.primaryColor, size: 24.sp),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12.sp,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
  
  Widget _buildSection(String title, List<Widget> children) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
            const Divider(height: 1),
            ...children,
          ],
        ),
      ),
    );
  }
  
  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              overflow: TextOverflow.visible,
              softWrap: true,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.visible,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
  
  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('যোগাযোগের তথ্য'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lock, size: 48, color: Colors.orange),
            SizedBox(height: 16),
            Text(
              'যোগাযোগের তথ্য দেখতে আপনাকে লগইন করতে হবে এবং বায়োডাটা ক্রয় করতে হবে।',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('বন্ধ করুন'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.showSnackBar('পেমেন্ট ফিচার শীঘ্রই আসছে');
            },
            child: const Text('ক্রয় করুন'),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderChip(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.sp, color: Colors.white),
          SizedBox(width: 6.w),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
