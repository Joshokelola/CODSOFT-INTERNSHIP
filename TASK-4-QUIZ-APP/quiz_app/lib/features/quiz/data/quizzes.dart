import '../domain/question.dart';
import '../domain/quiz.dart';

final List<Quiz> quizzes = [
  // Flutter Basics Quiz
  Quiz(
    id: 'flutter_basics_01',
    title: 'Flutter Basics',
    description: 'Test your knowledge of fundamental Flutter concepts and widgets',
    timeForQuiz: 600, // 10 minutes in seconds
    questions: [
      Question(
        id: 'q1',
        questionText: 'What is Flutter?',
        options: [
          'A database management system',
          'A UI toolkit for building native applications',
          'A programming language',
          'A web server framework'
        ],
        correctAnswerIndex: 1
      ),
      Question(
        id: 'q2',
        questionText: 'Which programming language is used for Flutter development?',
        options: [
          'Java',
          'Python',
          'Dart',
          'JavaScript'
        ],
        correctAnswerIndex: 2
      ),
      Question(
        id: 'q3',
        questionText: 'What is a Widget in Flutter?',
        options: [
          'A database table',
          'A UI component',
          'A network request',
          'A file format'
        ],
        correctAnswerIndex: 1
      ),
      Question(
        id: 'q4',
        questionText: 'What is the purpose of setState() in Flutter?',
        options: [
          'To create a new widget',
          'To trigger a rebuild of the widget',
          'To handle HTTP requests',
          'To define app routes'
        ],
        correctAnswerIndex: 1
      ),
      Question(
        id: 'q5',
        questionText: 'Which widget is used to create a scrollable list?',
        options: [
          'Container',
          'Row',
          'ListView',
          'Column'
        ],
        correctAnswerIndex: 2
      ),
      Question(
        id: 'q6',
        questionText: 'What is hot reload in Flutter?',
        options: [
          'Restarting the entire application',
          'Updating UI without losing state',
          'Clearing app cache',
          'Debugging tool'
        ],
        correctAnswerIndex: 1
      ),
      Question(
        id: 'q7',
        questionText: 'Which widget is used for creating a button in Flutter?',
        options: [
          'ButtonWidget',
          'ElevatedButton',
          'PressableWidget',
          'TouchWidget'
        ],
        correctAnswerIndex: 1
      ),
      Question(
        id: 'q8',
        questionText: 'What is the purpose of pubspec.yaml file?',
        options: [
          'To store user data',
          'To manage dependencies and assets',
          'To define widget structure',
          'To handle routing'
        ],
        correctAnswerIndex: 1
      ),
      Question(
        id: 'q9',
        questionText: 'What is the main() function in Flutter?',
        options: [
          'Optional function',
          'Entry point of the application',
          'Database configuration',
          'Widget testing function'
        ],
        correctAnswerIndex: 1
      ),
      Question(
        id: 'q10',
        questionText: 'Which widget is used to create a screen in Flutter?',
        options: [
          'Screen',
          'Page',
          'Scaffold',
          'Window'
        ],
        correctAnswerIndex: 2
      ),
    ],
  ),

  // Git Basics Quiz
  Quiz(
    id: 'git_basics_01',
    title: 'Git Basics',
    description: 'Test your knowledge of basic Git commands and concepts',
    timeForQuiz: 600,
    questions: [
      Question(
        id: 'q1',
        questionText: 'What is Git?',
        options: [
          'A programming language',
          'A version control system',
          'A web framework',
          'A database system'
        ],
        correctAnswerIndex: 1
      ),
      Question(
        id: 'q2',
        questionText: 'What command initializes a new Git repository?',
        options: [
          'git start',
          'git init',
          'git begin',
          'git create'
        ],
        correctAnswerIndex: 1
      ),
      Question(
        id: 'q3',
        questionText: 'What command stages changes for commit?',
        options: [
          'git add',
          'git commit',
          'git stage',
          'git push'
        ],
        correctAnswerIndex: 0
      ),
      Question(
        id: 'q4',
        questionText: 'What does git pull do?',
        options: [
          'Push changes to remote',
          'Create a new branch',
          'Fetch and merge remote changes',
          'Show commit history'
        ],
        correctAnswerIndex: 2
      ),
      Question(
        id: 'q5',
        questionText: 'How do you create a new branch?',
        options: [
          'git branch-create',
          'git checkout -b',
          'git new-branch',
          'git make-branch'
        ],
        correctAnswerIndex: 1
      ),
      Question(
        id: 'q6',
        questionText: 'What command shows the commit history?',
        options: [
          'git history',
          'git show',
          'git log',
          'git commits'
        ],
        correctAnswerIndex: 2
      ),
      Question(
        id: 'q7',
        questionText: 'What is a merge conflict?',
        options: [
          'A corrupted repository',
          'When Git cant automatically merge changes',
          'A broken commit',
          'An invalid branch name'
        ],
        correctAnswerIndex: 1
      ),
      Question(
        id: 'q8',
        questionText: 'What does git clone do?',
        options: [
          'Creates a copy of a repository',
          'Copies a single file',
          'Creates a new branch',
          'Merges two branches'
        ],
        correctAnswerIndex: 0
      ),
      Question(
        id: 'q9',
        questionText: 'What is a remote in Git?',
        options: [
          'A local branch',
          'A backup file',
          'A server hosting your repository',
          'A commit message'
        ],
        correctAnswerIndex: 2
      ),
      Question(
        id: 'q10',
        questionText: 'What command shows modified files?',
        options: [
          'git modified',
          'git status',
          'git changes',
          'git show'
        ],
        correctAnswerIndex: 1
      ),
    ],
  ),

  // Data Structures Basics Quiz
  Quiz(
    id: 'data_structures_01',
    title: 'Data Structures Basics',
    description: 'Test your knowledge of fundamental data structures',
    timeForQuiz: 600,
    questions: [
      Question(
        id: 'q1',
        questionText: 'What is an array?',
        options: [
          'A linked list implementation',
          'A collection of elements stored at contiguous memory locations',
          'A tree-based data structure',
          'A hash table variant'
        ],
        correctAnswerIndex: 1
      ),
      Question(
        id: 'q2',
        questionText: 'What is the time complexity of searching in a binary search tree?',
        options: [
          'O(1)',
          'O(n)',
          'O(log n)',
          'O(n²)'
        ],
        correctAnswerIndex: 2
      ),
      Question(
        id: 'q3',
        questionText: 'What is a stack?',
        options: [
          'FIFO data structure',
          'LIFO data structure',
          'Random access structure',
          'Hierarchical structure'
        ],
        correctAnswerIndex: 1
      ),
      Question(
        id: 'q4',
        questionText: 'What is a queue?',
        options: [
          'FIFO data structure',
          'LIFO data structure',
          'Random access structure',
          'Hierarchical structure'
        ],
        correctAnswerIndex: 0
      ),
      Question(
        id: 'q5',
        questionText: 'What is a linked list?',
        options: [
          'A continuous memory block',
          'A collection of nodes with pointers',
          'A binary tree variant',
          'A hash table implementation'
        ],
        correctAnswerIndex: 1
      ),
      Question(
        id: 'q6',
        questionText: 'What is a hash table?',
        options: [
          'A sorted array',
          'A data structure that implements key-value mapping',
          'A type of tree',
          'A linked list variant'
        ],
        correctAnswerIndex: 1
      ),
      Question(
        id: 'q7',
        questionText: 'What is the time complexity of array insertion?',
        options: [
          'O(1)',
          'O(n)',
          'O(log n)',
          'O(n²)'
        ],
        correctAnswerIndex: 1
      ),
      Question(
        id: 'q8',
        questionText: 'What is a binary tree?',
        options: [
          'A tree with any number of children',
          'A tree where each node has at most two children',
          'A type of linked list',
          'A circular data structure'
        ],
        correctAnswerIndex: 1
      ),
      Question(
        id: 'q9',
        questionText: 'What is a graph?',
        options: [
          'A linear data structure',
          'A collection of nodes and edges',
          'A type of array',
          'A sorting algorithm'
        ],
        correctAnswerIndex: 1
      ),
      Question(
        id: 'q10',
        questionText: 'What is the main advantage of a balanced tree?',
        options: [
          'Less memory usage',
          'Guaranteed O(log n) operations',
          'Simpler implementation',
          'Faster insertion'
        ],
        correctAnswerIndex: 1
      ),
    ],
  ),

  // Mathematics Quiz
  Quiz(
    id: 'mathematics_01',
    title: 'Mathematics Basics',
    description: 'Test your knowledge of basic mathematical concepts',
    timeForQuiz: 600,
    questions: [
      Question(
        id: 'q1',
        questionText: 'What is the value of π (pi) to two decimal places?',
        options: [
          '3.14',
          '3.16',
          '3.12',
          '3.18'
        ],
        correctAnswerIndex: 0
      ),
      Question(
        id: 'q2',
        questionText: 'What is the square root of 144?',
        options: [
          '10',
          '12',
          '14',
          '16'
        ],
        correctAnswerIndex: 1
      ),
      Question(
        id: 'q3',
        questionText: 'What is the result of 7 × 8?',
        options: [
          '54',
          '56',
          '58',
          '52'
        ],
        correctAnswerIndex: 1
      ),
      Question(
        id: 'q4',
        questionText: 'What is the sum of angles in a triangle?',
        options: [
          '180 degrees',
          '360 degrees',
          '90 degrees',
          '270 degrees'
        ],
        correctAnswerIndex: 0
      ),
      Question(
        id: 'q5',
        questionText: 'What is 25% of 200?',
        options: [
          '25',
          '50',
          '75',
          '100'
        ],
        correctAnswerIndex: 1
      ),
      Question(
        id: 'q6',
        questionText: 'What is the area formula for a circle?',
        options: [
          'πr',
          '2πr',
          'πr²',
          '2πr²'
        ],
        correctAnswerIndex: 2
      ),
      Question(
        id: 'q7',
        questionText: 'What is the result of 5³?',
        options: [
          '15',
          '75',
          '125',
          '25'
        ],
        correctAnswerIndex: 2
      ),
      Question(
        id: 'q8',
        questionText: 'What is the next number in the sequence: 2, 4, 8, 16, ...?',
        options: [
          '24',
          '32',
          '20',
          '28'
        ],
        correctAnswerIndex: 1
      ),
      Question(
        id: 'q9',
        questionText: 'What is the result of 15 ÷ 3?',
        options: [
          '3',
          '5',
          '6',
          '4'
        ],
        correctAnswerIndex: 1
      ),
      Question(
        id: 'q10',
        questionText: 'What is the perimeter of a square with side length 5?',
        options: [
          '25',
          '20',
          '15',
          '10'
        ],
        correctAnswerIndex: 1
      ),
    ],
  ),

Quiz(
    id: 'science_basics_01',
    title: 'Science Basics',
    description: 'Test your knowledge of fundamental scientific concepts',
    timeForQuiz: 600,
    questions: [
      Question(
        id: 'q1',
        questionText: 'What is the chemical symbol for water?',
        options: ['H2O', 'O2', 'CO2', 'NaCl'],
        correctAnswerIndex: 0,
      ),
      Question(
        id: 'q2',
        questionText: 'What planet is known as the Red Planet?',
        options: ['Earth', 'Mars', 'Venus', 'Jupiter'],
        correctAnswerIndex: 1,
      ),
      Question(
        id: 'q3',
        questionText: 'What force keeps us on the ground?',
        options: ['Friction', 'Magnetism', 'Gravity', 'Electricity'],
        correctAnswerIndex: 2,
      ),
      Question(
        id: 'q4',
        questionText: 'What is the boiling point of water in Celsius?',
        options: ['50°C', '100°C', '150°C', '200°C'],
        correctAnswerIndex: 1,
      ),
      Question(
        id: 'q5',
        questionText: 'What gas do plants absorb from the atmosphere?',
        options: ['Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Hydrogen'],
        correctAnswerIndex: 1,
      ),
    ],
  ),

  // History Basics Quiz
  Quiz(
    id: 'history_basics_01',
    title: 'History Basics',
    description: 'Test your knowledge of historical events and figures',
    timeForQuiz: 600,
    questions: [
      Question(
        id: 'q1',
        questionText: 'Who was the first President of the United States?',
        options: ['George Washington', 'Abraham Lincoln', 'John Adams', 'Thomas Jefferson'],
        correctAnswerIndex: 0,
      ),
      Question(
        id: 'q2',
        questionText: 'In which year did World War II end?',
        options: ['1942', '1945', '1950', '1939'],
        correctAnswerIndex: 1,
      ),
      Question(
        id: 'q3',
        questionText: 'Who is known as the "Father of Computers"?',
        options: ['Charles Babbage', 'Alan Turing', 'Thomas Edison', 'Nikola Tesla'],
        correctAnswerIndex: 0,
      ),
      Question(
        id: 'q4',
        questionText: 'Which empire built the Great Wall of China?',
        options: ['Roman Empire', 'Mughal Empire', 'Chinese Empire', 'Ottoman Empire'],
        correctAnswerIndex: 2,
      ),
      Question(
        id: 'q5',
        questionText: 'What was the name of the ship that carried the Pilgrims to America in 1620?',
        options: ['Santa Maria', 'Mayflower', 'Endeavour', 'Victoria'],
        correctAnswerIndex: 1,
      ),
    ],
  ),

  // Geography Basics Quiz
  Quiz(
    id: 'geography_basics_01',
    title: 'Geography Basics',
    description: 'Test your knowledge of world geography',
    timeForQuiz: 600,
    questions: [
      Question(
        id: 'q1',
        questionText: 'What is the largest continent on Earth?',
        options: ['Africa', 'Asia', 'Europe', 'North America'],
        correctAnswerIndex: 1,
      ),
      Question(
        id: 'q2',
        questionText: 'What is the longest river in the world?',
        options: ['Nile', 'Amazon', 'Yangtze', 'Mississippi'],
        correctAnswerIndex: 1,
      ),
      Question(
        id: 'q3',
        questionText: 'Which country has the largest population?',
        options: ['India', 'United States', 'China', 'Indonesia'],
        correctAnswerIndex: 2,
      ),
      Question(
        id: 'q4',
        questionText: 'What is the capital city of France?',
        options: ['Berlin', 'Madrid', 'Paris', 'Rome'],
        correctAnswerIndex: 2,
      ),
      Question(
        id: 'q5',
        questionText: 'Which ocean is the largest?',
        options: ['Atlantic', 'Indian', 'Pacific', 'Arctic'],
        correctAnswerIndex: 2,
      ),
    ],
  ),

  // Programming Basics Quiz
  Quiz(
    id: 'programming_basics_01',
    title: 'Programming Basics',
    description: 'Test your knowledge of general programming concepts',
    timeForQuiz: 600,
    questions: [
      Question(
        id: 'q1',
        questionText: 'What does "HTML" stand for?',
        options: ['Hypertext Markup Language', 'Hypertext Machine Language', 'Hyper Transfer Language', 'High-Level Text Language'],
        correctAnswerIndex: 0,
      ),
      Question(
        id: 'q2',
        questionText: 'What is the main function of a compiler?',
        options: ['Execute code', 'Translate code to machine language', 'Debug code', 'Test software'],
        correctAnswerIndex: 1,
      ),
      Question(
        id: 'q3',
        questionText: 'What does "OOP" stand for?',
        options: ['Object-Oriented Programming', 'Online Operating Platform', 'Operating Object Protocol', 'Organized Output Process'],
        correctAnswerIndex: 0,
      ),
      Question(
        id: 'q4',
        questionText: 'What is the primary use of Python?',
        options: ['Web development', 'Data science', 'Automation', 'All of the above'],
        correctAnswerIndex: 3,
      ),
      Question(
        id: 'q5',
        questionText: 'Which data structure uses the principle of LIFO?',
        options: ['Queue', 'Stack', 'Array', 'Graph'],
        correctAnswerIndex: 1,
      ),
    ],
  ),
];

