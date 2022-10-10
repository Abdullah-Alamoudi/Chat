import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../picker/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  //const AuthForm({Key? key}) : super(key: key);
final void Function(String email,String password,String username,bool islogin,BuildContext ctx,File image)? submitFn;
final void Function(String email,String password,String username,bool islogin,BuildContext ctx)? sFn;
final bool sloading;
  const AuthForm({
    Key? key,  this.submitFn,this.sFn,required this.sloading,
  }) : super(key: key);



  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _fromkey=GlobalKey<FormState>();
  bool _islogin=true;
  String _email='';
  String _password='';
  String _username='';
  File? _userImageFile;

   void _pickedImag(File pickedImage){
          _userImageFile=pickedImage;
  }

  void _submit(){
    final isValid=_fromkey.currentState!.validate();
    FocusScope.of(context).unfocus(); // help me close keyboard after excute current function 
    
    if(!_islogin&& _userImageFile==null){
      Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Please pick an image. '),
      backgroundColor: Theme.of(context).errorColor,
    ));
      return;
      
    }

    if(isValid){
      _fromkey.currentState!.save();
      print(_email);
      print(_username);
      print(_password);
      if(!_islogin)
     { widget.submitFn!(_email.trim(),_password.trim(),_username.trim(),_islogin,context,_userImageFile!);} // trim=> delete space from text
      else{
            widget.sFn!(_email.trim(),_password.trim(),_username.trim(),_islogin,context,);
      }

    }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _fromkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if(!_islogin)
                  UserImagePicker(imagePicFn: _pickedImag,),
                TextFormField(
                  key: ValueKey('email'),  // key unique widget for save data when navigate from route
                  decoration: InputDecoration(labelText: 'Email Address'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (val){
                    if(val!.isEmpty||!val.contains('@')){
                          return 'Please enter a valid email address';
                    }else
                    {
                        return null;
                    }
                    
                  },
                  onSaved: (val)=>_email=val!,
                ),
                if(!_islogin)
                TextFormField(
                  key: ValueKey('username'),
                  decoration: InputDecoration(labelText: 'Username'),
                  //keyboardType: TextInputType.emailAddress,
                  validator: (val){
                    if(val!.isEmpty||val.length<4){
                          return 'Please enter at least 4 characters';
                    }else
                    {
                        return null;
                    }
                  },
                  onSaved: (val)=>_username=val!,
                ),
                TextFormField(
                  key: ValueKey('password'),
                  decoration: InputDecoration(labelText: 'Password'),
                  //keyboardType: TextInputType.emailAddress,
                  validator: (val){
                    if(val!.isEmpty||val.length<7){
                          return 'Please enter at least 7 characters';
                    }else
                    {
                        return null;
                    }
                  },
                  onSaved: (val)=>_password=val!,
                  obscureText: true,
                ),
                SizedBox(height: 12,),
                if(widget.sloading)
                  CircularProgressIndicator(),
                if(!widget.sloading)
                RaisedButton(
                  onPressed:_submit,
                  child: Text(_islogin?'Login':'Sign up'),                                
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(_islogin? 'Create new account':'I already have an account'),
                    onPressed: (){
                      setState(() {
                        _islogin=!_islogin;
                      });
                    }, )

              ],
            ),
          ),
        ),
      ),
    );
  }
}