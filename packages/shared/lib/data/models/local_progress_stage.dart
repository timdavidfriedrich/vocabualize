enum LocalProgressStage {
  waiting("waiting"),
  shortTerm("shortTerm"),
  longTerm("longTerm");

  const LocalProgressStage(this.value);

  final String value;
}

final startedProgressStages = {LocalProgressStage.shortTerm.value, LocalProgressStage.longTerm.value};
