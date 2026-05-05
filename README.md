# calendar

## How to run

[Set up and test drive Flutter](https://docs.flutter.dev/install/quick) 

Above's a guide from Flutter on how to run flutter.

If I were to set it up I would go through the guide all the way through point 2 of [Test drive Flutter](https://docs.flutter.dev/install/quick#test-drive) "Run your app on the web" to see that I get the template program running.

After that you can just open this project in the IDE, select target and run.

Target can be Chrome so you don't have to set up an emulator.

## Project functionality

The app has three main pages: Home, Calendar and Settings. Navigation at the bottom.

### Home page

The app enters on the home page which has a text input.

What you enter here will display on the top of all pages purely cosmetically.

You could enter something like "My calendar".

### Settings page

The settings page has a dark mode toggle.

I shouldn't critique my own app here but I must advise to use the app in light mode since dark mode, at least for me, makes some things harder to see.

### Calendar page

The calendar page has three sub-pages: Holidays, Events and Browse. Navigation at top.

#### Holidays and Events sub-pages

In the Holidays and Events sub-pages you have a calendar view with dots at the dates with an occasion (event or holiday).

If you select a date with dots the occasions will be listed at the bottom.

There is an option to delete events in the list.

You can create occasions with the add button below the calendar table and toggle the monthly view to weekly with the button in the top right.

#### Browse sub-page

In the Browse sub-page you can import holidays from different countries.

Search the list with the text input at the top.

Click a country name to import.

The holidays will show in the Holidays sub-page.

## Project goals

### Musts

Self made, deletable events in monthly and weekly view.

### Should

Browsable and searchable imported events.

Persistence. Edit.

### Nice

User log-ins.

User groups / event list subscriptions.

Auth, roles, ownership.

## AI 🤖

AI was used throughout the project but with general restraint.

#### Code creation

Any code creation avoided generating many components at once.

Code context wasn't explicitly given but rather verbally prompted with the relevant terminology.

Created code wasn't further prompted in its own context.

This resulted in needing to fit the concept of a solution in the generated code to the project code manually.

#### Troubleshooting

The web search engine's AI response often gave a solution.

For troubleshooting code was explicitly given a couple of times.