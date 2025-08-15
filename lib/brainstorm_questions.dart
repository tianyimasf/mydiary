// lib/question_data.dart

class QuestionNode {
  final String question;
  String answer; // default empty
  QuestionNode(this.question, this.answer);
}

final Map<String, List<QuestionNode>> categories = {
  "Purpose & Vision": [
    QuestionNode("What problem does my app solve?", ""),
    QuestionNode("Why will users care about this \n app?", ""),
    QuestionNode("How is this app different from \n existing solutions?", ""),
    QuestionNode("What is the core value or  \n experience I want users to get?", ""),
  ],
  "Target Audience": [
    QuestionNode("Who are my primary users?", ""),
    QuestionNode("What are their pain points or \n needs?", ""),
    QuestionNode("How tech-savvy is my target \n audience?", ""),
    QuestionNode("How will this app fit into \n their daily routines?", ""),
  ],
  "Features & Functionality": [
    QuestionNode("What are the must-have features \n for version 1.0?", ""),
    QuestionNode("Which features can be added later?", ""),
    QuestionNode("How will users navigate the app?", ""),
    QuestionNode("Will the app need offline support?", ""),
  ],
  "Design & UX": [
    QuestionNode("What kind of look and feel \n should the app have?", ""),
    QuestionNode("How will users accomplish main \n tasks quickly?", ""),
    QuestionNode("What accessibility considerations \n should I include?", ""),
    QuestionNode("Are animations or gestures part \n of the user experience?", ""),
  ],
  "Technical Considerations": [
    QuestionNode("Which platforms will the app \n target?", ""),
    QuestionNode("Will I use Flutter, React Native, \n or native development?", ""),
    QuestionNode("What backend, database, or APIs \n will be needed?", ""),
    QuestionNode("How will I ensure security and \n privacy of user data?", ""),
  ],
  "Business & Monetization": [
    QuestionNode("What is the revenue model?", ""),
    QuestionNode("Who are potential competitors?", ""),
    QuestionNode("How will I acquire and retain users?", ""),
    QuestionNode("What metrics will indicate success?", ""),
  ],
};
