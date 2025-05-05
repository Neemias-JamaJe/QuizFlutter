import 'package:flutter/material.dart';
import 'dart:async';
import 'questões.dart'; 
import 'tela_de_start.dart'; 

class QuizHome extends StatefulWidget {
  @override
  _QuizHomeState createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {
  final List<Question> questions = [
    Question("Qual desses é melhor?",
        ["Tung tung Tung Sahur", "Tralalero Trallalà", "capuccino Asesino", "Bombardiro Crocodiro"],
        0,
        'assets/images/interroga1.jpg'),
    Question("Qual carro eu prefiro??",
        ["Mustang", "Lancer Evo", "Audi R8", "Camaro"],
        2,
        'assets/images/interroga2.jpg'),
    Question("HAHAHA?",
        ["Nilda", "Paty", "Robelia", "Thamis"],
        1,
        'assets/images/interroga3.jpg'),
    Question("Qual cidade eu NÃO visitaria?",
        ["Roma", "Paris", "Londres", "Berlim"],
        1,
        'assets/images/interroga4.jpg'),
    Question("Qual ideologia eu apoio?",
        ["Comunista", "Monarquista", "Conservador", "Nenhuma das Alternativas"],
        3,
        'assets/images/interroga5.jpg'),
    Question("Qual destes estilos musicais eu menos gosto?",
        ["Funk", "MPB", "Rock", "Rap"],
        0,
        'assets/images/interroga6.jpg'),
    Question("Onde a chave está?",
        ["Na minha casa", "No carro", "No meu chaveiro", "No meu bolso"],
        3,
        'assets/images/interroga7.jpg'),
    Question("Waifu?",
        ["Nami", "Mikoto Urabe", "Rem", "Asia Argento"],
        1,
        'assets/images/interroga8.png'),
    Question("Qual comida eu prefiro?",
        ["Quiabada", "Caruru com Arroz", "Salada de Fruta", "Mocofato"],
        3,
        'assets/images/interroga9.jpg'),
    Question("Qual meu JoJo Favorito?",
        ["Jonathan", "Joseph", "Jotaro", "Josuke"],
        1,
        'assets/images/interroga10.jpg'),
  ];

  int currentQuestion = 0;
  int score = 0;
  int timeLeft = 30;
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

  String getResultImageUrl() {
    if (score <= 2) return 'assets/images/makh.jpg';
    if (score <= 4) return 'assets/images/poatan.jpg';
    if (score <= 7) return 'assets/images/jon.jpg';
    if (score <= 9) return 'assets/images/bronx.jpg';
    return 'assets/images/pe.jpg';
  }

  String getResultMessage() {
    if (score <= 2) return "Sai daí Gobila";
    if (score <= 4) return "KKKKKKKKKK ruim demais";
    if (score <= 7) return "Óia até q me conhece um pouco";
    if (score <= 9) return "Eu lendo eu n acredito";
    return "Obrigado amigo, você é um amigo";
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
      backgroundColor: const Color(0xFF1929FF),
      body: quizFinished
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(getResultImageUrl(), height: 200),
                    SizedBox(height: 20),
                    Text(
                      'Acertos: $score / ${questions.length}',
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
                          MaterialPageRoute(builder: (context) => QuizStartScreen()),
                        );
                      },
                      child: Text("Reiniciar"),
                    ),
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
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
                    Image.asset(
                      questions[currentQuestion].imagePath,
                      height: 200,
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
            ),
    );
  }
}