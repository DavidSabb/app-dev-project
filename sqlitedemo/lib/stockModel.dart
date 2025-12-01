import 'dart:convert';

List<StockModel> stockModelFromJson(String str) =>
    List<StockModel>.from(json.decode(str).map((x) => StockModel.fromJson(x)));

String stockModelToJson(List<StockModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StockModel {
  StockModel({
    required this.symbol,
    required this.price,
    required this.change,
    required this.changePercentage,
    required this.image,
  });

  String symbol;
  double price;
  double change;
  double changePercentage;
  String image;

  factory StockModel.fromJson(Map<String, dynamic> json) => StockModel(
    symbol: json["symbol"],
    price: json["price"],
    change: json["change"],
    changePercentage: json["changePercentage"],
    image: json["image"]
  );

  Map<String, dynamic> toJson() => {
    "symbol": symbol,
    "price": price,
    "change": change,
    "changePercentage": changePercentage,
    "image": image
  };
}