# shoesly

PrioritySoft Coding Test Project

## Getting Started

This project is developed using Flutter.

Make sure to run 'flutter pub get' after cloning into this repo, to avoid dependency issues.

### Project structure

The directories are mainly based on the features as per the design provided. 

The project is structured as:

- lib
  - features
     - cart
     - discover
     - filter
     - order
  - styles
  - widgets
  providers
  firebase_options
  main

### Architecture

The project is based on the MVC architecture. 

So, each individual feature is going to have sub-directories for its model, view & controller.

This has kept the project simple in the sense that there aren't many layers.

The models are basically Model classes, that replicate the structure of data in Firebase.

The views are mostly ConsumerWidget or StatelessWidget, and represent the UI.

The use of StatefulWidget is done only at one place, where the UI has to be updated

within a ModalBottomSheet.

The controller for all features is a class, that extends the StateNotifier. 

The controller contains methods, that are referenced through the view, 

with the help of providers. 

### State Management

The state is managed using Riverpod.

Inside providers.dart, there are numerous providers, which are responsible for fetching and

updating the state and the UI. 

There are other providers, which are created for referencing the controllers.

These providers access the methods within the controllers, which handles the major functionality,

when methods are called from the UI.

### Firebase structure

The database structure is kept as flat as possible, to ensure that there aren't many documents.

There is a main collection - brands, and inside that collection, there are documents,

with the name of the brands as document ID, which are static.

Inside each brand document, there is a field which is an array of maps, called shoes. 

Each member of the array contains info related to the shoes, and has the respective fields,

like name, brand, size etc., which is the data that is accessed through methods in the Frontend.

Orders are also stored in the database, when a user places an order.

The orders are added with a random document ID for simplicity.

### Issues

ColorFiltered widget overflows color to the parent widget

Link to ColorFiltered issue: https://github.com/flutter/flutter/issues/148732
