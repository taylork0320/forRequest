enum SubjectGroup {
  ai('인공지능'),
  realty('부동산'),
  politics('정치'),
  education('교육'),
  health('건강'),
  labor('직장/노동'),
  environment('환경'),
  mentality('심리'),
  socialMedia('소셜 미디어'),
  culture('문화'),
  technology('기술'),
  ethic('윤리'),
  emotion('감정'),
  ego('자아'),
  relationships('인간 관계'),
  consumption('소비'),
  society('사회'),
  socialBehavior('사회적 행동'),
  healthScience('보건'),
  happiness('행복'),
  ;

  final String label;
  const SubjectGroup(this.label);

  static List<String> getSubjectTagList() {
    return SubjectGroup.values.map((topic) => topic.label).toList();
  }
}