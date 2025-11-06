# Sandwich Shop App

A Flutter application for ordering customizable sandwiches with real-time order management.

## Features

- **Sandwich Type Selection**: Choose between Footlong and Six-inch sandwiches using a SegmentedButton
- **Bread Type Options**: Select from White, Wheat, or Wholemeal bread via dropdown menu
- **Quantity Management**: Add or remove items from your order with disable state at limits
- **Special Requests**: Add custom notes (e.g., "no onions", "extra pickles") to your sandwich
- **Order Display**: Real-time display of sandwich type, quantity, bread choice, and special notes
- **Quantity Limits**: Configurable maximum order quantity (default: 10)

## Project Structure

```
lib/
  main.dart                 # Main app entry point, UI widgets
  repositories/
    order_repository.dart   # Order state and quantity management
  views/
    app_styles.dart         # Text styles and app theming
```

## Installation & Setup

### Prerequisites
- Flutter SDK (latest stable)
- Dart SDK (included with Flutter)
- An IDE (VS Code, Android Studio, or IntelliJ)

### Steps

1. **Clone or navigate to the project**:
   ```bash
   cd ~/PAPL/sandwich_shop
   ```

2. **Get dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

## Usage Instructions

### Ordering a Sandwich

1. **Select Sandwich Type**: Use the SegmentedButton to choose between Footlong or Six-inch
2. **Choose Bread**: Select your preferred bread type (White, Wheat, Wholemeal) from the dropdown
3. **Add Special Notes** (optional): Type any special requests in the "Order note" text field
4. **Adjust Quantity**: 
   - Press **Add** to increase order quantity
   - Press **Remove** to decrease quantity
   - Buttons disable when you reach the quantity limit (default max: 5)
5. **View Order**: The OrderItemDisplay shows your current selection in real-time

### UI Components

- **SegmentedButton**: Quick sandwich size selection
- **DropdownMenu**: Bread type chooser
- **TextField**: Notes input for special requests
- **ElevatedButtons**: Add/Remove quantity (contextually disabled at limits)
- **StyledButton**: Custom-styled action buttons

## Configuration

### Change Max Quantity
Edit the `maxQuantity` parameter in `main.dart`:
```dart
home: OrderScreen(maxQuantity: 10), // change this value
```

## Tech Stack

- **Flutter**: UI framework
- **Dart**: Programming language
- **Material Design 3**: UI components and theming

## Future Enhancements

- Order summary and checkout
- Payment integration
- Order history
- Menu customization (toppings, sauces)
- Nutritional information display

---

For questions or issues, refer to the [Flutter documentation](https://flutter.dev/docs).