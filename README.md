# Tech News - Flutter App

A Flutter application that displays tech news summaries from the last 24 hours, built as part of the **Gemini API for Flutter Developers** workshop conducted at **Road to DevFest 2025**.

## 📱 Screenshots

<div align="center">
  <img src="images/ss1.png" width="200" alt="Screenshot 1" />
  <img src="images/ss2.png" width="200" alt="Screenshot 2" />
  <img src="images/ss3.png" width="200" alt="Screenshot 3" />
</div>

## 🎯 About This Project

This project was initially prototyped using **v0.dev** to generate the UI design. The codebase was then revamped and refactored into a clean **BLoC (Business Logic Component) architecture** using **komposo.ai** and **Cursor IDE** for improved code organization, maintainability, and scalability.

## 🏗️ Architecture

This project follows the **BLoC (Business Logic Component) pattern** with a clean architecture structure:

```
lib/
├── bloc/              # BLoC layer (events, states, bloc)
├── data/              # Data layer
│   ├── datasources/   # Remote data sources
│   ├── models/        # Data models
│   └── repositories/  # Repository implementations
└── presentation/      # UI layer
    ├── screens/       # App screens
    └── widgets/       # Reusable widgets
```

## 🚀 Features

- ✅ Fetch tech news summaries from the last 24 hours
- ✅ Clean BLoC architecture implementation
- ✅ Pull-to-refresh functionality
- ✅ Share Daily Brief bottom sheet UI
- ✅ Dark theme with modern UI design
- ⏳ Email sharing functionality (homework assignment)

## 📚 Tech Stack

- **Flutter** - Cross-platform UI framework
- **BLoC** - State management using `flutter_bloc`
- **HTTP** - API communication
- **Material Design** - UI components

## 🛠️ Getting Started

### Prerequisites

- Flutter SDK (3.7.2 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd tech_news
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## 📝 Workshop Homework Assignment

### Email Functionality Implementation

As part of the workshop, attendees are encouraged to complete the email sharing functionality as a homework assignment. The UI for the "Share Daily Brief" feature is already implemented, but the actual email sending logic needs to be added.

**What needs to be implemented:**
- Email sending functionality in the `ShareDailyBriefSheet` widget
- Integration with email service (in our case application integration on Google Cloud)
- Error handling for email operations
- Success/error feedback to users

**How to contribute:**
- Implement the email functionality
- Submit a Pull Request with your implementation
- Or create your own fork and share your solution

**Location of the code to modify:**
- `lib/presentation/widgets/share_daily_brief_sheet.dart` - The "Send Brief" button's `onPressed` callback (currently has a placeholder comment)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request or fork this repository for your own implementations.

## 📄 License

This project is part of the Road to DevFest 2025 workshop materials.

## 🙏 Acknowledgments

- **v0.dev** - Initial UI design and prototyping
- **komposo.ai** - UI revamp idea assistance
- **Cursor IDE** - Development environment and AI-powered refactoring
- **Road to DevFest 2025** - Workshop organizers and participants

---

Built with ❤️ for the Flutter developer community
