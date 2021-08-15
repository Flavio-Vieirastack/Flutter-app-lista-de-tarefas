class Anotacao {
  int id;
  String descicao;
  String titulo;
  String data;

  Anotacao(
    this.descicao,
    this.titulo,
    this.data,
  );

  Anotacao.fromMap(Map map) {
    this.id = map['id'];
    this.titulo = map['titulo'];
    this.descicao = map['descicao'];
    this.data = map['data'];

  }

  Map toMap() {
    Map<String, dynamic> map = {
      'titulo': this.titulo,
      'descicao': this.descicao,
      'data': this.data
    };

    if (this.id != null) {
      map['id'] = this.id;
    }

    return map;
  }
}
