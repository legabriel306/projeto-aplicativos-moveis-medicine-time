class Remedio {
  final String uid;
  final String nome;
  final String dose;
  final String horaInicio;
  
  Remedio(this.uid, this.nome, this.dose, this.horaInicio);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'nome': nome,
      'dose': dose,
      'horaInicio': horaInicio
    };
  }

  factory Remedio.fromJson(Map<String, dynamic> json) {
    return Remedio(
      json['uid'],
      json['nome'],
      json['dose'],
      json['horaInicio'],
    );
  }

}
