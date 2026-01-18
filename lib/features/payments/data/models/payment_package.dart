/// Payment package model for bKash payments
class PaymentPackage {
  final String name;
  final String price;
  final int value;
  final int points;
  final List<String> features;

  const PaymentPackage({
    required this.name,
    required this.price,
    required this.value,
    required this.points,
    required this.features,
  });
}

/// Available payment packages matching backend configuration
/// Points formula: amount * 1.2 (from backend)
const List<PaymentPackage> paymentPackages = [
  PaymentPackage(
    name: 'বেসিক প্যাকেজ',
    price: '৩০ টাকা',
    value: 1,
    points: 1,
    features: [
      '৩৬ পয়েন্ট',
      'সর্বোচ্চ ১ বার বায়োডাটা শেয়ার',
      'সর্বোচ্চ ০ বার অভিভাবকের তথ্য',
    ],
  ),
  PaymentPackage(
    name: 'স্ট্যান্ডার্ড প্যাকেজ',
    price: '১০০ টাকা',
    value: 100,
    points: 125,
    features: [
      '১২৫ পয়েন্ট',
      'সর্বোচ্চ ৩ বার বায়োডাটা শেয়ার',
      'সর্বোচ্চ ১ বার অভিভাবকের তথ্য',
    ],
  ),
  PaymentPackage(
    name: 'প্রিমিয়াম প্যাকেজ',
    price: '২০০ টাকা',
    value: 200,
    points: 240,
    features: [
      '২৪০ পয়েন্ট',
      'সর্বোচ্চ ৭ বার বায়োডাটা শেয়ার',
      'সর্বোচ্চ ৩ বার অভিভাবকের তথ্য',
    ],
  ),
  PaymentPackage(
    name: 'প্রো প্যাকেজ',
    price: '৩০০ টাকা',
    value: 300,
    points: 360,
    features: [
      '৩৬০ পয়েন্ট',
      'সর্বোচ্চ ১১ বার বায়োডাটা শেয়ার',
      'সর্বোচ্চ ৪ বার অভিভাবকের তথ্য',
    ],
  ),
  PaymentPackage(
    name: 'এন্টারপ্রাইজ প্যাকেজ',
    price: '৫০০ টাকা',
    value: 500,
    points: 600,
    features: [
      '৬০০ পয়েন্ট',
      'সর্বোচ্চ ১৮ বার বায়োডাটা শেয়ার',
      'সর্বোচ্চ ৮ বার অভিভাবকের তথ্য',
    ],
  ),
];
