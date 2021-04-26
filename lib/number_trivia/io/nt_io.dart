import 'package:z_/number_trivia/api/nt.dart' show NumberTrivia;
import 'package:meta/meta.dart' show required;

class NumberTriviaIn extends NumberTrivia {
  NumberTriviaIn({
    @required String text,
    @required int number,
  }) : super(text: text, number: number);

  factory NumberTriviaIn.fromJson(Map<String, dynamic> json) {
    return NumberTriviaIn(
      text: json['text'],
      number: (json['number'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'number': number,
    };
  }
}
