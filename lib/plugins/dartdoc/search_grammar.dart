import 'package:petitparser/petitparser.dart';

class Search {
  const Search({required this.package, required this.name, required this.kind});

  final String? package;
  final String name;
  final SearchKind kind;

  @override
  String toString() => 'Search(kind: $kind, package: $package, name: $name)';
}

enum SearchKind {
  elementLookup('!', true),
  elementSearch('?', true),
  packageLookup(r'$', false),
  packageSearch('&', false);

  const SearchKind(this.symbol, this.hasPackage);

  final bool hasPackage;
  final String symbol;
}

class SearchGrammar extends GrammarDefinition<List<Search>> {
  @override
  Parser<List<Search>> start() =>
      (ref1(search, true) | ref1(search, false) | any())
          .star()
          .map((matches) => matches.whereType<Search>().toList());

  Parser<Search> search(bool withPackage) => SequenceParser([
        // Search kind
        ref1(searchKind, withPackage),
        char('['),
        // Package prefix if available
        if (withPackage)
          SequenceParser([ref0(packageName), char('/')]).pick(0).optional(),

        // Package or element name
        // [withPackage] is false if the search itself is a package, so we only
        // allow package names here.
        if (withPackage) ref0(elementName) else ref0(packageName),
        char(']'),
      ]).map((value) => Search(
            kind: value[0]! as SearchKind,
            package: withPackage ? (value[2] as String?) ?? 'flutter' : null,
            name: (withPackage ? value[3] : value[2])! as String,
          ));

  Parser<String> packageName() =>
      ChoiceParser([letter(), digit(), char('_')]).plusString();

  Parser<String> elementName() => ChoiceParser([
        SequenceParser([char('['), ref0(elementName), char(']')]).flatten(),
        (char('[') | char(']')).neg(),
      ]).plusString();

  Parser<SearchKind> searchKind(bool withPackage) => ChoiceParser([
        for (final kind in SearchKind.values.where(
          (kind) => kind.hasPackage == withPackage,
        ))
          char(kind.symbol).map(
            (symbol) => SearchKind.values.singleWhere(
              (kind) => kind.symbol == symbol,
            ),
          )
      ]);
}
