class AttandanceModel {
  final int id;
  final String checkIn;
  final String date;
  final String? checkOut;
  final DateTime createdAt;
  

  AttandanceModel({
    required this.id,
     required this.checkIn,
      required this.date,
        this.checkOut,
         required this.createdAt,
         
          
         });
         factory AttandanceModel.fromJson(Map<String, dynamic> date) {
    return AttandanceModel(
      id: date['id'],
      checkIn: date['check_in'],
      date: date['date'],
      checkOut: date['check_out'],
      createdAt: DateTime.parse(date['created_at']),
   
    );
  }
}
