class Home {
  String title;
  String? category;
  List<String> listCategory;

  Home(this.title, {this.listCategory = const [], this.category});

  @override
  String toString() {
    return 'title: $title, list: $listCategory';
  }
}
