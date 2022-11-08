

class NumberFormatted{
  double formatNumber (double number){
    double numberFormatted=double.parse((number).toStringAsFixed(2));
    return numberFormatted;
  }
}