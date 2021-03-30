class Question {
  final int id;
  //final int answer;
  final String question;
  final List<String> options;

  Question({this.id, this.question, /*this.answer,*/ this.options});
}

const List sample_data = [
  //PHQ-9 Questions
  {
    "id": 1,
    "question":
        "Little interest or pleasure in doing things",
    "options": ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
    //"answer_index": 1,
  },
  {
    "id": 2,
    "question": "Feeling down, depressed, or hopeless",
    "options": ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
    //"answer_index": 2,
  },
  {
    "id": 3,
    "question": "Trouble falling or staying asleep, or sleeping too much",
    "options": ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
    //"answer_index": 2,
  },
  {
    "id": 4,
    "question": "Feeling tired or having little energy",
    "options": ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
    //"answer_index": 2,
  },
  {
    "id": 5,
    "question": "Poor appetite or overeating",
    "options": ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
    //"answer_index": 2,
  },
  {
    "id": 6,
    "question": "Feeling bad about yourself or that you are a failure or have let yourself or your family down",
    "options": ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
    //"answer_index": 2,
  },
  {
    "id": 7,
    "question": "Trouble concentrating on things, such as reading the newspaper or watching television",
    "options": ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
    //"answer_index": 2,
  },
  {
    "id": 8,
    "question": "Moving or speaking so slowly that other people could have noticed. Or the opposite being so figety or restless that you have been moving around a lot more than usual",
    "options": ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
    //"answer_index": 2,
  },
  {
    "id": 9,
    "question": "Thoughts that you would be better off dead, or of hurting yourself",
    "options": ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
    //"answer_index": 2,
  },
];
