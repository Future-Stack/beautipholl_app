class ProfileOrder {
  const ProfileOrder({
    required this.id,
    required this.placed,
    required this.status,
    required this.total,
  });

  final String id;
  final String placed;
  final String status;
  final double total;

  bool get inProgress => status == 'In Progress';
}

class HelpTopic {
  const HelpTopic({
    required this.id,
    required this.title,
    required this.icon,
    required this.searchHint,
    required this.faqs,
  });

  final String id;
  final String title;
  final String icon;
  final String searchHint;
  final List<HelpFaq> faqs;
}

class HelpFaq {
  const HelpFaq({required this.question, required this.answer});

  final String question;
  final String answer;
}

class ElitePerk {
  const ElitePerk({required this.icon, required this.label});

  final String icon;
  final String label;
}

class SavedAddress {
  const SavedAddress({
    required this.label,
    required this.name,
    required this.street,
    required this.apt,
    required this.city,
    required this.state,
    required this.zip,
  });

  final String label;
  final String name;
  final String street;
  final String apt;
  final String city;
  final String state;
  final String zip;

  String get streetLine => apt.isEmpty ? street : '$street, $apt';

  String get cityLine => '$city, $state $zip';

  String get chipLine {
    final short = street
        .replaceAll(RegExp(r'\bLane\b', caseSensitive: false), 'Ln')
        .replaceAll(RegExp(r'\bAvenue\b', caseSensitive: false), 'Ave')
        .replaceAll(RegExp(r'\bDrive\b', caseSensitive: false), 'Dr')
        .replaceAll(RegExp(r'\bStreet\b', caseSensitive: false), 'St');
    return '$short, $city, $state';
  }

  SavedAddress copyWith({
    String? label,
    String? name,
    String? street,
    String? apt,
    String? city,
    String? state,
    String? zip,
  }) {
    return SavedAddress(
      label: label ?? this.label,
      name: name ?? this.name,
      street: street ?? this.street,
      apt: apt ?? this.apt,
      city: city ?? this.city,
      state: state ?? this.state,
      zip: zip ?? this.zip,
    );
  }

  Map<String, dynamic> toJson() => {
        'label': label,
        'name': name,
        'street': street,
        'apt': apt,
        'city': city,
        'state': state,
        'zip': zip,
      };

  factory SavedAddress.fromJson(Map<String, dynamic> json) {
    return SavedAddress(
      label: json['label'] as String? ?? 'Shipping Address',
      name: json['name'] as String? ?? '',
      street: json['street'] as String? ?? '',
      apt: json['apt'] as String? ?? '',
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      zip: json['zip'] as String? ?? '',
    );
  }
}
