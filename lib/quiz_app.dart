import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

const numberOfQuestions = 20;

void main(List<String> args) {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          title: const Text('Quiz App'),
          backgroundColor: Colors.grey.shade800,
          centerTitle: true,
        ),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int totalQuestions = numberOfQuestions;
  int correctAnswers = 0;
  List<Question> quizQuest = chooseRandomTwenty();
  int counter = 0;
  int numTimesPressed = 0;
  bool isGameOver = false;
  bool userPickedAnswerToScore = false;

  void displayExplanation(bool userPickedAnswer, bool correctAnswer) {
    if (numTimesPressed == 1) {
      userPickedAnswerToScore = userPickedAnswer;
    }
    Alert(
      context: context,
      type: numTimesPressed == 1
          ? userPickedAnswerToScore == correctAnswer
              ? AlertType.success
              : AlertType.error
          : AlertType.info,
      title: numTimesPressed == 1
          ? userPickedAnswerToScore == correctAnswer
              ? 'Correct!'
              : 'Incorrect!'
          : 'Already Answered!',
      desc: quizQuest[counter].explanation,
      buttons: [
        DialogButton(
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              if (counter < totalQuestions - 1) {
                counter++;
                if (userPickedAnswerToScore == correctAnswer) {
                  correctAnswers++;
                }
                numTimesPressed = 0;
              } else {
                showGameOverDialog(userPickedAnswerToScore, correctAnswer);
              }
            });
          },
          width: 120.0,
          child: const Text(
            'Next',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    ).show();
  }

  void showGameOverDialog(bool userPickedAnswer, bool correctAnswer) {
    if (userPickedAnswer == correctAnswer) {
      correctAnswers++;
    }
    Alert(
      context: context,
      type: AlertType.success,
      title: 'Game Over!',
      desc: 'Your Score: $correctAnswers/$totalQuestions',
      buttons: [
        DialogButton(
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              counter = 0;
              correctAnswers = 0;
              numTimesPressed = 0;
              isGameOver = false;
              quizQuest = chooseRandomTwenty();
            });
          },
          width: 120.0,
          child: const Text(
            'Play Again',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        )
      ],
    ).show();
  }

  String displayNextQuestion() {
    if (counter < totalQuestions) {
      return 'Question #${counter + 1}\n\n${quizQuest[counter].question}';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Score: ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
              Text(
                correctAnswers.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                ' / ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
              Text(
                totalQuestions.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                displayNextQuestion(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                  letterSpacing: 1.125,
                  wordSpacing: 1.5,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                setState(() {
                  numTimesPressed++;
                  displayExplanation(true, quizQuest[counter].answer);
                });
              },
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                setState(() {
                  numTimesPressed++;
                  displayExplanation(false, quizQuest[counter].answer);
                });
              },
              child: const Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 64.0,
        ),
      ],
    );
  }
}

class Question {
  String question;
  bool answer;
  String explanation;

  Question(
      {required this.question,
      required this.answer,
      required this.explanation});
}

List<Question> chooseRandomTwenty() {
  List<Question> randomTwenty = [];
  for (int i = 0; i < numberOfQuestions; i++) {
    randomTwenty.add(questions[Random().nextInt(questions.length)]);
  }
  return randomTwenty;
}

List<Question> questions = [
  Question(
      question: 'Sharks are mammals.',
      answer: false,
      explanation: 'They are actually classified as fish.'),
  Question(
      question: 'Sea otters have a favorite rock they use to break open food.',
      answer: true,
      explanation:
          'They keep these treasures in the loose skin under their arms.'),
  Question(
      question: 'The blue whale is the biggest animal to have ever lived.',
      answer: true,
      explanation: 'And that includes dinosaurs!'),
  Question(
      question: 'The hummingbird egg is the world\'s smallest bird egg.',
      answer: true,
      explanation: 'On the flip side, ostriches lay the largest eggs.'),
  Question(
      question: 'Bats are blind.',
      answer: false,
      explanation:
          'Bats often find their way using ultrasound but their eyes work, just not particularly well.'),
  Question(
      question: 'It takes a sloth two weeks to digest a meal.',
      answer: true,
      explanation: 'And that\'s the slowest digestion time of any mammal!'),
  Question(
      question: 'The largest living frog is the Goliath frog of West Africa.',
      answer: true,
      explanation:
          'This amphibian reaches lengths of 12.5 inches and weighs 7.2 pounds.'),
  Question(
      question: 'An ant can lift 1,000 times its body weight.',
      answer: false,
      explanation: 'Ants can lift 5,000 times their body weight!'),
  Question(
      question: 'Galapagos tortoises sleep up to 16 hours a day.',
      answer: true,
      explanation:
          'And they can go a year without food or water, so they have lots of time for extra sleep.'),
  Question(
      question: 'An octopus has seven hearts.',
      answer: false,
      explanation:
          'It has three hearts - one to circulate blood around the body and the other two to pick up oxygen.'),
  Question(
      question: 'The goat is the national animal of Scotland.',
      answer: false,
      explanation: 'It is the unicorn.'),
  Question(
      question:
          'Alaska has the most active volcanoes of any state in the United States.',
      answer: true,
      explanation: 'Alaska has 141 potentially active volcanoes.'),
  Question(
      question: 'China has the longest coastline in the world.',
      answer: false,
      explanation: 'The winner is Canada with 151,019 miles.'),
  Question(
      question: 'Venezuela is home to the world\'s highest waterfall.',
      answer: true,
      explanation: 'You would have to climb 979 meters to reach the top.'),
  Question(
      question: 'The human body has four lungs.',
      answer: false,
      explanation:
          'It has two, aiding in breathing 11,000 liters of air every day.'),
  Question(
      question: 'The average human sneeze can be clocked at 100 miles an hour.',
      answer: true,
      explanation:
          'And be sure to cover your nose, a sneeze can create upwards of 100,000 droplets.'),
  Question(
      question: 'Humans lose an average of 75 strands of hair a month.',
      answer: false,
      explanation: 'Humans can lose up to 75 strands in ONE DAY.'),
  Question(
      question: 'Infants have more bones than adults.',
      answer: true,
      explanation:
          'Infants are born with approximately 300 bones but have 206 by the time they reach adulthood.'),
  Question(
      question: 'Most of the human brain is made of muscle.',
      answer: false,
      explanation: '60% is made up of fat, making it the fattiest organ.'),
  Question(
      question: 'The Atlantic Ocean is the biggest ocean on Earth.',
      answer: false,
      explanation: 'Pacific Ocean is the largest ocean.'),
  Question(
      question: 'The human body is about 60% water.',
      answer: true,
      explanation: 'Water is essential for every cell to function.'),
  Question(
      question: 'The most common blood type is 0- negative.',
      answer: false,
      explanation: 'And AB- negative is the rarest. '),
  Question(
      question: 'Aladdin\'s character was based on Brad Pitt.',
      answer: false,
      explanation: 'Tom Cruise was the inspiration for the character.'),
  Question(
      question:
          'It took eight months from start to finish to produce the 1959 Disney film, Sleeping Beauty.',
      answer: false,
      explanation: 'It took eight years.'),
  Question(
      question:
          'Pinocchio was the first animated, full-color Walt Disney feature film.',
      answer: false,
      explanation: 'It was Snow White and the Seven Dwarfs.'),
  Question(
      question: 'Toy Story was Pixar\'s first movie.',
      answer: true,
      explanation:
          'It was released in 1995. To date, three more Toy Story films have been released.'),
  Question(
      question: 'Minnie Mouse\'s full name is Wilhelmina Mouse.',
      answer: false,
      explanation: 'Her real name is Minerva Mouse.'),
  Question(
      question: 'Dumbo is the shortest Disney film.',
      answer: true,
      explanation: 'This feature-length film runs only 64 minutes long.'),
  Question(
      question:
          'The Aristocats was the first film to be made after Walt Disney\'s death.',
      answer: true,
      explanation:
          'It was the last film to be approved by Walt Disney directly'),
  Question(
      question:
          'Prince Eric and Ariel from The Little Mermaid have a daughter named Princess Song.',
      answer: false,
      explanation:
          'Her name is Princess Melody, she is the main character in The Little Mermaid II: Return to the Sea.'),
  Question(
      question: 'Beauty and the Beast was Disney\'s first Broadway musical.',
      answer: true,
      explanation:
          'Beauty and the Beast premiered on Broadway in 1994 and ran for 13 years. '),
  Question(
      question: 'Pepperoni is the most popular pizza topping in the US.',
      answer: true,
      explanation: 'Mushrooms come in second.'),
  Question(
      question: 'Cheesecake comes from Italy.',
      answer: false,
      explanation: 'You can thank Greece for the tasty treat.'),
  Question(
      question: 'Pineapples grow on trees.',
      answer: false,
      explanation: 'They actually grow in the ground.'),
  Question(
      question:
          'A potato was the first vegetable to be planted on the space shuttle.',
      answer: true,
      explanation:
          'University of Wisconsin-Madison and NASA partnered to put spuds in space.'),
  Question(
      question: 'Hawaiian pizza comes from Canada.',
      answer: true,
      explanation:
          'It was created in 1962 by Sam Panopoulos at the Satellite Restaurant in Ontario, Canada.'),
  Question(
      question: 'French fries originated from France.',
      answer: false,
      explanation: 'We have Belgium to thank for the crispy fried goodness.'),
  Question(
      question: 'Pizza was the first food consumed in space.',
      answer: false,
      explanation: 'The astronauts first ate up applesauce.'),
  Question(
      question: 'Caesar Salad originates from Italy.',
      answer: false,
      explanation:
          'The delicious leafy goodness was a product of Tijuana, Mexico.'),
  Question(
      question: 'Ears of corn have an even number of rows.',
      answer: true,
      explanation: 'An average ear has 16 rows of kernels.'),
  Question(
      question:
          'The names of the mascots for Rice Krispies are Snap, Crackle, & Pop.',
      answer: true,
      explanation: 'The elf-like creatures first appear in the 1930s.'),
  Question(
      question: 'Vanilla is the world\'s most expensive spice.',
      answer: false,
      explanation:
          'Saffron is the most expensive spice. A kilogram requires the stigmas of about 150,000 flowers.'),
  Question(
      question:
          'Mcdonald\'s has the most restaurants by location in the United States.',
      answer: false,
      explanation:
          'Subway takes the prize with locations in 49 out 50 states.'),
  Question(
      question:
          'The Chinese New Year is celebrated on the same day every year.',
      answer: false,
      explanation:
          'The festival falls between January 21 and February 20 and is determined by the Chinese lunar calendar.'),
  Question(
      question:
          'The first St. Patrick\'s Day parade in the United States was held in New York City.',
      answer: false,
      explanation:
          'Boston hosted the first St. Patty\'s Day parade in the U.S. in 1737.'),
  Question(
      question:
          'The tradition of dyeing Easter eggs started in the United States.',
      answer: false,
      explanation:
          'Egg dyeing originated in ancient Ukraine, believed to bring fertility and good harvests.'),
  Question(
      question: 'Santa Claus has his own postal code in Canada.',
      answer: true,
      explanation:
          'Postal Service has designated H0H0H0 (ho ho ho) as the official postcode for letters to Santa.'),
  Question(
      question: 'There are seven nights in Kwanzaa.',
      answer: true,
      explanation:
          'Each night a candle is lit to observe the Ngubo Saba, the seven principles of Kwanzaa.'),
  Question(
      question:
          'Polo takes up the largest amount of space in terms of land area.',
      answer: true,
      explanation:
          'This "Sport of Kings" is played on a 300-yard by 160-yard field.'),
  Question(
      question: 'Every golf ball has the same number of dimples.',
      answer: false,
      explanation: 'Golf balls have between 300 to 500 dimples.'),
  Question(
      question: 'Football players started wearing helmets in 1943.',
      answer: true,
      explanation: 'The first helmets were made of moleskin.'),
  Question(
      question:
          'Brazil is the only nation to have played in every World Cup finals tournament.',
      answer: true,
      explanation: 'The soccer-crazed country has also won the most titles.'),
  Question(
      question:
          'World-renowned jeweler Tiffany & Co. is the maker of the Vince Lombardi trophy.',
      answer: true,
      explanation:
          'Tiffany has produced the trophy since the first Super Bowl in 1967.'),
  Question(
      question: 'The New York Marathon is the largest in the world.',
      answer: true,
      explanation:
          'This popular race had humble beginnings with only 127 runners when it started in 1970.'),
  Question(
      question: 'Three strikes in a row in bowling is called a chicken.',
      answer: false,
      explanation: 'It is called a turkey.'),
  Question(
      question: 'An astronaut has played golf on the moon.',
      answer: true,
      explanation:
          'Alan Shepard took time out of his space duties to hit the links, noting one of his shots "went for miles and miles."'),
  Question(
      question: 'The Tour de France always finishes in Italy.',
      answer: false,
      explanation:
          'The finish line is on the Champs-élysées, one of the most famous streets in Paris.'),
  Question(
      question:
          'President George Washington brought macaroni and cheese to the USA.',
      answer: false,
      explanation:
          'President Thomas Jefferson gets the credit. He brought the recipe back from Paris, France.'),
  Question(
      question: 'Marvel published its first comic in October 1939.',
      answer: true,
      explanation:
          'If you can get your hands on a copy, you could sell it for up to \$1 million.'),
  Question(
      question: 'The letter "T" is the most common in the English Language.',
      answer: false,
      explanation: 'It\'s the letter "E".')
];
