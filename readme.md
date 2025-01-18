
# Recipe Book App

This application created for searching different recipes with filters, query and sorting also you can add recipes to saved and see saved recipes later (saved recipes stored in in-memory database)

### Benefits: 
- Data reaches from real API
- Russian & English ui localization
- Light & Dark color scheme

## Running the app
###  1. Getting the api key
In this project used [`Spoonacular food API`](https://spoonacular.com/food-api), to run this app you must create your own account and copy an `API KEY` at [console page](https://spoonacular.com/food-api/console#Profile).

### 2. Environment variables
```env
# your api key from console
RECIPE_API_KEY = <YOUR_API_KEY>

# Spoonacular food API base url
RECIPE_API_BASE_URL = https://api.spoonacular.com

# base url to ingredients image storage, api produce only names of ingredients images, 
# this variable is used to create full url and access the ingredient image from app
RECIPE_API_INGREDIENTS_IMG_SERVER_BASE_URL = https://img.spoonacular.com/ingredients_100x100
```

