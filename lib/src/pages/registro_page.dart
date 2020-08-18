import 'package:flutter/material.dart';

import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/providers/usuario_provider.dart';


class RegistroPage extends StatelessWidget {

final usuarioProvider=new UsuarioProvider();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          _crearFondo(context),
          _loginForm(context),
        ],
      )
    );


  }

  Widget _loginForm(BuildContext context){


final bloc=Provider.of(context);



final size=MediaQuery.of(context).size;

return SingleChildScrollView(
  child: Column(
    children: [
      SafeArea(child: Container(height: 180.0,)),
      Container(
        width: size.width*0.85,
        padding: EdgeInsets.symmetric(vertical: 30.0),
        margin:EdgeInsets.symmetric(vertical: 30.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [BoxShadow(
            color: Colors.black26,
            blurRadius: 3.0,
            offset: Offset(0.0,5.0),
            spreadRadius: 3.0
          ),]
        ),
        child: Column(
          children: [
            Text('Crear cuenta',style:TextStyle(fontSize: 20.0)),
            SizedBox(height: 30.0),
            _crearEmail(bloc),
            SizedBox(height: 30.0),
            _crearPassword(bloc),
            SizedBox(height: 30.0),
            _crearBoton(bloc)
          ],
        ),
      ),
      FlatButton(onPressed: ()=>Navigator.pushReplacementNamed(context, 'login'),
      child: Text('¿Ya tiene una cuenta? Login')),
      SizedBox(height: 100,)
    ],
  ),
);

  }

  Widget _crearEmail(LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.emailStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email,color:Colors.deepPurple),
          hintText: 'ejemplo@corre.com',
          labelText: 'Correo electronico',
          counterText: snapshot.data,
          errorText: snapshot.error
        ),
        onChanged: bloc.changeEmail,
      ),
    );
      },
    );
    
    
  }
Widget _crearPassword(LoginBloc bloc){

  return StreamBuilder(
    stream: bloc.passwordStream ,
    builder: (BuildContext context, AsyncSnapshot snapshot){
      return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock,color:Colors.deepPurple),
          labelText: 'Contraseña',
          counterText: snapshot.data,
          errorText: snapshot.error
        ),
        onChanged: bloc.changePassword,
      ),
    );
    },
  );
    
  }


Widget _crearBoton(LoginBloc bloc){

  return StreamBuilder(
    stream: bloc.formValidStream ,
    builder: (BuildContext context, AsyncSnapshot snapshot){
      return RaisedButton(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 80,vertical: 15),
      child: Text('Ingresar'),
    ),
    onPressed: snapshot.hasData?()=>_register(context,bloc):null,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5)
    ),
    elevation: 0.0,
    color:Colors.deepPurple,
    textColor: Colors.white,
  );
    },
  );

  
}


_register(BuildContext context,LoginBloc bloc){
  
  usuarioProvider.nuevoUsuario(bloc.email, bloc.password);
}


  Widget _crearFondo(BuildContext context){
    final size=MediaQuery.of(context).size;
  
  final fondoMorado= Container(
height: size.height*0.4,
width: double.infinity,
decoration: 
BoxDecoration(
  gradient: LinearGradient(
    colors: [
      Color.fromRGBO(63, 63, 156, 1.0),
      Color.fromRGBO(90, 70, 178, 1.0)
    ]
  )
),

  );

final circulo=Container(
  width: 80.0,
  height: 80.0,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(80.0),
    color:Color.fromRGBO(255, 255, 255, 0.05),
  ),
);


  return Stack(
    children: [
      fondoMorado,
      Positioned(child:circulo,left: 30,top: 90,),
      Positioned(child:circulo,right: -30,top: -30,),
      Positioned(child:circulo,bottom:-50,right: -10,),
      Positioned(child:circulo,bottom:100,right: 20,),
      Positioned(child:circulo,bottom:-50,left: -20,),
      Container(
        padding: EdgeInsets.only(top: 80),
        child: Column(
          
          children: [
            Icon(Icons.person_pin_circle,color:Colors.white,size:100.0),
            SizedBox(height: 10.0,width: double.infinity,),
            Text('David Sullcaray',style: TextStyle(color:Colors.white,fontSize: 25.0),)
            
          ],
        ),
      )

    ],
  );

}
}