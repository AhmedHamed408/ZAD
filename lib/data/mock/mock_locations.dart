class MockLocationData {
  final String userId;
  final String userName;
  final String city;
  final double latitude;
  final double longitude;
  final String address;
  final String lastUpdated;

  MockLocationData({
    required this.userId,
    required this.userName,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.lastUpdated,
  });
}

class MockLocations {
  static final Map<String, MockLocationData> userLocations = {
    '01012345678': MockLocationData(
      userId: 'user_001',
      userName: 'Ahmed Hassan',
      city: 'Cairo, Egypt',
      latitude: 30.0444,
      longitude: 31.2357,
      address: '15 Tahrir Square, Downtown, Cairo',
      lastUpdated: 'Just now',
    ),
    '01123456789': MockLocationData(
      userId: 'user_002',
      userName: 'Mohamed Ali',
      city: 'Giza, Egypt',
      latitude: 30.0131,
      longitude: 31.2089,
      address: '22 Al-Haram St, Pyramids District, Giza',
      lastUpdated: '2 minutes ago',
    ),
    '01234567890': MockLocationData(
      userId: 'user_003',
      userName: 'Omar Khaled',
      city: 'Alexandria, Egypt',
      latitude: 31.2001,
      longitude: 29.9187,
      address: '45 Stanley Bridge Corniche, Alexandria',
      lastUpdated: '5 minutes ago',
    ),
    '01098765432': MockLocationData(
      userId: 'user_004',
      userName: 'Youssef Ahmed',
      city: 'Cairo, Egypt',
      latitude: 29.9602,
      longitude: 31.2569,
      address: 'Road 9, Maadi, Cairo',
      lastUpdated: '12 minutes ago',
    ),
    '01198765432': MockLocationData(
      userId: 'user_005',
      userName: 'Mahmoud Adel',
      city: 'Mansoura, Egypt',
      latitude: 31.0409,
      longitude: 31.3785,
      address: 'El-Gomhouria St, Mansoura',
      lastUpdated: '18 minutes ago',
    ),
    '01287654321': MockLocationData(
      userId: 'user_006',
      userName: 'Mostafa Mohamed',
      city: 'Tanta, Egypt',
      latitude: 30.7865,
      longitude: 31.0004,
      address: 'El-Bahr St, Tanta',
      lastUpdated: '7 minutes ago',
    ),
    '01045678912': MockLocationData(
      userId: 'user_007',
      userName: 'Sara Hassan',
      city: 'Cairo, Egypt',
      latitude: 30.0911,
      longitude: 31.3236,
      address: 'Al-Merghany St, Heliopolis, Cairo',
      lastUpdated: '4 minutes ago',
    ),
    '01134567890': MockLocationData(
      userId: 'user_008',
      userName: 'Mariam Ahmed',
      city: 'Alexandria, Egypt',
      latitude: 31.2425,
      longitude: 29.9658,
      address: 'Glim Beach, Alexandria',
      lastUpdated: '25 minutes ago',
    ),
    '01256789012': MockLocationData(
      userId: 'user_009',
      userName: 'Nour Khaled',
      city: 'Giza, Egypt',
      latitude: 30.0416,
      longitude: 30.9753,
      address: 'Sheikh Zayed City, Giza',
      lastUpdated: '10 minutes ago',
    ),
    '01076543219': MockLocationData(
      userId: 'user_010',
      userName: 'Menna Ali',
      city: 'Tanta, Egypt',
      latitude: 30.7912,
      longitude: 31.0051,
      address: 'Saeed St, Tanta',
      lastUpdated: '15 minutes ago',
    ),
  };
}
