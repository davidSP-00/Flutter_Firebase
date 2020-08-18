import 'package:shared_preferences/shared_preferences.dart';
class PreferenciasUsuario{

static final PreferenciasUsuario _instancia=new PreferenciasUsuario._internal();

factory PreferenciasUsuario(){
return _instancia;

}

PreferenciasUsuario._internal();


SharedPreferences _prefs;

initPref() async{
  _prefs=await SharedPreferences.getInstance();

}

//Ninguna de estas propiedades se usa
/* bool _colorSecundario;
int _genero;
String _nombre; */


//GET y SET del Nombre Usuario

get token{
  return _prefs.getString('token')??'';
}

set token(String value){

  _prefs.setString('token', value);

}
//GET y SET de la ultima pagina

get ultimaPagina{
  return _prefs.getString('ultimaPagina')??'home';
}

set ultimaPagina(String value){

  _prefs.setString('ultimaPagina', value);

}

}




