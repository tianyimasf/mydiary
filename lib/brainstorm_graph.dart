import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'brainstorm_questions.dart';
import 'dart:math';

class BrainstormGraphPage extends StatefulWidget {
  final String rootName;
  BrainstormGraphPage({required this.rootName});

  @override
  _BrainstormGraphPageState createState() => _BrainstormGraphPageState();
}

class _BrainstormGraphPageState extends State<BrainstormGraphPage> {
  final Graph graph = Graph();
  bool graphGenerated = false;

  final Map<String, QuestionNode> questionMap = {};

  @override
  void initState() {
    super.initState();
    _generateGraph();
  }

  void _generateGraph() {
    graph.nodes.clear();
    graph.edges.clear();
    questionMap.clear();

    // 1️⃣ Central node
    Node rootNode = Node.Id(widget.rootName);
    graph.addNode(rootNode);

    // 2️⃣ Fan out categories around root
    final categoryList = categories.keys.toList();
    final double radius = 700;
    final double angleStep = 2 * pi / categoryList.length;

    for (int i = 0; i < categoryList.length; i++) {
      String category = categoryList[i];
      Node categoryNode = Node.Id(category);

      // manually assign x, y offsets for circular layout
      categoryNode.position = Offset(
        radius * cos(i * angleStep),
        radius * sin(i * angleStep),
      );

      graph.addNode(categoryNode);
      graph.addEdge(rootNode, categoryNode);

      // 3️⃣ Fan out questions around category
      final questions = categories[category]!;
      final questionCount = questions.length;
      final double questionRadius = 500;
      final double questionAngleStep = 2 * pi / max(questionCount, 1);

      for (int j = 0; j < questionCount; j++) {
        var q = questions[j];
        final id = "q_${category}_${q.hashCode}";
        questionMap[id] = q;

        Node questionNode = Node.Id(id);
        questionNode.position = Offset(
          categoryNode.position.dx + questionRadius * cos(j * questionAngleStep),
          categoryNode.position.dy + questionRadius * sin(j * questionAngleStep),
        );

        graph.addNode(questionNode);
        graph.addEdge(categoryNode, questionNode);
      }
    }

    setState(() {
      graphGenerated = true;
    });
  }

  void _showAnswerDialog(QuestionNode q) {
    TextEditingController controller = TextEditingController(text: q.answer);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Answer"),
        content: SizedBox(
          width: 500,
          height: 150,
          child: TextField(
            controller: controller,
            maxLength: 1000,
            maxLines: 5,
            decoration: InputDecoration(hintText: "Type your answer here..."),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                q.answer = controller.text;
              });
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  Widget _buildBubble(String text,
      {bool isCategory = false, bool isRoot = false, bool isQuestion = false}) {
    return IntrinsicWidth(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isRoot
              ? Colors.black87
              : (isCategory ? Colors.black87 : Colors.black45),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: isRoot
                ? 22
                : (isCategory ? 18 : (isQuestion ? 16 : 14)),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildQuestionBubble(QuestionNode q) {
    return GestureDetector(
      onTap: () => _showAnswerDialog(q),
      child: Tooltip(
        message: q.answer.isNotEmpty ? q.answer : "No answer yet",
        child: _buildBubble(q.question, isQuestion: true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Brainstorm Questions")),
      body: graphGenerated
          ? InteractiveViewer(
              constrained: false,
              boundaryMargin: EdgeInsets.all(400),
              minScale: 0.01,
              maxScale: 5.0,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: GraphView(
                  graph: graph,
                  algorithm: FruchtermanReingoldAlgorithm(iterations: 1000),
                  builder: (Node node) {
                    final key = node.key!.value as String;
                    if (key == widget.rootName) {
                      return _buildBubble(key, isRoot: true);
                    } else if (questionMap.containsKey(key)) {
                      return _buildQuestionBubble(questionMap[key]!);
                    } else {
                      return _buildBubble(key, isCategory: true);
                    }
                  },
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
