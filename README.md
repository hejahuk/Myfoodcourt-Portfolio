# 🍽️ My Food Court

**A Flutter food-court ordering prototype for campus dining.**

My Food Court is a student-built mobile-style app designed around the food-ordering experience at **Singapore Polytechnic Food Court 1**. Users can explore stalls, customize dishes, save favourites, manage a cart, and walk through a demo checkout and order-tracking experience.

> **Project status:** Student prototype. The checkout and order history are demonstrations; the app does **not** process real payments or send orders to a food stall.

## ✨ Features

### 🍜 Discover and customize food
- **Home:** Featured food cards and a carousel.
- **Stores:** Browse stalls by category, view featured stalls, and search for stall names.
- **Menus:** Customize chicken rice, noodles, drinks, and wraps with available options and add-ons.
- **Live calculations:** Update the displayed price and estimated calories when meal options or quantities change.
- **Favourites:** Add or remove customized items from your favourites.

### 🛒 Cart, checkout and orders
- Add customized meals to a shopping cart and adjust quantities.
- Review an order summary with a **S$0.50 demo service fee** and **9% GST calculation**.
- Calculate the cost per person with the **Split Bill** option.
- Choose a displayed payment option: **PayNow**, **Credit/Debit Card**, or **Cash**.
- Select a **No Plastic Cutlery** preference.
- Place a demo order, receive a generated order number, and view it in **My Orders**.
- See a sample preparation status and a simulated preparation-time estimate.

**Important:** Payment options are UI selections only. Orders and favourites are kept in app memory through GetX controllers, not synced to a live restaurant or permanently saved as order records. Store/menu listings are currently sample data, and estimated preparation times are simulated.

### 👤 Accounts and interface
- Email/password sign-up and login through Firebase Authentication.
- Email-verification flow and Google sign-in integration.
- User profile data backed by Cloud Firestore.
- Profile-editing screens for name, username, phone number, and picture.
- Onboarding screens, loading animation, and light/dark appearance based on the device theme.
- Four main navigation tabs: **Home**, **Stores**, **Favorite**, and **Profile**.

## 🖼️ Project artwork

The repository contains these onboarding images. Screenshots of the running app can be added in a future update.

| Onboarding artwork 1 | Onboarding artwork 2 | Onboarding artwork 3 |
|:--:|:--:|:--:|
| <img src="assets/img/searching_onboard.png" width="220" alt="First onboarding illustration"> | <img src="assets/img/second_onboard.png" width="220" alt="Second onboarding illustration"> | <img src="assets/img/third_onboard.png" width="220" alt="Third onboarding illustration"> |

## 🛠️ Tech stack

| Technology | Role |
| --- | --- |
| **Flutter + Dart** | Cross-platform UI and application code |
| **Firebase Authentication** | Email/password authentication, verification, and Google sign-in |
| **Cloud Firestore** | User-profile records |
| **GetX** (`get`) | Navigation, controllers, and reactive UI state |
| **GetStorage** | Local key-value storage |
| **Google Sign-In** | Google authentication flow |
| **cached_network_image** | Displaying account photos from Google sign-in |
| **carousel_slider / smooth_page_indicator** | Carousel and page indicators |
| **Lottie** | Loading animation |
| **flutter_native_splash** | Native splash-screen setup |

Other UI packages include `iconsax_flutter` and `readmore`. See [pubspec.yaml](pubspec.yaml) for the full dependency list.

## 🚀 Getting started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) with a Dart version compatible with `pubspec.yaml` (currently `^3.12.2`).
- Android Studio or VS Code with Flutter tooling; a supported device or emulator.
- Your own Firebase project. The app initializes Firebase at startup.

### 1. Clone the repository

```bash
git clone https://github.com/hejahuk/Myfoodcourt-Portfolio.git
cd Myfoodcourt-Portfolio
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Configure Firebase

This portfolio copy bundles its demo artwork. To start the app, generate `lib/firebase_options.dart` for your own project. Local Firebase configuration is excluded from Git.

For your own Firebase project:

1. Create a project in the [Firebase Console](https://console.firebase.google.com/).
2. Enable the **Email/Password** sign-in provider, and configure **Google** sign-in if you plan to use it.
3. Create **Cloud Firestore**. For the `users/{uid}` documents, allow each signed-in user to read and write only their own document.
4. Follow the [FlutterFire setup guide](https://firebase.google.com/docs/flutter/setup) and run `flutterfire configure` to generate platform settings for your Firebase project.
5. Complete any platform-specific Google sign-in setup required by Firebase (such as Android app registration).

Do not put service-account private keys or other secret credentials in Git.

### 4. Run the application

```bash
flutter run
```

To check your local Flutter environment first:

```bash
flutter doctor
```

> **Note:** Running on a platform does not guarantee every authentication provider is configured for that platform. Review Firebase setup if login fails.

## 🗂️ Project structure

```text
Myfoodcourt-Portfolio/
├── android/                 # Android platform files
├── assets/
│   ├── animations/         # Lottie animation
│   └── img/                # Local images and onboarding artwork
├── lib/
│   ├── main.dart           # Firebase and controller initialization
│   ├── app.dart            # App theme and entry screen
│   ├── homePage.dart       # Bottom navigation
│   ├── Pages/              # Home, stores, favourites, profile tab
│   ├── features/
│   │   ├── controller/     # Cart, favourites, orders, auth-related state
│   │   └── screens/        # Onboarding, products, cart, checkout, orders, profile
│   ├── utilies/            # Models, validation, Firebase repositories, themes
│   └── widgets/            # Reusable UI widgets
├── test/
├── web/
├── windows/
└── pubspec.yaml
```

Directory names above follow the repository as currently written (including `utilies`).

## 🔄 Demo user flow

```text
Onboarding → Sign up / Log in → Home or Stores
                                  ↓
                           Select a product
                                  ↓
                         Customize your meal
                                  ↓
                         Add to cart / Favourite
                                  ↓
                           Review checkout
                                  ↓
                            Place demo order
                                  ↓
                              My Orders
```

## 🚧 Current limitations and ideas for improvement

This is a prototype rather than a production food-ordering system.

- **Sample menu data:** Move stall details and menus to a maintained database.
- **Demo checkout:** Integrate a real payment provider only with proper server-side verification.
- **In-memory orders:** Save orders to a backend and add actual stall-side order processing.
- **Simulated tracking:** Replace fixed order statuses and estimated preparation times with live updates.
- **Testing:** Expand automated tests for authentication, cart totals, and order flows.

## 📌 Project purpose

The project explores how Flutter, Firebase and reactive state management can support a more convenient campus food-ordering experience. It also demonstrates UI design, authentication, data handling, and an end-to-end ordering prototype.

---

**Repository:** [hejahuk/Myfoodcourt-Portfolio](https://github.com/hejahuk/Myfoodcourt-Portfolio)

**Built with Flutter & Firebase.**
