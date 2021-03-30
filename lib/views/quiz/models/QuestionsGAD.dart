class Question {
  final int id;
  //final int answer;
  final String question;
  final List<String> options;

  Question({this.id, this.question, /*this.answer,*/ this.options});
}

const List sample_data = [
  //GAD-7 Questions
  {
    "id": 1,
    "question": "Feeling nervous, anxious, or on edge",
    "options": ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
  },
  {
    "id": 2,
    "question": "Not being able to stop or control worrying",
    "options": ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
  },
  {
    "id": 3,
    "question": "Worrying too much about different things",
    "options": ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
  },
  {
    "id": 4,
    "question": "Trouble relaxing",
    "options": ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
  },
  {
    "id": 5,
    "question": "Being so restless that it is hard to sit still ",
    "options": ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
  },
  {
    "id": 6,
    "question": "Becoming easily annoyed or irritable",
    "options": ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
  },
  {
    "id": 7,
    "question": "Feeling afraid, as if something awful might happen",
    "options": ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
  },
];
