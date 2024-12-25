# Todo App

A new Flutter project for managing tasks efficiently.

## Features

- **Task Creation**: Add new tasks with titles, descriptions, due dates, and priorities.
- **Task Editing**: Edit existing tasks to update their details.
- **Task Deletion**: Swipe to delete tasks from the list.
- **Task Completion**: Mark tasks as completed with a checkbox.
- **Sorting**: Sort tasks by different criteria including due date, priority, and completion status.
- **Persistent Storage**: Store tasks locally using ObjectBox for persistent storage.

## Usage

1. **Home Page**: Displays a list of tasks with their titles, descriptions, due dates, and priorities.
2. **Add Task**: Use the floating action button to navigate to the task creation screen.
3. **Edit Task**: Tap on a task to navigate to the task editing screen.
4. **Delete Task**: Swipe left on a task to delete it.
5. **Sort Tasks**: Use the sort icon in the app bar to sort tasks by different criteria.

## Theme

The app uses a custom theme with Material 3 support, including custom color schemes, text themes, and widget themes for a consistent look and feel.

## Dependencies

- `flutter_riverpod`: State management solution.
- `freezed_annotation`, `json_annotation`, `objectbox`: For data modeling and persistence.
- `intl`: For date formatting.
- `path_provider`, `path`: For file system paths.

## Development

To run the app, ensure you have Flutter installed and configured. Use the following commands to get started:

```sh
# Get dependencies
flutter pub get

# Run the app
flutter run
