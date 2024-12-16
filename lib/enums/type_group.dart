enum TypeGroup {
  solo('나홀로'),
  withFriends('친구랑'),
  organization('단체'),
  ;

  final String label;
  const TypeGroup(this.label);

  static List<String> getParticipantTypeTagList() {
    return TypeGroup.values.map((type) => type.label).toList();
  }
}