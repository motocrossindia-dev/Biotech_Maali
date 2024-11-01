import 'package:biotech_maali/import.dart';

class ExploreProvider extends ChangeNotifier {
  final Map<String, Map<String, dynamic>> categories = {
    "plants": {
      "api": 'https://bitechmali/category/plants',
      "items": [
        {
          'image':
              'https://i.pinimg.com/564x/62/db/7b/62db7b0f2ac03bbf8a9b66722754d71e.jpg',
          'name': 'Fern',
          'api': 'https://bitechmali/item/fern'
        },
        {
          'image':
              'https://i.pinimg.com/736x/0c/f6/99/0cf69986eb27801c2f893fa6128808a3.jpg',
          'name': 'Succulent',
          'api': 'https://bitechmali/item/succulent'
        },
        {
          'image':
              'https://i.pinimg.com/564x/62/db/7b/62db7b0f2ac03bbf8a9b66722754d71e.jpg',
          'name': 'Fern',
          'api': 'https://bitechmali/item/fern'
        },
        {
          'image':
              'https://i.pinimg.com/736x/0c/f6/99/0cf69986eb27801c2f893fa6128808a3.jpg',
          'name': 'Succulent',
          'api': 'https://bitechmali/item/succulent'
        },
        {
          'image':
              'https://i.pinimg.com/564x/62/db/7b/62db7b0f2ac03bbf8a9b66722754d71e.jpg',
          'name': 'Fern',
          'api': 'https://bitechmali/item/fern'
        },
        {
          'image':
              'https://i.pinimg.com/736x/0c/f6/99/0cf69986eb27801c2f893fa6128808a3.jpg',
          'name': 'Succulent',
          'api': 'https://bitechmali/item/succulent'
        }
      ]
    },
    "plantCare": {
      "api": 'https://bitechmali/category/plantCare',
      "items": [
        {
          'image':
              'https://i.pinimg.com/564x/8b/6c/49/8b6c4933f3ad4afaac4945c1846db578.jpg',
          'name': 'Self-Watering Pot',
          'api': 'https://bitechmali/item/self-watering-pot'
        },
        {
          'image':
              'https://i.pinimg.com/736x/b7/52/9d/b7529de74ea95e662ee45789f653728a.jpg',
          'name': 'Pruning Shears',
          'api': 'https://bitechmali/item/pruning-shears'
        },
        {
          'image':
              'https://i.pinimg.com/564x/a0/f4/fb/a0f4fbf5171616edae192d6aa94c6ecf.jpg',
          'name': 'Fertilizer Pack',
          'api': 'https://bitechmali/item/fertilizer-pack'
        },
        {
          'image':
              'https://i.pinimg.com/564x/19/ae/4e/19ae4eb80a779032bce30d8bb04db0bb.jpg',
          'name': 'Watering Can',
          'api': 'https://bitechmali/item/watering-can'
        }
      ]
    },
    "pots": {
      "api": 'https://bitechmali/category/pots',
      "items": [
        {
          'image':
              'https://i.pinimg.com/564x/2c/55/31/2c55318e878270f4a5bc6fd47950d795.jpg',
          'name': 'Ceramic Pot',
          'api': 'https://bitechmali/item/ceramic-pot'
        },
        {
          'image':
              'https://i.pinimg.com/564x/ce/77/c7/ce77c739cc284cc784157ab6ea39a58b.jpg',
          'name': 'Terracotta Pot',
          'api': 'https://bitechmali/item/terracotta-pot'
        },
         {
          'image':
              'https://i.pinimg.com/564x/40/99/b7/4099b71ab24e3bda0a5e7bf976471a6f.jpg',
          'name': 'Stoneware Pot',
          'api': 'https://bitechmali/item/ceramic-pot'
        },
        {
          'image':
              'https://i.pinimg.com/564x/a3/f9/47/a3f947bf6a9025093cb525c3d35d7ea5.jpg',
          'name': 'Earthenware Pot',
          'api': 'https://bitechmali/item/terracotta-pot'
        }
      ]
    },
    "plantSeeds": {
      "api": 'https://bitechmali/category/plantSeeds',
      "items": [
       
        {
          'image':
              'https://i.pinimg.com/enabled/736x/ec/05/4a/ec054acc8881a43c8bd58d029fada3a9.jpg',
          'name': 'Flowering Plant Seeds',
          'api': 'https://bitechmali/item/chia-seeds'
        },
          
        {
          'image':
              'https://i.pinimg.com/564x/80/92/9d/80929d1bb8be1c3d0b7e5a18ade1a688.jpg',
          'name': 'Herb Seeds',
          'api': 'https://bitechmali/item/chia-seeds'
        },
        {
          'image':
              'https://i.pinimg.com/enabled/564x/fa/88/8a/fa888a85930c032f24aabe18af954879.jpg',
          'name': 'Fruit Seeds',
          'api': 'https://bitechmali/item/chia-seeds'
        },
        {
          'image':
              'https://i.pinimg.com/564x/db/59/ed/db59eda5bf60a2cbdc14bf6dd9986100.jpg',
          'name': 'Vegetable Seeds',
          'api': 'https://bitechmali/item/chia-seeds'
        },
         {
          'image':
              'https://i.pinimg.com/736x/eb/56/01/eb5601c8d8360fe784e2aa87403e2ce7.jpg',
          'name': 'Succulent Seeds',
          'api': 'https://bitechmali/item/chia-seeds'
        },
        
      ]
    },
    "gifts": {
      "api": 'https://bitechmali/category/gifts',
      "items": [
        {
          'image':
              'https://i.pinimg.com/enabled/564x/b4/c8/53/b4c8534f2d9e8c40ce13e25d06205ac0.jpg',
          'name': 'Gift Set - Plants',
          'api': 'https://bitechmali/item/gift-set-plants'
        },
        {
          'image':
              'https://i.pinimg.com/564x/1d/4f/7b/1d4f7b483fb9d346b9021fd329147163.jpg',
          'name': 'Gift Basket - Seeds',
          'api': 'https://bitechmali/item/gift-basket-seeds'
        },
        {
          'image':
              'https://i.pinimg.com/enabled/564x/b1/25/1d/b1251d890900d3ac463bc406671f41fd.jpg',
          'name': 'Herbal Bliss Gift Box',
          'api': 'https://bitechmali/item/gift-set-plants'
        },
        {
          'image':
              'https://i.pinimg.com/564x/69/a0/e0/69a0e0abb41e7b5778f92236beaf89f7.jpg',
          'name': 'Succulent Delight Gift Set',
          'api': 'https://bitechmali/item/gift-basket-seeds'
        }
      ]
    },
    "offers": {
      "api": 'https://bitechmali/category/offers',
      "items": [
        {
          'image': 'https://i.pinimg.com/564x/e4/e4/f9/e4e4f96e10f7f12692906eca83bac496.jpg',
          'name': 'Buy 1 Get 1 Free - Pots',
          'api': 'https://bitechmali/item/buy1get1-pots'
        },
        {
          'image':
              'https://i.pinimg.com/564x/04/dc/4f/04dc4ff4e0d357dd5146717e7477b2df.jpg',
          'name': '20% Off Plant Seeds',
          'api': 'https://bitechmali/item/20off-seeds'
        },
         {
          'image': 'https://i.pinimg.com/564x/af/74/9c/af749c13f78ab8c38a488e819de00265.jpg',
          'name': 'Buy 1 Get 1 Free - Pots',
          'api': 'https://bitechmali/item/buy1get1-pots'
        },
        {
          'image':
              'https://i.pinimg.com/564x/7a/2a/46/7a2a4663e4bfcc7e99be23029088c022.jpg',
          'name': '20% Off Plant Seeds',
          'api': 'https://bitechmali/item/20off-seeds'
        }
      ]
    }
  };

  int _selectedCategoryIndex = 0;
  int get selectedCategoryIndex => _selectedCategoryIndex;

  setSelectedIndex(int index) {
    _selectedCategoryIndex = index;
    notifyListeners();
  }
}
