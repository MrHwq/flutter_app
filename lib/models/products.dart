import 'package:english_words/english_words.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductsModel extends Model {
    Set<WordPair> _products = Set();

    get products => _products;

    void add(WordPair word) {
        _products.add(word);
        print("add ${word.asPascalCase}");
        notifyListeners();
    }

    void remove(WordPair word) {
        _products.remove(word);
        print("remove ${word.asPascalCase}");
        notifyListeners();
    }

    void clear() {
        _products.clear();
        notifyListeners();
    }
}