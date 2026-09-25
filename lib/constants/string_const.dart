class StringConst {
  static const appTitle = 'Herbs and Spices App';
  static const appFontFamily = 'PlusJakartaSans';
  static const onboardingHeadlinePrefix = 'Fancy another ';
  static const onboardingHeadlineBlast = 'blast';
  static const onboardingHeadlineOf = ' of ';
  static const onboardingHeadlineFeelGood = 'feel-good';
  static const onboardingHeadlineSuffix = ' flavors?';
  static const onboardingBody =
      'Old Mix helps you to find authentic herbs and spices bursting with flavours while brimming your confidence.';
  static const discover = 'Discover';
  static const yourTaste = 'Your Taste !';
  static const tenPercentOff = '10% OFF';
  static const wishlist = 'Wishlist';
  static const reels = 'Reels';
  static const account = 'Account';

  static String pricePerGram(double price) => '\$${price.toStringAsFixed(2)}/g';

  static String percentOff(int percent) => '$percent % Off';
}
