class Login {
  String status;
  String description;
  int idEmpleado;
  String nombre;
  String sucursal;
  int idSucursal;
  String token;
  int idLogin;
  bool supervisor;
  bool admin;
  List<TipoEmpleados> tipoEmpleados;

  Login(
      {this.status,
      this.description,
      this.idEmpleado,
      this.nombre,
      this.sucursal,
      this.idSucursal,
      this.token,
      this.idLogin,
      this.supervisor,
      this.admin,
      this.tipoEmpleados});

  Login.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    description = json['Description'];
    idEmpleado = json['IdEmpleado'];
    nombre = json['Nombre'];
    sucursal = json['Sucursal'];
    idSucursal = json['IdSucursal'];
    token = json['token'];
    idLogin = json['idLogin'];
    supervisor = json['Supervisor'];
    admin = json['Admin'];
    if (json['TipoEmpleados'] != null) {
      tipoEmpleados = new List<TipoEmpleados>();
      json['TipoEmpleados'].forEach((v) {
        tipoEmpleados.add(new TipoEmpleados.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Description'] = this.description;
    data['IdEmpleado'] = this.idEmpleado;
    data['Nombre'] = this.nombre;
    data['Sucursal'] = this.sucursal;
    data['IdSucursal'] = this.idSucursal;
    data['token'] = this.token;
    data['idLogin'] = this.idLogin;
    data['Supervisor'] = this.supervisor;
    data['Admin'] = this.admin;
    if (this.tipoEmpleados != null) {
      data['TipoEmpleados'] =
          this.tipoEmpleados.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TipoEmpleados {
  int tipoId;

  TipoEmpleados({this.tipoId});

  TipoEmpleados.fromJson(Map<String, dynamic> json) {
    tipoId = json['TipoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TipoId'] = this.tipoId;
    return data;
  }
}
