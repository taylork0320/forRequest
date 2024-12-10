enum TypeGroup {
  solo('성별무관'),
  withFriends('친구랑'),
  organization('단체'),
  ;

  final String label;

  const TypeGroup(this.label);
}
