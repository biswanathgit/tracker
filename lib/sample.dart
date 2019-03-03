import 'dart:async';

void main() {
  final controller = new StreamController();
  final order = new Order('chocolate');
  
  controller.sink.add(order);
  final baker = new StreamTransformer.fromHandlers(
  	handleData: (cake,sink){
      if(cake == 'chocolate'){
        sink.add(new Cake());
      }else{
        sink.addError('I can\'t bake that cake.....');
      }
    }
  );
  
  controller.stream
    .map((order)=> order.type)
    .transform(baker)
    .listen(
  		(cake)=> print('Here\'s your $cake ...'),
    	onError : (error) => print('$error')
  );
}

class Cake{}
class Order{
  String type;
  Order(this.type);
}
