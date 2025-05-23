class Flight {
  final String flightId;
  final String airline;
  final int flightNumber;
  final String duration;
  final int seatsAvailable;
  final int price;
  final String dateInitial;
  final String dateFinal;

  Flight({
    required this.flightId,
    required this.airline,
    required this.flightNumber,
    required this.duration,
    required this.seatsAvailable,
    required this.price,
    required this.dateInitial,
    required this.dateFinal,
  });
}
