## **Weather Tracker App**

### **Overview**

The **Weather Tracker App** is a simple iOS application built with **Swift** and **SwiftUI**. It allows users to search for cities and view real-time weather information, including:

- City name
- Temperature
- Weather condition (with an icon)
- Humidity
- UV Index
- "Feels Like" temperature

The app uses the **MVVM architecture**, with **dependency injection** to ensure clean, testable code. User preferences (selected city) are persisted across app launches using **UserDefaults**.

---

### **Features**

1. **Home Screen**:
    - Displays weather data for the selected city.
    - Shows a search bar for finding new cities.
    - If no city is selected, displays an empty state with **"No City Selected"** and prompts users to search for a city.
2. **Search Behavior**:
    - Users can search for cities using the search bar.
    - On selecting a city from search results, the app updates the weather data and persists the city across app launches.
3. **Error Handling**:
    - Graceful handling of network errors or invalid cities, with an appropriate error message displayed to the user.
4. **Persistence**:
    - Selected city is saved using **UserDefaults**, ensuring the app remembers the user’s choice between launches.

---

### **Tech Stack**

- **Language**: Swift
- **UI Framework**: SwiftUI
- **Architecture**: MVVM
- **Data Persistence**: UserDefaults
- **Networking**: URLSession (with WeatherAPI integration)
- **Dependency Injection**: Ensures modular, testable code.

---

### **Installation and Setup**

### **Prerequisites**

- macOS with the latest version of **Xcode** installed.
- A valid API key from [WeatherAPI.com](https://www.weatherapi.com/).

### **Steps to Run the App**

1. Clone the repository:
    
    ```bash
    bash
    Copy code
    git clone https://github.com/your-repo/weather-tracker.git
    
    ```
    
2. Open the project in Xcode:
    
    ```bash
    bash
    Copy code
    cd weather-tracker
    open WeatherTracker.xcodeproj
    
    ```
    
3. Update the API Key:
    - Navigate to `WeatherService.swift`.
    - Replace `YOUR_API_KEY` with your WeatherAPI key:
        
        ```swift
        swift
        Copy code
        private let apiKey = "YOUR_API_KEY"
        
        ```
        
4. Run the app on a simulator or device:
    - Select a device or simulator in the Xcode toolbar.
    - Press **Cmd+R** or click **Run**.

---

### **Known Issues**

### **Folder Structure**

During the project, I encountered technical issues with the **updated Xcode project structure**, which prevented me from creating custom folders for better organization. As a developer, I am **big on clean code and organized folder structures**, but to save time and meet the assignment deadline, I decided to move forward without the ideal structure.

### **Future Improvements**:

- Properly restructure the project to follow a clean folder hierarchy, such as:
    
    ```
    Copy code
    WeatherTracker
    ├── Models
    ├── Views
    ├── ViewModels
    ├── Services
    ├── Resources
    
    ```
    
- Investigate and resolve the Xcode folder creation issue for future projects.

---

### 

### **How I Handled Challenges**

- **Technical Limitations**: When Xcode wouldn’t let me create folders as expected, I chose to focus on completing the app’s functionality over spending time debugging the issue.
- **Time Constraints**: I prioritized functionality and clean code, ensuring the app meets the assignment's requirements while managing my time effectively.

---

### **Future Enhancements**

1. **Unit Tests**:
    - Add test coverage for `WeatherViewModel` and `PersistenceManager` to validate their behavior.
2. **Folder Structure**:
    - Refactor the project with a better folder structure for scalability and maintainability.
3. **Error Messages**:
    - Improve user-facing error messages with retry functionality for network issues.
