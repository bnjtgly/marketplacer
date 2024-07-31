
# Marketplacer E-commerce Platform

## Installation
1. Install Ruby

## Running app locally
1. Clone the repository
2. Navigate to the Project Directory
```bash
cd marketplacer
```
3. Install Dependencies
```bash
bundle install
```

## Running the Application
To run the application, use the following command:
```bash
ruby bin/checkout_app.rb
```

## Running Tests
To run the tests, use the following command:
```bash
bundle exec rspec
```

## Application Menu
Once the application starts, you will see a menu with options. Here’s how to interact with it:
<img width="920" alt="image (3)" src="https://github.com/user-attachments/assets/aae901eb-238d-4f7f-8a0f-3ce0c3cd04e0">

### Menu Options
1. Load Products from File
- Description: Load products from a JSON file into the application.
- Command: Select option 1.
- Instructions: You will be prompted to enter the file path of the JSON file containing product data. Enter the path and press Enter.
- Sample Run:
- ```Enter the file path for the products JSON file (or type 'done' to finish): products.json```
- ```Enter the file path for the products JSON file (or type 'done' to finish): products2.json```
2. List Products
- Description: Display all the products currently loaded into the application.
- Command: Select option 2.
- Instructions: The application will show a list of all loaded products with their names and prices.

3. Add Product to Cart
- Description: Add a product to your shopping cart.
- Command: Select option 3.
- Instructions: You will be prompted to enter the product number and quantity. Enter the number corresponding to the product you want to add and the quantity, then press Enter.

4. View Cart
- Description: Display the contents of your shopping cart.
- Command: Select option 4.
- Instructions: The application will show a summary of items in your cart along with their quantities and prices.

5. Checkout
- Description: Complete your purchase and finalize the transaction.
- Command: Select option 5.
- Instructions: The application will display available discount thresholds and the contents of your cart. After viewing, it will thank you for your purchase and end the session if the checkout is successful.

6. Exit
- Description: Close the application.
- Command: Select option 6.
- Instructions: The application will print a goodbye message and exit.
