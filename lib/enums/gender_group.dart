enum GenderGroup {
  regardless('성별 무관'),
  male('남성'),
  female('여성');

  final String label;
  const GenderGroup(this.label);

  static List<String> getGenderTagList() {
    return GenderGroup.values.map((gender) => gender.label).toList();
  }
}