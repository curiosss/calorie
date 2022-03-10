class MealsListData {
  MealsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.meals,
    this.kcal = 0,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String> meals;
  int kcal;

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'assets/fitness_app/breakfast.png',
      titleTxt: 'Ertirlik',
      kcal: 525,
      meals: <String>[
        'Mesge biolen yaglyja corek',
        'Çörek',
        'Alma',
        'Salad',
        'Garpyz',
        'Mesge',
        'Çörek',
        'Alma',
        'Salad',
        'Garpyz'
      ],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/lunch.png',
      titleTxt: 'Günortan',
      kcal: 602,
      meals: <String>['Salad,', 'Çorba,', 'Awokado'],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/snack.png',
      titleTxt: 'Garbanyş',
      kcal: 0,
      meals: <String>['Norma:', '800 kcal'],
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      titleTxt: 'Agşamlyk',
      kcal: 0,
      meals: <String>['Norma:', '703 kcal'],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}
