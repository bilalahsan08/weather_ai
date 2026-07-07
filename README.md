# 🌤️ Weather AI
A beautiful, modern, and intelligent weather application built with Flutter. It not only provides real-time weather forecasts using the **OpenWeatherMap API** but also leverages the power of **Google's Gemini AI** to give users contextual, smart suggestions based on the current weather (e.g., "It's raining and 15°C, wear a raincoat and grab an umbrella!").
## ✨ Features
- **Beautiful Glassmorphic UI**: A highly polished, modern interface with dynamic gradients that change based on the weather condition and time of day.
- **Smart AI Suggestions**: Integrated with Google Generative AI (Gemini) to provide actionable, natural-language advice based on temperature, humidity, and weather conditions.
- **Engaging Animations**: Uses high-quality Lottie animations to bring weather conditions to life.
- **Detailed Forecasts**: Provides current temperature, min/max temperatures, humidity, wind speed, visibility, and an hourly forecast timeline.
- **Clean Architecture**: Built using a strict MVC (Model-View-Controller) architecture for maintainability and scalability.
- **State Management**: Powered by **GetX** for reactive state management, keeping the UI perfectly in sync with the data.
## 🛠 Tech Stack
- **Framework**: Flutter (Dart)
- **State Management**: GetX
- **APIs**: 
  - [OpenWeatherMap API](https://openweathermap.org/api) (Weather Data)
  - [Google Gemini API](https://aistudio.google.com/) (AI Suggestions)
- **Key Packages**:
  - `google_generative_ai` (AI Integration)
  - `http` (Network Requests)
  - `lottie` (Animations)
  - `flutter_animate` (Micro-interactions and UI animations)
## 📱 Screenshots
*(Add screenshots of your beautiful UI here! Consider taking a screenshot of the Sunny state, the Rainy state, and the AI suggestion card on your phone and dragging them right here into the GitHub editor!)*
## 🚀 Getting Started
### Prerequisites
- Flutter SDK (`>=3.10.7`)
- An API key from [OpenWeatherMap](https://home.openweathermap.org/users/sign_up)
- An API key from [Google AI Studio](https://aistudio.google.com/app/apikey)
### Installation
1. **Clone the repository**
   ```bash
   git clone https://github.com/bilalahsan08/weather_ai.git
   cd weather_ai
   ```
2. **Get packages**
   ```bash
   flutter pub get
   ```
3. **Configure API Keys**
   For security, API keys are passed at compile-time using `--dart-define`.
   
   If you are using **VS Code**, create a `.vscode/launch.json` file:
   ```json
   {
       "version": "0.2.0",
       "configurations": [
           {
               "name": "Weather AI",
               "request": "launch",
               "type": "dart",
               "program": "lib/main.dart",
               "args": [
                   "--dart-define=OPENWEATHER_KEY=your_openweather_key_here",
                   "--dart-define=GEMINI_KEY=your_gemini_key_here"
               ]
           }
       ]
   }
   ```
   *(Note: Ensure `.vscode/` is added to your `.gitignore` so your keys are never pushed to GitHub!)*
4. **Run the app**
   ```bash
   flutter run
   ```
   Or simply hit `F5` in VS Code!
## 🏗 Architecture & Folder Structure
The project follows a modular **MVC** approach to separate UI, logic, and data.
```text
lib/
├── controllers/       # GetX Controllers handling business logic (WeatherController)
├── models/            # Data models (WeatherModel)
├── services/          # External API handlers (WeatherService, AiService)
├── utils/             # Helper classes (Constants, AnimationMapper)
├── views/             # UI Screens (HomeScreen)
└── widgets/           # Reusable UI components (AiSuggestionCard)
```
## 👨‍💻 Author
**Bilal Ahsan**
- GitHub: [@bilalahsan08](https://github.com/bilalahsan08)
- LinkedIn: *(Add your LinkedIn link here)*
---
*If you liked this project, please consider giving it a ⭐ on GitHub!*
