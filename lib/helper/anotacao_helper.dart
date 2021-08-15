import 'package:minhas_anotacoes_app/helper/model/anotacao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AnotacaoHelper {
  static final AnotacaoHelper _anotacaoHelper = AnotacaoHelper._internal();

  Database _db;

  factory AnotacaoHelper() {
    return _anotacaoHelper;
  }

  AnotacaoHelper._internal() {}

  get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await inicializarDb();
      return _db;
    }
  }

  _onCreate(Database db, int version) async {
    String sql =
        'CREATE TABLE anotacao (id INTEGER PRIMARY KEY AUTOINCREMENT, titulo VARCHAR, descicao TEXT, data DATETIME)';
    await db.execute(sql);
  }

  inicializarDb() async {
    final caminhoBancoDeDados = await getDatabasesPath();
    final localBancoDeDados =
        join(caminhoBancoDeDados, 'banco_minhas_anotacoes.db');

    var db =
        await openDatabase(localBancoDeDados, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<int> salvarAnotacao(Anotacao anotacao) async {
    var bancoDados = await db;
    int resultado = await bancoDados.insert("anotacao", anotacao.toMap());
    return resultado;
  }

  recuperarAnotacoes() async {
    var bancoDados = await db;
    String sql = 'SELECT * FROM anotacao ORDER BY data DESC';

    List anotacoes = await bancoDados.rawQuery(sql);

    return anotacoes;
  }

  Future<int> atualizarAnotacao(Anotacao anotacao) async {
    var bancoDados = await db;
    return await bancoDados.update("anotacao", anotacao.toMap(),
        where: 'id = ?', whereArgs: [anotacao.id]);
  }

  Future<int> removerAnotacao(int id) async {
    var bancoDados = await db;
    return await bancoDados.delete(
      "anotacao",
      where: 'id = ?',
      whereArgs: [id]
    );
  }
}
