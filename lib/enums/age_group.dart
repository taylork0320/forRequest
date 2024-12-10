enum AgeGroup {
  under19('19세 이하'),
  twenties('20대'),
  thirties('30대'),
  forties('40대'),
  fifties('50대'),
  sixties('60대'),
  overSixtyFive('65세 이상');

  final String label;
  const AgeGroup(this.label);
}