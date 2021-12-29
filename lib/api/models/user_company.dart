class UserCompany{
 late String name;
 late String catchPhrase;
 late String bs;

 UserCompany();

 UserCompany.fromMap(Map<String,dynamic>map){
   name = map['name'];
   catchPhrase = map['catchPhrase'];
   bs = map['bs'];
 }
}

//     "company": {
//       "name": "Romaguera-Crona",
//       "catchPhrase": "Multi-layered client-server neural-net",
//       "bs": "harness real-time e-markets"
//     }