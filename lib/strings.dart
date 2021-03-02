class Strings {
  static const ChooseResellerStrings chooseResellerStrings = ChooseResellerStrings();
}

class ChooseResellerStrings {
  const ChooseResellerStrings();

  String get title => 'Escolha uma Revenda';

  String get gasLocation => 'Botijões de 13kg em:';

  String get mostHighRating => 'Melhor Avaliação';

  String get mostFast => 'Mais rápido';

  String get mostCheap => 'Mais barato';

  String get changeAddress => 'Mudar';

  String get rating => 'Nota';

  String get averageTimeLabel => 'Tempo Médio';

  String averageTimeValue(int min, int max) => '$min-$max min';

  String get price => 'Preço';
}
