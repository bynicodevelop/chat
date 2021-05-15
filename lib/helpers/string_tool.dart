extension StringTool on String {
  String initial() {
    if (this.isEmpty) {
      return '';
    }

    List<String> words = this.split(' ');

    String initials = '';

    words.forEach((element) {
      initials += element.substring(0, 1).toUpperCase();
    });

    return initials;
  }

  String firstCapitalized() {
    if (this.isEmpty) {
      return '';
    }

    return '${this.substring(0, 1).toUpperCase()}${this.substring(1, this.length).toLowerCase()}';
  }
}
