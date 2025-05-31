class Flight {
  final int id;
  final String flightId;
  final String duration;
  final String airline;
  final int flightNumber;
  final int seatsAvailable;
  final double price;
  final String destinationId;
  final String originId;
  final DateTime dateInitial;
  final DateTime dateFinal;

  Flight({
    required this.id,
    required this.flightId,
    required this.duration,
    required this.airline,
    required this.flightNumber,
    required this.seatsAvailable,
    required this.price,
    required this.destinationId,
    required this.originId,
    required this.dateInitial,
    required this.dateFinal,
  });
}
