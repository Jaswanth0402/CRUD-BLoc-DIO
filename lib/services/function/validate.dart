
class Validate{
   namevalidate(val){
     String patttern = r'(^[a-zA-Z ]*$)';
            RegExp regExp =  RegExp(patttern);
             if (val!.isEmpty) {
               return "Name is Required";
            } else if (!regExp.hasMatch(val)) {
               return "Name must be a-z and A-Z";
            }
              return null;
  }
  emailvalidate(val){
     String patttern = r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regExp =  RegExp(patttern);
             if (val!.isEmpty) {
               return "Email is Required";
            } else if (!regExp.hasMatch(val)) {
               return "Enter a Valid Email";
            }
              return null;
  }
  mobilevalidate(val){
      String patttern = r'(^[0-9]*$)';
             RegExp regExp =  RegExp(patttern);
             if (val!.isEmpty) {
               return "Mobile is Required";
            }
            else if(val.length!=10){
              return "Enter the valid Mobile No";

            }
            else if (!regExp.hasMatch(val)) {
               return "Enter the valid Mobile No";
            }
              return null;
  }
}