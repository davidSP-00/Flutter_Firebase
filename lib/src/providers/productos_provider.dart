

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';

import 'package:http_parser/http_parser.dart';

import 'package:formvalidation/src/models/producto_model.dart';
import 'package:image_picker/image_picker.dart';

class ProductosProvider{

  final String _url='https://flutter-8e6fa.firebaseio.com';


  Future<bool> crearProducto(ProductoModel producto) async{
    final url ='$_url/productos.json';

    final resp= await http.post(url,body:productoModelToJson(producto) );


    final decodedData=json.decode(resp.body);

    print(decodedData);

    return true;

  }
  Future<bool> editarProducto(ProductoModel producto) async{
    final url ='$_url/productos/${producto.id}.json';

    final resp= await http.put(url,body:productoModelToJson(producto) );


    final decodedData=json.decode(resp.body);

    print(decodedData);

    return true;
  }


Future<List<ProductoModel>> cargarProductos() async{


  final url='$_url/productos.json';


  final resp=await http.get(url);

final Map<String,dynamic>decodedData=json.decode(resp.body);

final List<ProductoModel>productos=new List();

if(decodedData==null)return[];

decodedData.forEach((id, value) { 
final prodTemp=ProductoModel.fromJson(value);

prodTemp.id=id;
productos.add(prodTemp);
});

print(productos);
return productos;
}

Future<int> borrarProducto(String id) async{

  final url='$_url/productos/$id.json';

  final resp=await http.delete(url);


  print(resp.body);

return 1;

}
Future<String>subirImagen(PickedFile imagen) async{

final url=Uri.parse('https://api.cloudinary.com/v1_1/dbayarori/image/upload?upload_preset=xnmvqvqt&');

final mimeType=mime(imagen.path).split('/');

final imageUploadRequest=http.MultipartRequest(
  'POST',
  url);

  final file=await http.MultipartFile.fromPath('file', imagen.path,
  contentType: MediaType(mimeType[0],mimeType[1]));


  imageUploadRequest.files.add(file);

  final streamResponse=await imageUploadRequest.send();


  final resp=await http.Response.fromStream(streamResponse);

  if(resp.statusCode!=200&&resp.statusCode!=201){
    print('Algo salio mal');
    print(resp.body);
    return null;
  }

final respData=json.decode(resp.body);
print(respData);
return respData['secure_url'];


}
}

