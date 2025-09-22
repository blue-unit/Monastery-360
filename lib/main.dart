import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

// Data model for the cards in the Ticket section
class _MonasteryCardData {
  final String name;
  final String subtitle;
  final String imagePath;
  final String offersText;
  const _MonasteryCardData({
    required this.name,
    required this.subtitle,
    required this.imagePath,
    required this.offersText,
  });
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  String _selectedFilter = "All";
  int _profileTabIndex = 0; // State for the profile page tabse tabs

  // Data for the Home Page
  final List<Map<String, dynamic>> monasteries = [
    {
      "name": "Rumtek Monastery",
      "shortDescription":
          "One of the most important monasteries in Sikkim, seat of the Kagyu sect. Built in 16th century, reconstructed in 1960s. Features stunning architecture, murals, and artifacts.",
      "fullDescription":
          "Rumtek Monastery, also known as the Dharma Chakra Centre, is one of the most important and largest monasteries in Sikkim. Located about 23 kilometers from Gangtok, it was originally built in the 16th century by the 9th Karmapa and later reconstructed in the 1960s under the guidance of the 16th Karmapa. The monastery serves as the main seat of the Kagyu sect of Tibetan Buddhism outside Tibet and is renowned for its stunning architecture, intricate murals, and collection of rare Buddhist artifacts, scriptures, and statues. Surrounded by lush green hills, Rumtek offers a serene spiritual atmosphere and a panoramic view of the surrounding valleys, making it not only a significant religious center but also a popular tourist destination.",
      "image": "assets/rumtek.jpg",
      "categories": ["UNESCO", "Popular"],
    },
    {
      "name": "Pemayangtse Monastery",
      "shortDescription":
          "Founded in 1705, oldest in Sikkim. Nyingma sect, famous for wall paintings and Sangtok Palri model. Breathtaking Kanchenjunga views.",
      "fullDescription":
          "Pemayangtse Monastery, founded in 1705 by Lama Lhatsun Chenpo, is one of the oldest and most prestigious monasteries in Sikkim. Located near Pelling, it belongs to the Nyingma sect of Tibetan Buddhism and holds great spiritual importance. The name Pemayangtse means “Perfect Sublime Lotus,” reflecting its role as a center of pure and advanced Buddhist learning. The monastery is famous for its exquisite wall paintings, ancient sculptures, and a unique wooden structure called Sangtok Palri, a seven-tiered model of Guru Rinpoche’s celestial palace, crafted entirely by hand. Surrounded by breathtaking views of the Kanchenjunga range, Pemayangtse is not only a religious treasure but also a place of immense cultural and historical value in Sikkim.",
      "image": "assets/pemayangtse.jpg",
      "categories": ["Oldest", "Popular"],
    },
    {
      "name": "Enchey Monastery",
      "shortDescription":
          "Established in 1909, Nyingma sect. Known for Cham festival with masked dances. Serene hilltop setting overlooking Gangtok.",
      "fullDescription":
          "Enchey Monastery, located on a hilltop overlooking Gangtok, was established in 1909 during the reign of Chogyal Sidkeong Tulku. Belonging to the Nyingma sect of Tibetan Buddhism, it is closely associated with the tantric master Lama Druptob Karpo, who was believed to have possessed the power of flying. The monastery’s name, meaning “Solitary Monastery,” reflects its serene and secluded setting, surrounded by lush forests and mountains. Enchey is renowned for its vibrant annual Cham festival, where monks perform masked dances to drive away evil spirits and bring blessings to the land. With its striking traditional architecture and deep spiritual significance, Enchey Monastery is both a sacred site for devotees and a cultural attraction for visitors exploring Sikkim’s rich heritage.",
      "image": "assets/enchey.jpg",
      "categories": ["Near you", "Oldest", "Popular"],
    },
    {
      "name": "Phensang Monastery",
      "shortDescription":
          "Founded in 1721, home to over 300 monks. Annual festival with mask dances. Rebuilt after 1947 fire, panoramic valley views.",
      "fullDescription":
          "Phensang Monastery, founded in 1721 during the reign of Jigme Pawo, the third Lhatsun Chenpo, is one of the largest monasteries in Sikkim. Situated on a gentle slope north of Gangtok, it follows the Nyingma tradition of Tibetan Buddhism and is home to over 300 monks. The monastery is particularly well known for its annual festival held just before the Tibetan New Year (Losar), where sacred mask dances and rituals are performed to ward off negativity and invite peace and prosperity. Though it suffered major damage from a fire in 1947, Phensang was rebuilt and continues to stand as an important spiritual and cultural hub. Its serene setting, coupled with panoramic views of the surrounding valleys, makes it a significant destination for both devotees and visitors.",
      "image": "assets/phensang.jpg",
      "categories": ["Oldest", "Popular"],
    },
  ];

  // Data for the Explore Page
  final List<Map<String, dynamic>> nearbyMonasteries = [
    {
      "name": "Rumtek Monastery",
      "description": "Seat of the Karmapa · Most important Kagyu monastery",
      "distance": "2.3 km",
      "founded": "Founded in 1966",
      "entryFee": "₹20",
      "rating": 4.8,
      "features": [
        "15 min by car",
        "Bus available",
        "Photo spots",
        "Audio guide",
      ],
      "image": "assets/rumtek.jpg",
    },
    {
      "name": "Enchey Monastery",
      "description": "Above Gangtok · Nyingma tradition · Mountain views",
      "distance": "2.1 km",
      "founded": "Founded in 1909",
      "entryFee": "Free entry",
      "rating": 4.6,
      "features": [
        "12 min by car",
        "Walking trail",
        "City views",
        "Dance festivals",
      ],
      "image": "assets/enchey.jpg",
    },
    {
      "name": "Tashiding Monastery",
      "description": "Heart of Sikkim · Sacred Bhumchu ceremony",
      "distance": "18.5 km",
      "founded": "Founded in 1641",
      "entryFee": "₹10",
      "rating": 4.7,
      "features": ["Shared taxi", "Annual festival"],
      "image": "assets/tashiding.jpg",
    },
    {
      "name": "Phensang Monastery",
      "description": "Located in Sikkim · Known for annual religious festival",
      "distance": "15 km",
      "founded": "Founded in 1721",
      "entryFee": "Free entry",
      "rating": 4.5,
      "features": [
        "Car accessible",
        "Festival celebrations",
        "Peaceful surroundings",
      ],
      "image": "assets/phensang.jpg",
    },
    {
      "name": "Kartok Monastery",
      "description": "Yuksom · Historic Kagyu monastery",
      "distance": "21.2 km",
      "founded": "Founded in 1840s",
      "entryFee": "Free entry",
      "rating": 4.4,
      "features": ["Car accessible", "Historic site", "Scenic views"],
      "image": "assets/kartok.jpg",
    },
    {
      "name": "Siren Ngadak Monastery",
      "description": "Namchi · Old Buddhist monastery",
      "distance": "19 km",
      "founded": "Founded in 17th century",
      "entryFee": "Free entry",
      "rating": 4.3,
      "features": ["Car accessible", "Historic ruins", "Quiet location"],
      "image": "assets/Siren Ngadak.jpg",
    },
    {
      "name": "Gonjang Monastery",
      "description": "Near Tashi View Point · Preserves Buddhist culture",
      "distance": "8 km",
      "founded": "Founded in 1981",
      "entryFee": "Free entry",
      "rating": 4.6,
      "features": ["Car accessible", "Cultural center", "Peaceful ambience"],
      "image": "assets/gonjang.jpg",
    },
    {
      "name": "HEE GYATHANG Monastery",
      "description": "Dzongu · Lepcha heritage site",
      "distance": "16.8 km",
      "founded": "Ancient site",
      "entryFee": "Free entry",
      "rating": 4.2,
      "features": [
        "Car accessible",
        "Traditional architecture",
        "Local cultural importance",
      ],
      "image": "assets/hee gyathang.jpg",
    },
    {
      "name": "Doling Monastery",
      "description": "Ravangla · Buddhist monastery",
      "distance": "14.5 km",
      "founded": "Unknown",
      "entryFee": "Free entry",
      "rating": 4.3,
      "features": ["Car accessible", "Serene environment", "Mountain backdrop"],
      "image": "assets/doling.jpg",
    },
    {
      "name": "Chawayang Ani Monastery",
      "description": "Female monks’ monastery · Scenic location",
      "distance": "20 km",
      "founded": "Unknown",
      "entryFee": "Free entry",
      "rating": 4.4,
      "features": ["Car accessible", "Run by nuns", "Peaceful setting"],
      "image": "assets/chawayng.jpg",
    },
    {
      "name": "Ngadak Thupten Shedrup Dhargeyling Monastery",
      "description": "Namchi · Modern rebuilt monastery",
      "distance": "17.3 km",
      "founded": "Originally 17th century",
      "entryFee": "Free entry",
      "rating": 4.5,
      "features": [
        "Car accessible",
        "Historic + rebuilt",
        "Popular attraction",
      ],
      "image": "assets/ngadak.jpg",
    },
    {
      "name": "Tendong Gumpa",
      "description": "On Tendong Hill · Historic monastery",
      "distance": "9 km (Trek)",
      "founded": "Ancient site",
      "entryFee": "Free entry",
      "rating": 4.2,
      "features": ["Trekking trail", "Nature views", "Remote location"],
      "image": "assets/tandong Gumpa.jpg",
    },
  ];

  // Data for the horizontally scrolling cards in the Ticket section
  final List<_MonasteryCardData> popularMonasteries = const [
    _MonasteryCardData(
      name: 'Rumtek Monastery',
      subtitle: 'Seat of Karmapa • Kagyu',
      imagePath: 'assets/rumtek.jpg',
      offersText: 'Guided tours available',
    ),
    _MonasteryCardData(
      name: 'Enchey Monastery',
      subtitle: 'Above Gangtok • Nyingma',
      imagePath: 'assets/enchey.jpg',
      offersText: 'City views • Easy access',
    ),
    _MonasteryCardData(
      name: 'Tashiding Monastery',
      subtitle: 'Bhumchu ceremony',
      imagePath: 'assets/tashiding.jpg',
      offersText: 'Rich in history',
    ),
    _MonasteryCardData(
      name: 'Phensang Monastery',
      subtitle: 'Annual religious festival',
      imagePath: 'assets/phensang.jpg',
      offersText: 'Peaceful surroundings',
    ),
  ];

  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      _buildHomeSearchBar(),
      _buildExplorePage(),
      _buildTicketBookingScreen(),
      _buildProfilePage(),
    ];
  }

  // WIDGET for Home Page
  Widget _buildHomeSearchBar() {
    List<Map<String, dynamic>> filteredMonasteries = _selectedFilter == "All"
        ? monasteries
        : monasteries
              .where((m) => m["categories"].contains(_selectedFilter))
              .toList();

    final homeMonasteries = filteredMonasteries.length > 4
        ? filteredMonasteries.sublist(0, 4)
        : filteredMonasteries;

    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search Bar
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey[700]!, width: 1),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Icon(
                          Icons.search,
                          color: Colors.white70,
                          size: 22,
                        ),
                      ),
                      const Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Search Monasteries, places...",
                            hintStyle: TextStyle(
                              color: Colors.white54,
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(Icons.mic, color: Colors.white54, size: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Navigation Image
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[700]!, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(30),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/navigation.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Filter Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildFilterItem("Near you"),
                    _buildFilterItem("UNESCO"),
                    _buildFilterItem("Oldest"),
                    _buildFilterItem("Popular"),
                  ],
                ),
                const SizedBox(height: 24),

                // Monasteries Section Title
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Monasteries',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Horizontal list for filtered monasteries (only first 4)
                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: homeMonasteries
                        .map(
                          (m) => _buildCard(
                            m["name"],
                            m["shortDescription"],
                            m["image"],
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 24),

                // Digital Archives Section
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Digital Archives',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildArchiveCard(
                        'Lepcha works',
                        'There are other Lepcha works that are subsidiary to the Tashe sung, and in a sense all these texts form part of a large epos about Lord Tashe\'s life and work. For example, the work Rum pundi sá námthár [The Legend of the Goddess Queen] describes how Lord Tashe is struck by the troubles and suffering of human beings on earth, and how he sends his wife to earth to fight the bad influences that prevail there.27 She tries to lead three wicked kings to a righteous and more religious path by taking birth as one of the king\'s daughters. Since her suffering is so great, Lord Tashe himself takes birth as one of the king\'s sons, and ultimately succeeds in fighting evil.',
                        'assets/lepcha1.jpg',
                        Icons.book,
                      ),
                      _buildArchiveCard(
                        'The Legend of Cenrejú',
                        'Another example of a popular work attested in manuscripts we digitised, Cenrejú sá námthár [The Legend of Cenrejú], is based on the legend of Cenrejú, the Boddhisattva of compassion (Tibetan Spyan-ras-gzigs, Sanskrit Avalokiteśvara) (Fig. 3.4).32 Cenrejú tries to liberate all living beings from all kinds of suffering, but eventually has to accept that his goal cannot be reached without help. He despairs and consequently his head splits into many pieces. The Buddha (Amitābha) puts his body back together and creates a body with many different arms and heads, which will enable Cenrejú to fight many different kinds of suffering all at the same time. Cenrejú is sometimes portrayed with a thousand arms and eleven heads, and is then called Ekádoshi.',
                        'assets/cenreju.jpg',
                        Icons.description,
                      ),
                      _buildArchiveCard(
                        'The Legend of Goddess Queen',
                        'There are other Lepcha works that are subsidiary to the Tashe sung, and in a sense all these texts form part of a large epos about Lord Tashe\'s life and work. For example, the work Rum pundi sá námthár [The Legend of the Goddess Queen] describes how Lord Tashe is struck by the troubles and suffering of human beings on earth, and how he sends his wife to earth to fight the bad influences that prevail there.27 She tries to lead three wicked kings to a righteous and more religious path by taking birth as one of the king\'s daughters. Since her suffering is so great, Lord Tashe himself takes birth as one of the king\'s sons, and ultimately succeeds in fighting evil.',
                        'assets/queen.jpg',
                        Icons.museum,
                      ),
                      _buildArchiveCard(
                        'Ritual Thumbprint',
                        'Lepcha astrological texts, sometimes simply referred to as tsu (astrology; Tibetan rTsis)42 have not yet been studied at all, and it has not yet been possible to identify many of the digitised material (Figs. 3.6, 3.7, 3.8 and 3.10). There appear to be clear links between Lepcha astrology and traditional Tibetan astrological traditions, for example the text Parkhó sá tsu [Parkhó Calculations] (Fig. 3.9) appears to relate directly to the Tibetan tradition of geomantic diagrams, described in sPar-kha-hi rTsis.43 One of the astrological works in Lepcha that is often encountered in manuscript form is called in full khyenrúng díngngá sá tsu kyân sá cho, but is often referred to simply as tsu kyân sá cho [Book of Astrology].44 It is thought that this book consists of several volumes relating to birth, journeys and marriage, some of which have been found copied independently, e.g. ʔágek ʔálát sá tsu (birth horoscopes) and brí sá tsu (marriage horoscopes).45',
                        'assets/thumbprint.jpg',
                        Icons.auto_stories,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Narrated Walkthroughs Section
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Narrated Walkthroughs',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildVideoCard(
                        'Sikkim Heritage Tour',
                        'A small guided tour of  Sikkim\'s monastery',
                        'assets/rumtek.jpg',
                        '0:59',
                        'assets/sikkim.mp4',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper for Digital Archives cards
  Widget _buildArchiveCard(
    String title,
    String description,
    String imagePath,
    IconData icon,
  ) {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  width: 350,
                  height: 600,
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      ListView(
                        padding: const EdgeInsets.all(16),
                        physics: const BouncingScrollPhysics(),
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              children: [
                                Image.asset(
                                  imagePath,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      icon,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            description,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 80),
                        ],
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 18,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Builder(
                          builder: (context) {
                            return ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Reading $title')),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: const Text('Read More'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Container(
          width: 200,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[700]!, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(30),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Stack(
                  children: [
                    Image.asset(
                      imagePath,
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(icon, color: Colors.white, size: 18),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper for Narrated Walkthroughs video cards
  Widget _buildVideoCard(
    String title,
    String description,
    String imagePath,
    String duration,
    String videoPath,
  ) {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () {
          _showVideoPlayer(context, title, videoPath);
        },
        child: Container(
          width: 200,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[700]!, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(30),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Stack(
                  children: [
                    Image.asset(
                      imagePath,
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          duration,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Video Player Dialog
  void _showVideoPlayer(BuildContext context, String title, String videoPath) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return VideoPlayerDialog(title: title, videoPath: videoPath);
      },
    );
  }

  // WIDGET for Explore Page
  Widget _buildExplorePage() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _buildCalendarHeader(imagePath: 'assets/calendar.jpg'),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 8)),
        SliverList.builder(
          itemCount: nearbyMonasteries.length,
          itemBuilder: (context, index) {
            final monastery = nearbyMonasteries[index];
            return _buildMonasteryCard(monastery);
          },
        ),
      ],
    );
  }

  // Helper for the Calendar banner on Explore Page
  Widget _buildCalendarHeader({required String imagePath}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(imagePath, fit: BoxFit.cover),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Row(
                  children: [
                    const Text(
                      'Cultural Calendar',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    Builder(
                      builder: (context) {
                        return OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white70),
                            backgroundColor: Colors.black.withOpacity(0.3),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Viewing Cultural Events...'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.calendar_month, size: 18),
                          label: const Text('Events'),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper for the detailed cards on Explore Page
  Widget _buildMonasteryCard(Map<String, dynamic> monastery) {
    final List<String> features = List<String>.from(
      monastery['features'] ?? [],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[700]!, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(30),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.asset(
                monastery['image'],
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          monastery['name'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          monastery['distance'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "${monastery['description']}\n${monastery['founded']}",
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: features
                        .map(
                          (f) => Chip(
                            label: Text(
                              f,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            backgroundColor: Colors.grey[700],
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  Divider(color: Colors.grey[700]),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Entry: ${monastery['entryFee']}",
                        style: TextStyle(color: Colors.white70),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            monastery['rating'].toString(),
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // WIDGET for Filter Buttons on Home Page
  Widget _buildFilterItem(String text) {
    bool isSelected = _selectedFilter == text;
    return GestureDetector(
      onTap: () => setState(() {
        _selectedFilter = text;
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[600] : Colors.grey[850],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.grey[500]! : Colors.grey[700]!,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: isSelected ? Colors.white : Colors.white70,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // WIDGET for Cards on Home Page
  Widget _buildCard(String title, String shortDescription, String imagePath) {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () {
          final monastery = monasteries.firstWhere((m) => m['name'] == title);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  width: 350,
                  height: 600,
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      ListView(
                        padding: const EdgeInsets.all(16),
                        physics: const BouncingScrollPhysics(),
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              imagePath,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            monastery['fullDescription'],
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 80),
                        ],
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 18,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Builder(
                          builder: (context) {
                            return ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Visiting $title')),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: const Text('Visit'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Container(
          width: 200,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[700]!, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(30),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.asset(
                  imagePath,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      shortDescription,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // WIDGET for Ticket Booking Page
  Widget _buildTicketBookingScreen() {
    return Container(
      color: Colors.black, // Matching the app's background
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Namaste!',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Plan your monastery tour',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              height: 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Using a generic icon instead of an avatar image
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: Colors.grey[800],
                      child: const Icon(
                        Icons.person,
                        color: Colors.white70,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // **MODIFIED**: Search bar is now a TextField
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey[700]!),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.white70),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Search monasteries, events...',
                            hintStyle: TextStyle(color: Colors.white70),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.tune_rounded,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // **MODIFIED**: Quick actions are now a scrollable list
            SliverToBoxAdapter(
              child: SizedBox(
                height: 110, // Give the list a fixed height
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  children: const [
                    _QuickActionTile(
                      icon: Icons.temple_buddhist,
                      label: 'Monasteries',
                    ),
                    SizedBox(width: 20),
                    _QuickActionTile(
                      icon: Icons.terrain_rounded,
                      label: 'Trails',
                    ),
                    SizedBox(width: 20),
                    _QuickActionTile(
                      icon: Icons.directions_car_filled_rounded,
                      label: 'Rides',
                    ),
                    SizedBox(width: 20),
                    _QuickActionTile(icon: Icons.event, label: 'Festivals'),
                    SizedBox(width: 20),
                    _QuickActionTile(
                      icon: Icons.hotel, // New icon
                      label: 'Stays', // New label
                    ),
                  ],
                ),
              ),
            ),

            // Main content section
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  children: [
                    // Section header
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Popular monasteries',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'View All',
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // **FIXED**: Horizontal cards container height increased
                    SizedBox(
                      height: 300, // Increased from 280 to 300
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
                        scrollDirection: Axis.horizontal,
                        itemCount: popularMonasteries.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final m = popularMonasteries[index];
                          return _TicketMonasteryCard(data: m);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // WIDGET for Profile Page
  Widget _buildProfilePage() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section with Profile Info
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    // Profile Picture
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey[600]!, width: 2),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // User Name
                    const Text(
                      'Himansh',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // User Email/Status
                    Text(
                      'himansh@monastery360.com',
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    const SizedBox(height: 16),
                    // Edit Profile Button
                    ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Edit Profile Coming Soon'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      icon: const Icon(Icons.edit, size: 18),
                      label: const Text('Edit Profile'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Profile Menu Items
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // My Activity Section
                    _buildSectionHeader('My Activity'),
                    _buildProfileMenuItem(
                      Icons.bookmark_border,
                      'My Bookings',
                      'View your monastery bookings',
                      () => _toast(context, 'My Bookings'),
                    ),
                    _buildProfileMenuItem(
                      Icons.rate_review_outlined,
                      'My Reviews',
                      'Reviews you\'ve written',
                      () => _toast(context, 'My Reviews'),
                    ),
                    _buildProfileMenuItem(
                      Icons.favorite_border,
                      'Saved Monasteries',
                      'Your favorite places',
                      () => _toast(context, 'Saved Monasteries'),
                    ),
                    _buildProfileMenuItem(
                      Icons.history,
                      'Visit History',
                      'Places you\'ve visited',
                      () => _toast(context, 'Visit History'),
                    ),

                    const SizedBox(height: 24),

                    // Settings Section
                    _buildSectionHeader('Settings'),
                    _buildProfileMenuItem(
                      Icons.notifications_outlined,
                      'Notifications',
                      'Manage your alerts',
                      () => _toast(context, 'Notifications Settings'),
                    ),
                    _buildProfileMenuItem(
                      Icons.language_outlined,
                      'Language',
                      'Change app language',
                      () => _toast(context, 'Language Settings'),
                    ),
                    _buildProfileMenuItem(
                      Icons.dark_mode_outlined,
                      'Theme',
                      'App appearance',
                      () => _toast(context, 'Theme Settings'),
                    ),

                    const SizedBox(height: 24),

                    // Support Section
                    _buildSectionHeader('Support'),
                    _buildProfileMenuItem(
                      Icons.help_outline,
                      'Help & Support',
                      'Get help with the app',
                      () => _toast(context, 'Help & Support'),
                    ),
                    _buildProfileMenuItem(
                      Icons.feedback_outlined,
                      'Send Feedback',
                      'Share your thoughts',
                      () => _toast(context, 'Send Feedback'),
                    ),
                    _buildProfileMenuItem(
                      Icons.info_outline,
                      'About',
                      'App version and info',
                      () => _toast(context, 'About Monastery 360'),
                    ),
                    _buildProfileMenuItem(
                      Icons.privacy_tip_outlined,
                      'Privacy Policy',
                      'How we protect your data',
                      () => _toast(context, 'Privacy Policy'),
                    ),

                    const SizedBox(height: 32),

                    // Logout Button
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[700]!),
                      ),
                      child: TextButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Logout functionality'),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red[400],
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        icon: const Icon(Icons.logout, size: 20),
                        label: const Text(
                          'Sign Out',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper for section headers in profile
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 8),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Helper for profile menu items
  Widget _buildProfileMenuItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[700]!),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white70, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.white60, fontSize: 13),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.white54, size: 20),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  void _toast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.black,
            drawer: Drawer(
              backgroundColor: Colors.grey[900],
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 66, 66, 66),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.temple_buddhist,
                          size: 40,
                          color: Colors.white,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Monastery 360',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Text(
                          'Sacred Heritage Guide',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.map_outlined,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Offline Map',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.archive, color: Colors.white),
                    title: const Text(
                      'Digital Archive',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.explore_outlined,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Interactive Maps',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.assistant_navigation,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Smart Guides',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.directions, color: Colors.white),
                    title: const Text(
                      'Travel Routes',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.camera_alt, color: Colors.white),
                    title: const Text(
                      'Photo Gallery',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.group_add, color: Colors.white),
                    title: const Text(
                      'Join Us',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      _showJoinUsDialog(context);
                    },
                  ),
                  const Divider(color: Colors.grey),
                  ListTile(
                    leading: const Icon(
                      Icons.info_outline,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'About Us',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              title: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Monastery 360",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    "Discover Sacred Heritage Sites of Sikkim",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              centerTitle: true,
              backgroundColor: Colors.grey[900],
            ),
            body: Stack(
              children: [
                _pages[_selectedIndex],
                if (_selectedIndex == 0)
                  Positioned(
                    bottom: 15,
                    right: 15,
                    child: FloatingActionButton(
                      onPressed: () {
                        _showChatbotDialog(context);
                      },
                      backgroundColor: Colors.teal,
                      tooltip: 'Chatbot',
                      child: const Icon(Icons.chat, color: Colors.white),
                    ),
                  ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              onTap: (i) => setState(() => _selectedIndex = i),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white70,
              backgroundColor: Colors.grey[900],
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.explore),
                  label: 'Explore',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.airplane_ticket),
                  label: 'Ticket',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // DIALOG for Join Us
  void _showJoinUsDialog(BuildContext context) {
    // ... code for join us dialog remains unchanged
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: 350,
            height: 600,
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.all(20),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const Icon(
                      Icons.temple_buddhist,
                      size: 60,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Join Our Community',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'To join us, you must be a volunteer or a staff member of a monastery. Your role will be to support the preservation and promotion of Sikkim\'s heritage by sharing authentic information, historical documents, manuscripts, and other valuable resources. Together, we aim to build a digital archive that safeguards this legacy and makes it accessible to the world.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Enter your full name",
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.grey[700],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Enter your email address",
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.grey[700],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Monastery/Organization name",
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.grey[700],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Your role (volunteer/staff member)",
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.grey[700],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () => Navigator.of(dialogContext).pop(),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Thank you for your interest! We will contact you soon.',
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Join Us'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // DIALOG for the Chatbot
  void _showChatbotDialog(BuildContext context) {
    // ... code for chatbot dialog remains unchanged
    final TextEditingController _controller = TextEditingController();
    final List<String> _messages = ["Welcome to Monastery 360 Chat bot."];

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.grey[900],
              child: Container(
                width: 350,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Monastery 360 Chatbot",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white70,
                              size: 20,
                            ),
                            onPressed: () => Navigator.of(dialogContext).pop(),
                          ),
                        ],
                      ),
                    ),
                    // Message List
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          bool isUserMessage = index % 2 != 0;
                          return Align(
                            alignment: isUserMessage
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isUserMessage
                                    ? Colors.teal
                                    : Colors.grey[800],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                _messages[index],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Input Field
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: "Type a message...",
                                hintStyle: const TextStyle(
                                  color: Colors.white54,
                                ),
                                filled: true,
                                fillColor: Colors.grey[800],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.send, color: Colors.teal),
                            onPressed: () {
                              if (_controller.text.isNotEmpty) {
                                setState(() {
                                  _messages.add(_controller.text);
                                  // You can add a dummy bot response here
                                  // _messages.add("This is a dummy response.");
                                });
                                _controller.clear();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// **** HELPER WIDGETS FOR THE TICKET PAGE ****

class _QuickActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  const _QuickActionTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey[850], // Dark theme color
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[700]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white70, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

class _TicketMonasteryCard extends StatelessWidget {
  final _MonasteryCardData data;
  const _TicketMonasteryCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.grey[850], // Dark theme color
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.grey[700]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  Image.asset(
                    data.imagePath,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.bookmark_border,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              data.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              data.subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              data.offersText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white60,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Spacer(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// Video Player Dialog Widget
class VideoPlayerDialog extends StatefulWidget {
  final String title;
  final String videoPath;

  const VideoPlayerDialog({
    Key? key,
    required this.title,
    required this.videoPath,
  }) : super(key: key);

  @override
  State<VideoPlayerDialog> createState() => _VideoPlayerDialogState();
}

class _VideoPlayerDialogState extends State<VideoPlayerDialog> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() async {
    _controller = VideoPlayerController.asset(widget.videoPath);
    try {
      await _controller.initialize();
      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      print('Error initializing video: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            // Video Player
            Expanded(
              child: Container(
                color: Colors.black,
                child: _isInitialized
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          ),
                          // Play/Pause overlay
                          if (!_isPlaying)
                            GestureDetector(
                              onTap: _togglePlayPause,
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            ),
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator(color: Colors.teal),
                      ),
              ),
            ),
            // Controls
            if (_isInitialized)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  children: [
                    // Progress bar
                    VideoProgressIndicator(
                      _controller,
                      allowScrubbing: true,
                      colors: const VideoProgressColors(
                        playedColor: Colors.teal,
                        bufferedColor: Colors.grey,
                        backgroundColor: Colors.white24,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Control buttons and time
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(_controller.value.position),
                          style: const TextStyle(color: Colors.white),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                _isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                              ),
                              onPressed: _togglePlayPause,
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.fullscreen,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // You can implement fullscreen functionality here
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Fullscreen mode'),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Text(
                          _formatDuration(_controller.value.duration),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
