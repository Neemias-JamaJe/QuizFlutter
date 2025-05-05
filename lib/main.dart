import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Brainrot',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: QuizStartScreen(), // Tela inicial
      debugShowCheckedModeBanner: false,
    );
  }
}

// Tela de Início
class QuizStartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bem-vindo ao Quiz de Nemo',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Teste seus conhecimentos sobre Nemo',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            QuizHome()), // Vai para a tela do quiz
                  );
                },
                child: Text('Iniciar Quiz'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors
                      .blue[600], // Usando backgroundColor em vez de primary
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Tela do Quiz
class QuizHome extends StatefulWidget {
  @override
  _QuizHomeState createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {
  final List<Question> questions = [
    Question(
        "Qual desses é melhor?",
        [
          "Tung tung Tung Sahur",
          "Tralalero Trallalà",
          "capuccino Asesino",
          "Bombardiro Crocodiro"
        ],
        0),
    Question("Qual carro eu prefiro??",
        ["Mustang", "Lancer Evo", "Audi R8", "Camaro"], 2),
    Question("HAHAHA?", ["Nilda", "Paty", "Robelia", "Thamis"], 1),
    Question("Qual cidade eu NÃO visitaria?",
        ["Roma", "Paris", "Londres", "Berlim"], 1),
    Question(
        "Qual ideologia eu apoio?",
        ["Comunista", "Monarquista", "Conservador", "Nenhuma das Alternativas"],
        3),
    Question("Qual destes estilos musicais eu menos gosto?",
        ["Funk", "MPB", "Rock", "Rap"], 0),
    Question("Onde a chave está?",
        ["Na minha casa", "No carro", "No meu chaveiro", "No meu bolso"], 3),
    Question("Waifu?", ["Nami", "Mikoto Urabe", "Rem", "Asia Argento"], 1),
    Question("Qual comida eu prefiro?",
        ["Quiabada", "Caruru com Arroz", "Salada de Fruta", "Mocofato"], 3),
    Question("Qual meu JoJo Favorito?",
        ["Jonathan", "Joseph", "Jotaro", "Josuke"], 1),
  ];

  int currentQuestion = 0;
  int score = 0;
  int timeLeft = 15;
  Timer? timer;
  bool quizFinished = false;

  void startTimer() {
    timeLeft = 30;
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          t.cancel();
          nextQuestion();
        }
      });
    });
  }

  void nextQuestion() {
    timer?.cancel();
    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
      });
      startTimer();
    } else {
      setState(() {
        quizFinished = true;
      });
    }
  }

  void answerQuestion(int index) {
    if (index == questions[currentQuestion].correctIndex) {
      score++;
    }
    nextQuestion();
  }

  void restartQuiz() {
    setState(() {
      currentQuestion = 0;
      score = 0;
      quizFinished = false;
    });
    startTimer();
  }

  String getResultImageUrl() {
    if (score == 0) {
      return 'assets/images/makh.jpg';
    } else if (score <= 3) {
      return 'assets/images/poatan.jpg';
    } else if (score <= 6) {
      return 'assets/images/jon.jpg';
    } else if (score <= 9) {
      return 'assets/images/bronx.jpg';
    } else {
      return 'assets/images/pe.jpg';
    }
  }

  String getResultMessage() {
    if (score <= 2) {
      return "Sai daí Gobila";
    } else if (score <= 4) {
      return "KKKKKKKKKK ruim demais";
    } else if (score <= 7) {
      return "Óia até q me conhece um pouco";
    } else if (score <= 9) {
      return "Eu lendo eu n acredito";
    } else {
      return "Obrigado amigo, você é um amigo";
    }
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: quizFinished
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      getResultImageUrl(),
                      height: 200,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Pontuação: $score / ${questions.length}',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    SizedBox(height: 10),
                    Text(
                      getResultMessage(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  QuizStartScreen()), // Volta para a tela inicial
                        );
                      },
                      child: Text("Voltar para o Início"),
                    ),
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tempo restante: $timeLeft s',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Pergunta ${currentQuestion + 1}/${questions.length}',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Text(
                    questions[currentQuestion].question,
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  SizedBox(height: 20),
                  ...questions[currentQuestion].options.asMap().entries.map(
                    (entry) {
                      final index = entry.key;
                      final text = entry.value;
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => answerQuestion(index),
                          child: Text(text),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

class Question {
  final String question;
  final List<String> options;
  final int correctIndex;

  Question(this.question, this.options, this.correctIndex);
}
