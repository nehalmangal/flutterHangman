class Scores{
  final int id;
  final String scoreDate;
  final int userScore;

  Scores({required this.id,required this.scoreDate,required this.userScore});
  Map<String,dynamic> toMap(){
    return {
      'scoreDate': scoreDate,
      'userScore': userScore
    };

  }

  @override
  String toString() {
    return '$userScore,$scoreDate,$id';
  }

}